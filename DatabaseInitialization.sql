CREATE DATABASE IF NOT EXISTS UniLinkDB;
USE UniLinkDB;

CREATE TABLE Instructors (
    Instructor_id INT AUTO_INCREMENT PRIMARY KEY,
    Fname VARCHAR(100),
	Lname VARCHAR(100),
	Specialization VARCHAR(100)
);

CREATE TABLE Major (
    Major_id INT  PRIMARY KEY,
    Name_mjr VARCHAR(100),
	S_InstructorID INT,
	FOREIGN KEY (S_InstructorID) REFERENCES Instructors(Instructor_id)

);

CREATE TABLE Students (
    Student_id INT PRIMARY KEY,
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
	FOREIGN KEY (Student_id) REFERENCES Students(Student_id),
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
	FOREIGN KEY (CourseTime_id) REFERENCES Courses(Course_id) ,
	Primary KEY(Group_timetable,Type_timetable,CourseTime_id)
);
CREATE TABLE Absence (
    
    StudentAbs_id INT ,
	CourseAbs_id VARCHAR(100),
	Type_Abs  VARCHAR(10) CHECK (Type_Abs IN ('Lecture', 'Tutorial')),
	AbsenceDate date,
	FOREIGN KEY (StudentAbs_id) REFERENCES Students(Student_id),
	FOREIGN KEY (CourseAbs_id) REFERENCES Courses(Course_id),
	Primary KEY (StudentAbs_id,CourseAbs_id,Type_Abs,AbsenceDate)
);

Create Table Submissions(
Assignment_id INT,
Student_id INT,
Attachment longblob,
SubmissionDate datetime,
FOREIGN KEY (Assignment_id) REFERENCES Assignments(Assignment_id),
FOREIGN KEY (Student_id) REFERENCES Students(Student_id),
Primary KEY (Assignment_id,Student_id)
);

CREATE TABLE TakenCourses(
Course_id VARCHAR(100),
Student_id INT,
Grade CHAR,
Semester VARCHAR(10) CHECK (Semester IN ('Fall', 'Spring','Summer')),
FOREIGN KEY(Course_id) REFERENCES Courses(Course_id),
FOREIGN KEY (Student_id) REFERENCES Students(Student_id),
Primary KEY(Course_id,Student_id)
);

CREATE TABLE Teaches(
Instructor_id INT,
Course_id VARCHAR(100),
FOREIGN KEY(Instructor_id) REFERENCES Instructors(Instructor_id),
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
 FOREIGN KEY (Student_id) REFERENCES Students(Student_id),
 Primary key (Student_id,Type_timetable,CourseTime_id)
);