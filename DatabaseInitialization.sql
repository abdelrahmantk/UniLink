CREATE DATABASE IF NOT EXISTS UniLinkDB;
USE UniLinkDB;

CREATE TABLE Instructors (
    Instructor_id INT AUTO_INCREMENT PRIMARY KEY,
    Fname VARCHAR(100),
	Lname VARCHAR(100),
	Specialization VARCHAR(100)
);

CREATE TABLE Major (
    Major_id INT auto_increment  PRIMARY KEY,
    Name_mjr VARCHAR(100),
	S_InstructorID INT,
	FOREIGN KEY (S_InstructorID) REFERENCES Instructors(Instructor_id)

);

CREATE TABLE Students (
    Student_id INT auto_increment PRIMARY KEY,
    GPA FLOAT,
	Fname VARCHAR(100),
	Lname VARCHAR(100),
	Credits INT,
	Major_id int,
	FOREIGN KEY (Major_id) REFERENCES Major(Major_id)

);



CREATE TABLE Administrators (
    Admin_id INT  PRIMARY KEY,
    Fname VARCHAR(100),
	Lname VARCHAR(100)
);

CREATE TABLE Courses (
    Course_id VARCHAR(100) PRIMARY KEY,
    ContactHours INT NOT NULL,
	Credits INT NOT NULL,
	CourseName VARCHAR(100) NOT NULL
);

CREATE TABLE CourseMaterial (
    Material_id INT unique NOT NULL,
    Title VARCHAR(100) NOT NULL,
	Attachment Longblob NOT NULL,
	Course_id VARCHAR(100) NOT NULL,
	Instructor_id INT NOT NULL,
	FOREIGN KEY (Course_id) REFERENCES Courses(Course_id),
	FOREIGN KEY (Instructor_id) REFERENCES Instructors(Instructor_id),
	Primary KEY (Material_id,Course_id,Instructor_id) 
);

CREATE TABLE Assignments (
    Assignment_id INT,
    AssignmentName VARCHAR(100),
	Attachment longblob,
	Due_date date,
	Instructor_id INT,
	FOREIGN KEY (Instructor_id) REFERENCES Instructors(Instructor_id),
	PRIMARY KEY (Assignment_id,Instructor_id)
);

CREATE TABLE StudentIssues (
    Issue_id INT,
    Complaint VARCHAR(1000),
	Student_id INT,
	FOREIGN KEY (Student_id) REFERENCES Students(Student_id) ON DELETE CASCADE,
	Primary KEY (Student_id,Issue_id) 
);

CREATE TABLE Announcements (
    Announcement_id INT Unique NOT NULL,
    Title VARCHAR(1000) NOT NULL,
	Attachment Longblob NOT NULL,
	Course_id VARCHAR(100) NOT NULL,
	Instructor_id INT NOT NULL,
	FOREIGN KEY (Course_id) REFERENCES Courses(Course_id),
	FOREIGN KEY (Instructor_id) REFERENCES Instructors(Instructor_id),
	Primary KEY(Announcement_id,Course_id,Instructor_id)
);



CREATE TABLE Timetable (
    Type_timetable VARCHAR(10) CHECK (Type_timetable IN ('Lecture', 'Tutorial')),
	Group_timetable INT,
	Size INT,
	Start_Time_timetable time,
	End_Time_timetable time,
	Day_timetable date,
	CourseTime_id VARCHAR(100),
	FOREIGN KEY (CourseTime_id) REFERENCES Courses (Course_id) ,
	Primary KEY(Group_timetable,Type_timetable,CourseTime_id)
);
CREATE TABLE Absence (
    
    StudentAbs_id INT ,
	CourseAbs_id VARCHAR(100),
	Type_Abs  VARCHAR(10) CHECK (Type_Abs IN ('Lecture', 'Tutorial')),
	AbsenceDate date,
	FOREIGN KEY (StudentAbs_id) REFERENCES Students(Student_id) ON DELETE CASCADE,
	FOREIGN KEY (CourseAbs_id) REFERENCES Courses(Course_id),
	Primary KEY (StudentAbs_id,CourseAbs_id,Type_Abs,AbsenceDate)
);

Create Table Submissions(
Assignment_id INT,
Student_id INT,
Attachment longblob,
SubmissionDate datetime,
FOREIGN KEY (Assignment_id) REFERENCES Assignments(Assignment_id),
FOREIGN KEY (Student_id) REFERENCES Students(Student_id) ON DELETE CASCADE,
Primary KEY (Assignment_id,Student_id)
);

CREATE TABLE TakenCourses(
Course_id VARCHAR(100),
Student_id INT,
Grade CHAR,
Semester VARCHAR(10) CHECK (Semester IN ('Fall', 'Spring','Summer')),
FOREIGN KEY(Course_id) REFERENCES Courses (Course_id),
FOREIGN KEY (Student_id) REFERENCES Students(Student_id) ON DELETE CASCADE,
Primary KEY(Course_id,Student_id)
);

CREATE TABLE Teaches(
Instructor_id INT,
Course_id VARCHAR(100),
FOREIGN KEY(Instructor_id) REFERENCES Instructors(Instructor_id) ,
FOREIGN KEY(Course_id) REFERENCES Courses(Course_id),
PRIMARY KEY(Instructor_id,Course_id) 
);

CREATE TABLE MajorCourses(
Major_id INT,
Course_id VARCHAR(100),
FOREIGN KEY (Major_id) REFERENCES Major(Major_id),
FOREIGN KEY (Course_id) REFERENCES Courses(Course_id),
Primary KEY (Major_id,Course_id)
);

create table CurrentlyRegistered (
 Student_id INT,
 CourseTime_id varchar(100),
 Group_timetable INT,
 Type_timetable VARCHAR(10) CHECK (Type_timetable IN ('Lecture', 'Tutorial')),
 FOREIGN KEY (Group_timetable,Type_timetable,CourseTime_id) references Timetable(Group_timetable,Type_timetable,CourseTime_id),
 FOREIGN KEY (Student_id) REFERENCES Students(Student_id) ON DELETE CASCADE,
 Primary key (Student_id,Type_timetable,CourseTime_id)
);
INSERT INTO Instructors (Fname, Lname, Specialization) VALUES
('John', 'Doe', 'Computer Science'),
('Alice', 'Smith', 'Physics'),
('Michael', 'Johnson', 'Mathematics'),
('Emily', 'Brown', 'Biology');
INSERT INTO Major (Name_mjr, S_InstructorID) VALUES
('Computer Science', 1),
('Physics', 2),
('Mathematics', 3),
('Biology', 4);

-- Dummy data for Students table
INSERT INTO Students (GPA, Fname, Lname, Credits, Major_id) VALUES
(3.5, 'Emma', 'Johnson', 90, 1),
(3.2, 'Daniel', 'Williams', 75, 2),
(3.9, 'Olivia', 'Brown', 110, 3),
(3.6, 'James', 'Davis', 85, 4);

-- Dummy data for Courses table
INSERT INTO Courses (Course_id, ContactHours, Credits, CourseName) VALUES
('CS101', 3, 4, 'Introduction to Computer Science'),
('PHY202', 4, 3, 'Quantum Physics'),
('MATH301', 3, 4, 'Advanced Calculus'),
('BIO150', 4, 3, 'Genetics');

 -- Dummy data for StudentIssues table
INSERT INTO StudentIssues (Issue_id, Complaint, Student_id) VALUES
(1, 'Problems accessing course materials', 1),
(2, 'Unable to attend lectures due to health issues', 2),
(3, 'Issues with assignment submission portal', 3),
(4, 'Difficulty understanding course concepts', 4);
INSERT INTO Students (GPA, Fname, Lname, Credits, Major_id) VALUES
(3.8, 'Sophia', 'Johnson', 95, 1),
(3.1, 'Liam', 'Williams', 70, 2),
(3.7, 'Olivia', 'Smith', 105, 3),
(3.4, 'Emma', 'Davis', 80, 4),
(3.9, 'Noah', 'Martinez', 100, 1),
(3.3, 'Ava', 'Brown', 85, 2),
(3.5, 'William', 'Garcia', 110, 3),
(3.2, 'Isabella', 'Jones', 75, 4);


 select * from students;
INSERT INTO Students (GPA, Fname, Lname, Credits, Major_id) VALUES
(5, 'Ziad', 'Haitham', 73, 1),
(3.1, 'Liam', 'Williams', 70, 2),
(3.7, 'Olivia', 'Smith', 105, 3),
(3.4, 'Emma', 'Davis', 80, 4),
(3.9, 'Noah', 'Martinez', 100, 1),
(3.3, 'Ava', 'Brown', 85, 2),
(3.5, 'William', 'Garcia', 110, 3);
 
INSERT INTO StudentIssues (Issue_id, Complaint, Student_id) VALUES
(5, 'Difficulty in understanding the lab assignments', 1),
(6, 'Issues with timetable clashes for lectures', 2),
(7, 'Technical problems during online exams', 3),
(8, 'Concerns about grading criteria', 4),
(9, 'Challenges in accessing library resources', 5),
(10, 'Transportation issues causing late arrivals', 6);
select * from StudentIssues;
select * from Major;
INSERT INTO Students (GPA, Fname, Lname, Credits, Major_id) VALUES
(3.86, "Boska","Hesham","72",1);
 


DELIMITER //

CREATE PROCEDURE GetTableInfo(IN tableName VARCHAR(100))
BEGIN
    SET @query = CONCAT('SELECT * FROM ', tableName);
    PREPARE stmt FROM @query;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;
END //

DELIMITER ;
