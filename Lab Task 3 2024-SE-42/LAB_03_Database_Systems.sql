-- MySQL Lab 03: Keys, Table Commands, CRUD Operations and University Example
-- Student: Hassan Gillani
-- University: University of Azad Jammu & Kashmir (UAJK), Chella Campus Muzaffarabad
-- Department: Department of Software Engineering
-- Course: Database Systems
-- Course Code: CS-2204
-- Instructor: Sir Engr. Daniyal Nazir

CREATE DATABASE IF NOT EXISTS university_lab03;
USE university_lab03;

-- =========================================================
-- SECTION 1: DATABASE KEYS
-- =========================================================

-- Primary Key
CREATE TABLE students_key_demo (
    student_id INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100)
);

-- Foreign Key
CREATE TABLE departments_key_demo (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(100)
);

ALTER TABLE students_key_demo
ADD dept_id INT,
ADD CONSTRAINT fk_department_demo
FOREIGN KEY (dept_id) REFERENCES departments_key_demo(dept_id);

-- Unique Key
ALTER TABLE students_key_demo
ADD CONSTRAINT unique_email_demo UNIQUE (email);

-- Composite Key
CREATE TABLE courses_key_demo (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(100)
);

CREATE TABLE enrollments_key_demo (
    student_id INT,
    course_id INT,
    PRIMARY KEY (student_id, course_id),
    FOREIGN KEY (student_id) REFERENCES students_key_demo(student_id),
    FOREIGN KEY (course_id) REFERENCES courses_key_demo(course_id)
);

-- Natural Key
CREATE TABLE citizens (
    cnic VARCHAR(15) PRIMARY KEY,
    name VARCHAR(100)
);

-- Surrogate Key
CREATE TABLE students_surrogate (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100)
);

-- Candidate Key, Alternate Key and Super Key are concepts demonstrated
-- through unique attributes such as student_id and email.

-- =========================================================
-- SECTION 2: TABLE COMMANDS
-- =========================================================

CREATE TABLE students (
    student_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    age INT,
    dept_name VARCHAR(50)
);

-- Add Column
ALTER TABLE students
ADD phone VARCHAR(20);

-- Modify Column
ALTER TABLE students
MODIFY age INT NOT NULL;

-- Rename Column
ALTER TABLE students
CHANGE dept_name department VARCHAR(50);

-- Drop Column
ALTER TABLE students
DROP COLUMN phone;

-- =========================================================
-- SECTION 3: ADD CONSTRAINTS
-- =========================================================

ALTER TABLE students
ADD PRIMARY KEY (student_id);

-- The above statement is intentionally shown from the lab guide,
-- but student_id is already a primary key in this table.
-- Therefore, do not execute it again in MySQL.

ALTER TABLE students
ADD CONSTRAINT unique_email UNIQUE (email);

-- The above statement is also already represented by the UNIQUE
-- definition. Do not execute it again.

ALTER TABLE students
ADD dept_id INT;

ALTER TABLE students
ADD CONSTRAINT fk_department
FOREIGN KEY (dept_id) REFERENCES departments_key_demo(dept_id);

-- =========================================================
-- SECTION 4: CRUD OPERATIONS
-- =========================================================

INSERT INTO students (student_id, name, email, age, department, dept_id)
VALUES
(1, 'Ali', 'ali@gmail.com', 20, 'CS', 1),
(2, 'Sara', 'sara@gmail.com', 21, 'EE', 2);

SELECT * FROM students;

UPDATE students
SET name = 'Ali Khan'
WHERE student_id = 1;

DELETE FROM students
WHERE student_id = 2;

-- =========================================================
-- SECTION 5: OTHER TABLE OPERATIONS
-- =========================================================

-- Use with caution because TRUNCATE removes all rows.
-- TRUNCATE TABLE students;

-- Use with caution because DROP removes the table.
-- DROP TABLE students;

-- =========================================================
-- SECTION 6: COMPLETE UNIVERSITY LAB EXAMPLE
-- =========================================================

DROP TABLE IF EXISTS enrollments;
DROP TABLE IF EXISTS instructors;
DROP TABLE IF EXISTS courses;
DROP TABLE IF EXISTS students;
DROP TABLE IF EXISTS departments;

CREATE TABLE departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(100) UNIQUE
);

CREATE TABLE students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    age INT,
    dept_id INT,
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);

CREATE TABLE courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(100),
    dept_id INT,
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);

CREATE TABLE instructors (
    instructor_id INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    dept_id INT,
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);

CREATE TABLE enrollments (
    student_id INT,
    course_id INT,
    semester VARCHAR(20),
    PRIMARY KEY (student_id, course_id),
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

-- =========================================================
-- SAMPLE DATA
-- =========================================================

INSERT INTO departments VALUES
(1, 'CS'),
(2, 'EE');

INSERT INTO students (name, email, age, dept_id) VALUES
('Ali', 'ali@gmail.com', 20, 1),
('Sara', 'sara@gmail.com', 21, 1),
('Ahmed', 'ahmed@gmail.com', 22, 2);

INSERT INTO courses VALUES
(101, 'Database', 1),
(102, 'AI', 1),
(201, 'Circuits', 2);

INSERT INTO instructors VALUES
(1, 'Dr. Ahmed', 'ahmed.instructor@gmail.com', 1),
(2, 'Dr. Sara', 'sara.instructor@gmail.com', 2);

INSERT INTO enrollments VALUES
(1, 101, 'Fall 2025'),
(1, 102, 'Fall 2025'),
(2, 101, 'Fall 2025');

-- =========================================================
-- SELECT QUERIES
-- =========================================================

SELECT * FROM departments;
SELECT * FROM students;
SELECT * FROM courses;
SELECT * FROM instructors;
SELECT * FROM enrollments;

-- Join Students and Courses
SELECT
    s.student_id,
    s.name AS student_name,
    c.course_id,
    c.course_name,
    e.semester
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
JOIN courses c ON e.course_id = c.course_id;

-- =========================================================
-- LAB TASKS
-- =========================================================

-- Update a student's name
UPDATE students
SET name = 'Ali Khan'
WHERE student_id = 1;

-- Delete a student record
-- This student must have no enrollment records first.
DELETE FROM enrollments
WHERE student_id = 3;

DELETE FROM students
WHERE student_id = 3;

-- Add a new column using ALTER TABLE
ALTER TABLE students
ADD phone VARCHAR(20);

-- View the modified table
SELECT * FROM students;

-- End of Lab 03
