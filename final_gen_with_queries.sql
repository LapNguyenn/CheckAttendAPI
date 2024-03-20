INSERT INTO Role (role_name, status) VALUES 
('Student', 1),
('Instructor', 1),
('Admin', 1);

INSERT INTO [User] (google_id, email, code, first_name, last_name, avatar, gender, address, phone, date_of_birth, major, face_left_data, face_right_data, face_between_data, cccd_frontside, cccd_backside, personal_identification, role_id, refresh_token, status)
VALUES 
('google-1001', 'student1@example.com', 'CS1001', 'Nguyen Thanh', 'Tung', '', 0, '123 Main St, City', '111-222-3333', '2000-01-01', 'Computer Science', '', '', '', '', '', '123456789', 1, '', 1),
('google-1002', 'student2@example.com', 'CS1002', 'Ngo Duy', 'Hai', '', 0, '124 Main St, City', '111-222-3334', '2000-02-02', 'Computer Science', '', '', '', '', '', '223456789', 1, '', 1),
('google-1003', 'student3@example.com', 'CS1003', 'Tran Dang', 'An', '', 0, '125 Main St, City', '111-222-3335', '2000-03-03', 'Computer Science', '', '', '', '', '', '323456789', 1, '', 1),
('google-1004', 'student4@example.com', 'CS1004', 'Nguyen Thanh', 'Lap', '', 0, '126 Main St, City', '111-222-3336', '2000-04-04', 'Computer Science', '', '', '', '', '', '423456789', 1, '', 1),
('google-1005', 'student5@example.com', 'CS1005', 'Nguyen Huu Duy', 'Anh', '', 0, '127 Main St, City', '111-222-3337', '2000-05-05', 'Computer Science', '', '', '', '', '', '523456789', 1, '', 1),
('google-1006', 'student6@example.com', 'CS1006', 'Nguyen Quoc', 'Hung', '', 0, '128 Main St, City', '111-222-3338', '2000-06-06', 'Computer Science', '', '', '', '', '', '623456789', 1, '', 1),
('google-1007', 'student7@example.com', 'CS1007', 'Nguyen Ngoc', 'Chi', '', 1, '129 Main St, City', '111-222-3339', '2000-07-07', 'Computer Science', '', '', '', '', '', '723456789', 1, '', 1),
('google-1008', 'student8@example.com', 'CS1008', 'Mai Phu', 'Trong', '', 0, '130 Main St, City', '111-222-3340', '2000-08-08', 'Computer Science', '', '', '', '', '', '823456789', 1, '', 1),
('google-1009', 'student9@example.com', 'CS1009', 'Ton Manh', 'Kien', '', 0, '131 Main St, City', '111-222-3341', '2000-09-09', 'Computer Science', '', '', '', '', '', '923456789', 1, '', 1),
('google-1010', 'student10@example.com', 'CS1010', 'Nguyen Gia', 'Binh huhu', '', 0, '132 Main St, City', '111-222-3342', '2000-10-10', 'Computer Science', '', '', '', '', '', '023456789', 1, '', 1);

INSERT INTO [User] (google_id, email, code, first_name, last_name, avatar, gender, address, phone, date_of_birth, major, face_left_data, face_right_data, face_between_data, cccd_frontside, cccd_backside, personal_identification, role_id, refresh_token, status)
VALUES 
('google-2001', 'teacher1@example.com', 'TC2001', 'Dang Van', 'Hieu', '', 0, '200 Main St, City', '211-222-3333', '1980-01-01', 'Computer Science', '', '', '', '', '', '123456789', 2, '', 1),
('google-2002', 'teacher2@example.com', 'TC2002', 'Ngo Tung', 'Son', '', 0, '201 Main St, City', '211-222-3334', '1981-02-02', 'Software Engineering', '', '', '', '', '', '223456789', 2, '', 1);

INSERT INTO Classes (class_name) VALUES 
('Software Engineering'),
('Database Systems');

INSERT INTO Semester (semester_name, start_date, end_date) VALUES 
('Fall 2023', '2023-09-01', '2023-12-20'),
('Spring 2024', '2024-01-15', '2024-05-15'),
('Summer 2024', '2024-06-05', '2024-08-15');

INSERT INTO Slot (start_time, end_time, status) VALUES 
('08:00:00', '09:30:00', 1),
('09:45:00', '11:15:00', 1),
('11:30:00', '13:00:00', 1),
('14:00:00', '15:30:00', 1),
('15:45:00', '17:15:00', 1),
('17:30:00', '19:00:00', 1);

INSERT INTO Classrooms (classroom_name, total_seat, status) VALUES 
('Room A101', 30, 1);

INSERT INTO ExamGenre (examgenre_name, status) VALUES 
('Written', 1),
('Oral', 1),
('Practical', 1),
('Project', 1);

INSERT INTO GradeCategory (gradecategory_name, gradecategory_percent) VALUES 
('Homework', 10.0),
('Quizzes', 15.0),
('Midterm Exam', 25.0),
('Final Exam', 30.0),
('Project', 15.0),
('Participation', 5.0);

INSERT INTO Subject (subject_code, subject_name, subject_material_url, total_lesson, status) VALUES 
('CS101', 'Introduction to Computer Science', 'https://example.edu/materials/cs101', 30, 1),
('CS102', 'Data Structures and Algorithms', 'https://example.edu/materials/cs102', 45, 1),
('CS201', 'Computer Architecture', 'https://example.edu/materials/cs201', 40, 1),
('CS202', 'Operating Systems', 'https://example.edu/materials/cs202', 35, 1),
('CS301', 'Software Engineering', 'https://example.edu/materials/cs301', 50, 1),
('CS302', 'Database Systems', 'https://example.edu/materials/cs302', 40, 1),
('CS401', 'Machine Learning', 'https://example.edu/materials/cs401', 60, 1),
('CS402', 'Computer Networks', 'https://example.edu/materials/cs402', 45, 1),
('CS403', 'Web Development', 'https://example.edu/materials/cs403', 30, 1),
('CS404', 'Mobile Application Development', 'https://example.edu/materials/cs404', 30, 1);


INSERT INTO UserClassSemester (student, semester_id, class_id, status)
select
	u.user_id, se.semester_id, cla.class_id,1
from
	[User] u, semester se, Classes cla
WHERE 
    u.role_id = 1;

INSERT INTO Grades (grade_category_id, semester_id, student_id, subject_id, grade, comment)
SELECT 
    gra.gradecategory_id, -- Grade Category ID for midterm exams
    se.semester_id, -- Semester ID for Spring 2024
    u.user_id, 
    su.subject_id, -- Subject ID for "Introduction to Software Engineering"
    null, -- Grade
    'Good performance' -- Comment
FROM 
    [User] u, GradeCategory gra,semester se,subject su
WHERE 
    u.role_id = 1
AND
	se.semester_id = 1
AND
	su.subject_id <= 3;

-- Assuming instructor ID 11 teaches class ID 1 in classroom ID 1 during slot ID 1

CREATE  TABLE TempTeachingDays (
    teaching_date DATE
);

-- Thêm các ngày giảng dạy vào bảng tạm thời
INSERT INTO TempTeachingDays (teaching_date) VALUES
    ('2024-03-10'),
    ('2024-03-11'),
    ('2024-03-12'),
    ('2024-03-13'),
    ('2024-03-14'),
    ('2024-03-20'),
    ('2024-03-21'),
    ('2024-03-22');
-- Thêm dữ liệu từ bảng tạm thời vào bảng TeachingSchedules
INSERT INTO TeachingSchedules (instructor_id, class_id, classroom_id, subject_id, slot_id, status,teaching_day)
SELECT 
	u.user_id,
	cla.class_id,
	clas.classroom_id,
    su.subject_id,
    Slot.slot_id,
	1,
	ttd.teaching_date
FROM 
    [User] u, Classes cla, Classrooms clas,subject su, SLot, TempTeachingDays ttd
WHERE 
    u.role_id = 2
AND 
	clas.classroom_id <= 2
AND
	su.subject_id <= 3

Drop TABLE TempTeachingDays

-- Assuming student ID 1 has an exam for subject ID 1 during semester ID 1 in classroom ID 1, exam type ID 1
INSERT INTO ExamSchedules (student_id, subject_id, semester_id, exam_type, exam_room, exam_date, exam_score_announcement_date)
SELECT 
	u.user_id,
	su.subject_id,
	se.semester_id,
	1,
	1,
	'2024-05-01T10:00:00',
	'2024-05-15'
FROM 
    [User] u, subject su, semester se
WHERE 
    u.role_id = 1
AND
	se.semester_id = 1
AND
	su.subject_id <= 3;

-- Assuming student ID 1 attended a class as per teaching schedule ID 1
INSERT INTO Attendances (student_id, teaching_schedule_id, attendance_time, attendance_status)
SELECT 
	u.user_id,
	te.teaching_schedule_id,
	null,
	null
FROM 
    [User] u, teachingschedules te
WHERE 
    u.role_id = 1;


INSERT INTO Grades (grade_category_id, semester_id, student_id, subject_id, grade, comment)
SELECT 
	gca.gradecategory_id,
	se.semester_id,
	u.user_id,
	su.subject_id,
	5.0,
	null
FROM 
    [User] u,  semester se, GradeCategory gca, Subject su
WHERE 
    u.role_id = 1
AND
	se.semester_id = 1
AND
	su.subject_id <= 3;

UPDATE Attendances
                    SET Attendances.attendance_status = CASE
                WHEN [User].code = 'CS1003' THEN 0
                    ELSE Attendances.attendance_status
                    END
                    FROM Attendances
                    JOIN TeachingSchedules ON Attendances.teaching_schedule_id = TeachingSchedules.teaching_schedule_id
                    JOIN Slot ON TeachingSchedules.slot_id = Slot.slot_id
                    JOIN Classes ON Classes.class_id = TeachingSchedules.class_id
                    JOIN [User] ON [User].user_id = Attendances.student_id
                    WHERE
                    [User].code IN ('CS1003')
                    AND TeachingSchedules.teaching_day = CAST('2024-03-21' AS DATE)                            
















