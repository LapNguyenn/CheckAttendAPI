CREATE TABLE `Role` (
  `role_id` int PRIMARY KEY AUTO_INCREMENT,
  `role_name` text,
  `status` bool
);

CREATE TABLE `User` (
  `user_id` int PRIMARY KEY AUTO_INCREMENT,
  `google_id` varchar(255),
  `email` varchar(255),
  `code` varchar(255),
  `first_name` varchar(255),
  `last_name` varchar(255),
  `avatar` text,
  `gender` bool,
  `address` text,
  `phone` text,
  `date_of_birth` text,
  `major` text,
  `face_left_data` text,
  `face_right_data` text,
  `face_between_data` text,
  `cccd_frontside` text,
  `cccd_backside` text,
  `personal_identification` text,
  `role_id` int,
  `refresh_token` text,
  `status` bool
);

CREATE TABLE `Semester` (
  `semester_id` int PRIMARY KEY AUTO_INCREMENT,
  `semester_name` varchar(255),
  `start_date` date,
  `end_date` date
);

CREATE TABLE `Classes` (
  `class_id` int PRIMARY KEY AUTO_INCREMENT,
  `class_name` varchar(255)
);

CREATE TABLE `UserClassSemester` (
  `ucs_id` int PRIMARY KEY AUTO_INCREMENT,
  `student` int,
  `semester_id` int,
  `class_id` int,
  `status` bool
);

CREATE TABLE `Notification` (
  `notification_id` int UNIQUE PRIMARY KEY AUTO_INCREMENT,
  `user_id` int
);

CREATE TABLE `Classrooms` (
  `classroom_id` int PRIMARY KEY AUTO_INCREMENT,
  `classroom_name` varchar(255),
  `total_seat` int,
  `status` bool
);

CREATE TABLE `Slot` (
  `slot_id` int PRIMARY KEY AUTO_INCREMENT,
  `start_time` datetime,
  `end_time` datetime,
  `status` bool
);

CREATE TABLE `Subject` (
  `subject_id` int PRIMARY KEY AUTO_INCREMENT,
  `subject_code` varchar(255),
  `subject_name` varchar(255),
  `subject_material_url` text,
  `total_lesson` int,
  `status` bool
);

CREATE TABLE `UserSubjectSemester` (
  `uss_id` int PRIMARY KEY AUTO_INCREMENT,
  `user_id` int,
  `subject_id` int,
  `semester_id` int,
  `status` bool
);

CREATE TABLE `TeachingSchedules` (
  `teaching_schedule_id` int PRIMARY KEY AUTO_INCREMENT,
  `instructor_id` int,
  `class_id` int,
  `classroom_id` int,
  `subject_id` int,
  `slot_id` int,
  `status` bool
);

CREATE TABLE `GradeComponents` (
  `grade_component_id` int PRIMARY KEY AUTO_INCREMENT,
  `grade_category_id` int,
  `subject_id` int,
  `status` bool
);

CREATE TABLE `GradeCategory` (
  `gradecategory_id` int PRIMARY KEY AUTO_INCREMENT,
  `gradecategory_name` varchar(255),
  `gradecategory_percent` float
);

CREATE TABLE `ExamGenre` (
  `examgenre_id` int PRIMARY KEY AUTO_INCREMENT,
  `examgenre_name` varchar(255),
  `status` bool
);

CREATE TABLE `ExamSchedules` (
  `exam_schedule_id` int PRIMARY KEY AUTO_INCREMENT,
  `student_id` int,
  `subject_id` int,
  `semester_id` int,
  `exam_type` int,
  `exam_room` int,
  `exam_date` datetime,
  `exam_score_announcement_date` date
);

CREATE TABLE `Attendances` (
  `attendance_id` int PRIMARY KEY AUTO_INCREMENT,
  `student_id` int,
  `teaching_schedule_id` int,
  `attendance_time` datetime,
  `attendance_status` bool
);

CREATE TABLE `Grades` (
  `grade_id` int PRIMARY KEY AUTO_INCREMENT,
  `grade_category_id` int,
  `semester_id` int,
  `student_id` int,
  `subject_id` int,
  `grade` float,
  `comment` text
);

ALTER TABLE `User` ADD FOREIGN KEY (`role_id`) REFERENCES `Role` (`role_id`);

ALTER TABLE `UserClassSemester` ADD FOREIGN KEY (`student`) REFERENCES `User` (`user_id`);

ALTER TABLE `UserClassSemester` ADD FOREIGN KEY (`semester_id`) REFERENCES `Semester` (`semester_id`);

ALTER TABLE `UserClassSemester` ADD FOREIGN KEY (`class_id`) REFERENCES `Classes` (`class_id`);

ALTER TABLE `Notification` ADD FOREIGN KEY (`user_id`) REFERENCES `User` (`user_id`);

ALTER TABLE `UserSubjectSemester` ADD FOREIGN KEY (`user_id`) REFERENCES `User` (`user_id`);

ALTER TABLE `UserSubjectSemester` ADD FOREIGN KEY (`subject_id`) REFERENCES `Subject` (`subject_id`);

ALTER TABLE `UserSubjectSemester` ADD FOREIGN KEY (`semester_id`) REFERENCES `Semester` (`semester_id`);

ALTER TABLE `TeachingSchedules` ADD FOREIGN KEY (`instructor_id`) REFERENCES `User` (`user_id`);

ALTER TABLE `TeachingSchedules` ADD FOREIGN KEY (`class_id`) REFERENCES `Classes` (`class_id`);

ALTER TABLE `TeachingSchedules` ADD FOREIGN KEY (`classroom_id`) REFERENCES `Classrooms` (`classroom_id`);

ALTER TABLE `TeachingSchedules` ADD FOREIGN KEY (`subject_id`) REFERENCES `Subject` (`subject_id`);

ALTER TABLE `TeachingSchedules` ADD FOREIGN KEY (`slot_id`) REFERENCES `Slot` (`slot_id`);

ALTER TABLE `GradeComponents` ADD FOREIGN KEY (`grade_category_id`) REFERENCES `GradeCategory` (`gradecategory_id`);

ALTER TABLE `GradeComponents` ADD FOREIGN KEY (`subject_id`) REFERENCES `Subject` (`subject_id`);

ALTER TABLE `ExamSchedules` ADD FOREIGN KEY (`student_id`) REFERENCES `User` (`user_id`);

ALTER TABLE `ExamSchedules` ADD FOREIGN KEY (`subject_id`) REFERENCES `Subject` (`subject_id`);

ALTER TABLE `ExamSchedules` ADD FOREIGN KEY (`semester_id`) REFERENCES `Semester` (`semester_id`);

ALTER TABLE `ExamSchedules` ADD FOREIGN KEY (`exam_type`) REFERENCES `ExamGenre` (`examgenre_id`);

ALTER TABLE `ExamSchedules` ADD FOREIGN KEY (`exam_room`) REFERENCES `Classrooms` (`classroom_id`);

ALTER TABLE `Attendances` ADD FOREIGN KEY (`student_id`) REFERENCES `User` (`user_id`);

ALTER TABLE `Attendances` ADD FOREIGN KEY (`teaching_schedule_id`) REFERENCES `TeachingSchedules` (`teaching_schedule_id`);

ALTER TABLE `Grades` ADD FOREIGN KEY (`grade_category_id`) REFERENCES `GradeCategory` (`gradecategory_id`);

ALTER TABLE `Grades` ADD FOREIGN KEY (`semester_id`) REFERENCES `Semester` (`semester_id`);

ALTER TABLE `Grades` ADD FOREIGN KEY (`student_id`) REFERENCES `User` (`user_id`);

ALTER TABLE `Grades` ADD FOREIGN KEY (`subject_id`) REFERENCES `Subject` (`subject_id`);
