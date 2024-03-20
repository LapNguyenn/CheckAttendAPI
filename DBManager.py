import pyodbc
import pandas as pd

class DatabaseManager:
    def __init__(self, server, database, username, password):
        self.server = server
        self.database = database
        self.username = username
        self.password = password
        self.db = pyodbc.connect(f'DRIVER={{SQL Server}};SERVER={self.server};DATABASE={self.database};UID={self.username};PWD={self.password}')
        self.cursor = self.db.cursor()
    
    def insert(self, person_data_map: dict):
        try:
            for code, values in person_data_map.items():
                for first_name, last_name in values:
                    update_query = f"""
                    INSERT INTO [User] (code, first_name, last_name)
                    SELECT '{code}', '{first_name}', '{last_name}'
                    WHERE '{code}' NOT IN (SELECT code FROM [User]);
                    """
                result = self.execute(update_query)
                self.db.commit()
            return result
        except Exception as e:
            return "attendance cannot be taken"

    def attendance(self, student_data_map: dict):
        try:
            for (date, time), student_ids_and_statuses in student_data_map.items():
                student_ids = [student_id for student_id, _ in student_ids_and_statuses]
                student_ids_str = ','.join(map(str, student_ids))
                print(student_ids_str)
                
                update_query = f"""
                    UPDATE Attendances
                    SET Attendances.attendance_status = CASE
                """
                when_statements = []
                for student_id, status in student_ids_and_statuses:
                    when_statement = f"WHEN [User].code = '{student_id}' THEN {int(status)}"
                    when_statements.append(when_statement)
                update_query += "\n".join(when_statements)

                update_query += f"""
                    ELSE Attendances.attendance_status
                    END
                    FROM Attendances
                    JOIN TeachingSchedules ON Attendances.teaching_schedule_id = TeachingSchedules.teaching_schedule_id
                    JOIN Slot ON TeachingSchedules.slot_id = Slot.slot_id
                    JOIN Classes ON Classes.class_id = TeachingSchedules.class_id
                    JOIN [User] ON [User].user_id = Attendances.student_id
                    WHERE
                    [User].code IN ('{student_ids_str}') 
                    AND TeachingSchedules.teaching_day = CAST('{date}' AS DATE)
                """
                #("('" + "','".join(map(str, student_ids)) + "')")
                # CAST('{time}' AS TIME) BETWEEN CAST(Slot.start_time AS TIME) AND CAST(Slot.end_time AS TIME)
                # print(update_query)
                result = self.execute(update_query)
                self.db.commit()
            return result


        except Exception as e:
            return "attendance cannot be taken"

        
    def get_dataframe_from_table(self, table_name):
        query = f"SELECT * FROM {table_name}"
        return self.execute(query)
    
    def get_data_from_table(self, table_name, tp: str):
        if tp == 'numpy':
            return self.get_dataframe_from_table(table_name).values.astype(str)
        if tp == 'dict':
            return self.get_dataframe_from_table(table_name).to_dict(orient='records')
        return self.get_dataframe_from_table(table_name)
    
    def show_user(self, ID):
        update_query = f"""
        SELECT
        [User].code AS ID, 
        CONCAT([User].first_name, ' ', [User].last_name) AS Name, 
        [User].date_of_birth AS Date
        FROM [User] 
        where [User].user_id = {ID}"""
        print("bbbbbbbbbbbbbbb")
        result = self.execute(update_query)
        print(result)
        return result.to_dict(orient='records')[0]
   
    
    def show_by_time(self, date, time, ID):
        update_query = f"""
        SELECT DISTINCT * from
        (SELECT DISTINCT
            [User].code as ID,
            CONCAT([User].first_name, ' ', [User].last_name) AS Name,
            [User].date_of_birth AS Date,
            Attendances.attendance_status AS Status,
            Classrooms.classroom_name as Class_name
        FROM Attendances
        INNER JOIN TeachingSchedules ON Attendances.teaching_schedule_id = TeachingSchedules.teaching_schedule_id
        INNER JOIN Slot ON TeachingSchedules.slot_id = Slot.slot_id
        INNER JOIN Classrooms ON Classrooms.classroom_id = TeachingSchedules.classroom_id
        INNER JOIN [User] ON [User].user_id = Attendances.student_id
        WHERE
            CAST('{time}' AS TIME) BETWEEN CAST(Slot.start_time AS TIME) AND CAST(Slot.end_time AS TIME)
            AND TeachingSchedules.instructor_id = {ID}
            AND TeachingSchedules.teaching_day = CAST('{date}' AS DATE)) as A;
        """
        print(update_query)

        result = self.execute(update_query)
        return result.to_dict(orient='records')

    def show_schedule(self, ID):
        update_query = f"""
        SELECT 
        TeachingSchedules.slot_id, Classrooms.classroom_name, 
        Classes.class_name, [Subject].subject_name, [Subject].subject_material_url
        from TeachingSchedules 
        INNER JOIN [Subject] ON TeachingSchedules.subject_id = [Subject].subject_id
        INNER JOIN Classes ON Classes.class_id = TeachingSchedules.class_id
        INNER JOIN Classrooms ON Classrooms.classroom_id = TeachingSchedules.classroom_id
        where TeachingSchedules.instructor_id = {ID}"""

        result = self.execute(update_query)
        return result.to_dict(orient='records')[0]
    
    def execute(self, query: str):
        self.cursor.execute(query)
        try:
            df = pd.DataFrame.from_records(self.cursor.fetchall(), columns=[desc[0] for desc in self.cursor.description])
            return df
        except:
            return 
