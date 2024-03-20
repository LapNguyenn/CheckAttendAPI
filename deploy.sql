use master
CREATE DATABASE deploy_2;
GO

USE deploy_2;
GO

CREATE TABLE Role (
    role_id INT PRIMARY KEY IDENTITY(1,1),
    role_name NVARCHAR(MAX),
    status BIT
);
GO

CREATE TABLE [User] (
   user_id INT PRIMARY KEY IDENTITY(1,1),
   google_id NVARCHAR(255),
   email NVARCHAR(255),
   code NVARCHAR(255),
   first_name NVARCHAR(255),
   last_name NVARCHAR(255),
   avatar NVARCHAR(MAX),
   gender BIT,
   address NVARCHAR(MAX),
   phone NVARCHAR(MAX),
   date_of_birth NVARCHAR(MAX),
   major NVARCHAR(MAX),
   face_left_data NVARCHAR(MAX),
   face_right_data NVARCHAR(MAX),
   face_between_data NVARCHAR(MAX),
   cccd_frontside NVARCHAR(MAX),
   cccd_backside NVARCHAR(MAX),
   personal_identification NVARCHAR(MAX),
   role_id INT,
   refresh_token NVARCHAR(MAX),
   status BIT
);
GO

CREATE TABLE Semester (
   semester_id INT PRIMARY KEY IDENTITY(1,1),
   semester_name NVARCHAR(255),
   start_date DATE,
   end_date DATE
);
GO

CREATE TABLE Classes (
   class_id INT PRIMARY KEY IDENTITY(1,1),
   class_name NVARCHAR(255)
);
GO

CREATE TABLE UserClassSemester (
   ucs_id INT PRIMARY KEY IDENTITY(1,1),
   student INT,
   semester_id INT,
   class_id INT,
   status BIT
);
GO

CREATE TABLE Notification (
   notification_id INT PRIMARY KEY IDENTITY(1,1),
   user_id INT
);
GO

CREATE TABLE Classrooms (
   classroom_id INT PRIMARY KEY IDENTITY(1,1),
   classroom_name NVARCHAR(255),
   total_seat INT,
   status BIT
);
GO

CREATE TABLE Slot (
   slot_id INT PRIMARY KEY IDENTITY(1,1),
   start_time TIME,
   end_time TIME,
   status BIT
);
GO

CREATE TABLE Subject (
   subject_id INT PRIMARY KEY IDENTITY(1,1),
   subject_code NVARCHAR(255),
   subject_name NVARCHAR(255),
   subject_material_url NVARCHAR(MAX),
   total_lesson INT,
   status BIT
);
GO

CREATE TABLE UserSubjectSemester (
   uss_id INT PRIMARY KEY IDENTITY(1,1),
   user_id INT,
   subject_id INT,
   semester_id INT,
   status BIT
);
GO

CREATE TABLE TeachingSchedules (
   teaching_schedule_id INT PRIMARY KEY IDENTITY(1,1),
   instructor_id INT,
   class_id INT,
   classroom_id INT,
   subject_id INT,
   semester_id INT,
   teaching_day DATE,
   slot_id INT,
   status BIT,
);
GO

CREATE TABLE GradeComponents (
   grade_component_id INT PRIMARY KEY IDENTITY(1,1),
   grade_category_id INT,
   subject_id INT,
   status BIT
);
GO

CREATE TABLE GradeCategory (
   gradecategory_id INT PRIMARY KEY IDENTITY(1,1),
   gradecategory_name NVARCHAR(255),
   gradecategory_percent FLOAT
);
GO

CREATE TABLE ExamGenre (
   examgenre_id INT PRIMARY KEY IDENTITY(1,1),
   examgenre_name NVARCHAR(255),
   status BIT
);
GO

CREATE TABLE ExamSchedules (
   exam_schedule_id INT PRIMARY KEY IDENTITY(1,1),
   student_id INT,
   subject_id INT,
   semester_id INT,
   exam_type INT,
   exam_room INT,
   exam_date DATETIME,
   exam_score_announcement_date DATE
);
GO

CREATE TABLE Attendances (
   attendance_id INT PRIMARY KEY IDENTITY(1,1),
   student_id INT,
   teaching_schedule_id INT,
   attendance_time DATETIME,
   attendance_status BIT
);
GO

CREATE TABLE Grades (
   grade_id INT PRIMARY KEY IDENTITY(1,1),
   grade_category_id INT,
   semester_id INT,
   student_id INT,
   subject_id INT,
   grade FLOAT,
   comment NVARCHAR(MAX)
);
GO

-- Foreign Keys
ALTER TABLE [User] ADD FOREIGN KEY (role_id) REFERENCES Role (role_id);

ALTER TABLE  UserClassSemester  ADD FOREIGN KEY ( student ) REFERENCES  [User]  ( user_id );

ALTER TABLE  UserClassSemester  ADD FOREIGN KEY ( semester_id ) REFERENCES  Semester  ( semester_id );

ALTER TABLE  UserClassSemester  ADD FOREIGN KEY ( class_id ) REFERENCES  Classes  ( class_id );

ALTER TABLE  Notification  ADD FOREIGN KEY ( user_id ) REFERENCES  [User]  ( user_id );

ALTER TABLE  UserSubjectSemester  ADD FOREIGN KEY ( user_id ) REFERENCES  [User]  ( user_id );

ALTER TABLE  UserSubjectSemester  ADD FOREIGN KEY ( subject_id ) REFERENCES  Subject  ( subject_id );

ALTER TABLE  UserSubjectSemester  ADD FOREIGN KEY ( semester_id ) REFERENCES  Semester  ( semester_id );

ALTER TABLE  TeachingSchedules  ADD FOREIGN KEY ( instructor_id ) REFERENCES  [User]  ( user_id );

ALTER TABLE  TeachingSchedules  ADD FOREIGN KEY ( class_id ) REFERENCES  Classes  ( class_id );

ALTER TABLE  TeachingSchedules  ADD FOREIGN KEY ( classroom_id ) REFERENCES  Classrooms  ( classroom_id );

ALTER TABLE  TeachingSchedules  ADD FOREIGN KEY ( subject_id ) REFERENCES  Subject  ( subject_id );

ALTER TABLE  TeachingSchedules  ADD FOREIGN KEY ( slot_id ) REFERENCES  Slot  ( slot_id );

ALTER TABLE TeachingSchedules ADD FOREIGN KEY (semester_id) REFERENCES Semester (semester_id);

ALTER TABLE  GradeComponents  ADD FOREIGN KEY ( grade_category_id ) REFERENCES  GradeCategory  ( gradecategory_id );

ALTER TABLE  GradeComponents  ADD FOREIGN KEY ( subject_id ) REFERENCES  Subject  ( subject_id );

ALTER TABLE  ExamSchedules  ADD FOREIGN KEY ( student_id ) REFERENCES  [User]  ( user_id );

ALTER TABLE  ExamSchedules  ADD FOREIGN KEY ( subject_id ) REFERENCES  Subject  ( subject_id );

ALTER TABLE  ExamSchedules  ADD FOREIGN KEY ( semester_id ) REFERENCES  Semester  ( semester_id );

ALTER TABLE  ExamSchedules  ADD FOREIGN KEY ( exam_type ) REFERENCES  ExamGenre  ( examgenre_id );

ALTER TABLE  ExamSchedules  ADD FOREIGN KEY ( exam_room ) REFERENCES  Classrooms  ( classroom_id );

ALTER TABLE  Attendances  ADD FOREIGN KEY ( student_id ) REFERENCES  [User]  ( user_id );

ALTER TABLE   Attendances ADD FOREIGN KEY ( teaching_schedule_id ) REFERENCES  TeachingSchedules  ( teaching_schedule_id );

ALTER TABLE  Grades  ADD FOREIGN KEY ( grade_category_id ) REFERENCES  GradeCategory  ( gradecategory_id );

ALTER TABLE  Grades  ADD FOREIGN KEY ( semester_id ) REFERENCES  Semester  ( semester_id );

ALTER TABLE  Grades  ADD FOREIGN KEY ( student_id ) REFERENCES  [User]  ( user_id );

ALTER TABLE  Grades  ADD FOREIGN KEY ( subject_id ) REFERENCES  Subject  ( subject_id );

/*
ALTER TABLE TeachingSchedules
ADD CONSTRAINT UC_TeachingSchedules_UniqueCombination 
UNIQUE(subject_id, slot_id);*/

