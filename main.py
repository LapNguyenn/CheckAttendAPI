from fastapi import FastAPI
from DBManager import DatabaseManager
from pydantic import BaseModel
from typing import List, Optional
from fastapi import Body

app = FastAPI()

class Student(BaseModel):
    DateTime: Optional[str]
    ID: str
    Status: str # 0 or 1

manager = DatabaseManager(server='DESKTOP-RGRSFGG\SQLEXPRESS', database='deploy_2', username='sa', password='sa')

@app.get("/connect/{userId}")
def connect(userId: int):
    print("aaaaaaaaaaaaaaaaa")
    df = manager.show_user(userId)
    return df

@app.get("/attendance/getlist/{ID}/{CurrentDateTime}")
def attendance_getlist(CurrentDateTime: str, ID: int):
    CurrentDateTime = CurrentDateTime.split("+")
    date = CurrentDateTime[0]
    time = CurrentDateTime[1]
    df = manager.show_by_time(date, time, ID)
    return df

# studentId/CurrentDateTime/Status
@app.post("/attendance/mark/")
async def attendance_mark(std_list: List[Student]):
    student_data_map = {}
    for std in std_list:
        if std.DateTime == "":
            std.DateTime = "1000-03-14+00:00:00"
        else:
            date, time = std.DateTime.split("+")
            student_data_map.setdefault((date, time), []).append((std.ID, std.Status))
    result = manager.attendance(student_data_map)
    return result

class Person(BaseModel):
    Code: str
    Name: str

@app.post("/insert/")
async def insert(person_list: List[Person]):
    person_data_map = {}
    for std in person_list:
        first_name, mid_name, last_name = std.Name.split(" ")
        last_name = mid_name +" "+ last_name

        person_data_map.setdefault(std.Code, []).append((first_name, last_name))
    result = manager.insert(person_data_map)
    return result



@app.get("/schedule/{userId}")
def show_schedule(userId: int):
    df = manager.show_schedule(userId)
    return df

    






