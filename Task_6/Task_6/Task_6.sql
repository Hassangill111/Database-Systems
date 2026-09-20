-- ============================================================
-- TASK 6 — LAB TASKS: SQL FILTERS
-- Database Systems — SQL Filters
-- ============================================================
-- Student: Hassan Gillani
-- University: University of Azad Jammu & Kashmir (UAJK), Chella Campus Muzaffarabad
-- Department: Department of Software Engineering
-- Course: Database Systems
-- Course Code: CS-2204
-- Instructor: Sir Engr. Awais Rathore

-- Section 6: Lab Tasks using the Employee table.
-- All tasks A1-A8 and B1-B15 are included.

CREATE DATABASE IF NOT EXISTS filters_lab;
USE filters_lab;

DROP TABLE IF EXISTS Employee;

CREATE TABLE Employee (
    EmpID INT PRIMARY KEY,
    EmpName VARCHAR(50) NOT NULL,
    Gender CHAR(1),
    Salary DECIMAL(10,2),
    HireDate DATE,
    City VARCHAR(30),
    JobTitle VARCHAR(40),
    DeptName VARCHAR(40)
);

INSERT INTO Employee VALUES
(101,'Ali Khan','M',120000,'2018-03-15','Lahore','Senior Engineer','Engineering'),
(102,'Sara Iqbal','F',95000,'2019-06-01','Lahore','Software Engineer','Engineering'),
(103,'Hamza Raza','M',85000,'2020-01-20','Karachi','Software Engineer','Engineering'),
(104,'Ayesha Noor','F',110000,'2017-11-10','Karachi','Marketing Lead','Marketing'),
(105,'Bilal Ahmed','M',70000,'2021-04-05','Karachi','Marketing Exec','Marketing'),
(106,'Fatima Sheikh','F',90000,'2019-09-12','Islamabad','Accountant','Finance'),
(107,'Usman Tariq','M',78000,'2022-02-18','Islamabad','Accountant','Finance'),
(108,'Maira Javed','F',115000,'2016-07-22','Lahore','Research Lead','Research'),
(109,'Zain Abbas','M',60000,'2023-01-09','Lahore','Research Analyst','Research'),
(110,'Nida Yousaf','F',72000,'2022-08-30',NULL,'Research Analyst','Research'),
(111,'Adeel Akhtar','M',88000,'2020-05-14','Lahore','QA Engineer','Engineering'),
(112,'Sana Malik','F',102000,'2018-12-01','Karachi','Sales Manager','Sales'),
(113,'Talha Hussain','M',65000,'2023-07-18','Islamabad','Sales Exec','Sales'),
(114,'Mehwish Anwar','F',80000,'2021-10-25','Lahore','HR Officer','HR'),
(115,'Imran Shafi','M',125000,'2015-04-30',NULL,'Director','Engineering');

-- ============================================================
-- PART A — COMPARISON & LOGICAL OPERATORS
-- ============================================================

-- Task A1
SELECT EmpID, EmpName, Salary
FROM Employee
WHERE Salary > 90000;

-- Task A2
SELECT EmpName, Salary
FROM Employee
WHERE Salary <= 75000;

-- Task A3
SELECT EmpName, City, Salary
FROM Employee
WHERE City = 'Lahore' AND Salary > 90000;

-- Task A4
SELECT EmpName, City
FROM Employee
WHERE City IN ('Karachi', 'Islamabad');

-- Task A5
SELECT EmpName, Gender, DeptName
FROM Employee
WHERE Gender = 'F' AND DeptName <> 'Engineering';

-- Task A6
SELECT EmpName, Gender, Salary
FROM Employee
WHERE Gender = 'M' AND Salary >= 70000 AND Salary <= 90000;

-- Task A7
SELECT EmpName, JobTitle, Salary
FROM Employee
WHERE JobTitle = 'Software Engineer' OR Salary > 100000;

-- Task A8
SELECT EmpName, DeptName
FROM Employee
WHERE DeptName <> 'Marketing' AND DeptName <> 'Sales';

-- ============================================================
-- PART B — BETWEEN, IN, LIKE, IS NULL, ORDER BY, LIMIT
-- ============================================================

-- Task B1
SELECT EmpName, Salary
FROM Employee
WHERE Salary BETWEEN 75000 AND 100000
ORDER BY Salary ASC;

-- Task B2
SELECT EmpName, HireDate
FROM Employee
WHERE HireDate BETWEEN '2020-01-01' AND '2022-12-31';

-- Task B3
SELECT EmpName, Salary
FROM Employee
WHERE Salary NOT BETWEEN 80000 AND 100000;

-- Task B4
SELECT EmpName, City, Salary
FROM Employee
WHERE City IN ('Lahore', 'Islamabad')
ORDER BY City ASC, Salary DESC;

-- Task B5
SELECT EmpName, DeptName
FROM Employee
WHERE DeptName NOT IN ('Engineering', 'Sales', 'HR');

-- Task B6
SELECT EmpName
FROM Employee
WHERE EmpName LIKE 'M%';

-- Task B7
SELECT EmpName
FROM Employee
WHERE EmpName LIKE '%a%';

-- Task B8
SELECT EmpName
FROM Employee
WHERE EmpName LIKE '%an';

-- Task B9
SELECT EmpName, JobTitle, DeptName
FROM Employee
WHERE JobTitle LIKE '%Engineer%'
  AND DeptName <> 'Engineering';

-- Task B10
SELECT EmpName
FROM Employee
WHERE City IS NULL;

-- Task B11
SELECT EmpName, City
FROM Employee
WHERE City IS NOT NULL
ORDER BY City ASC;

-- Task B12
SELECT EmpName, Salary
FROM Employee
ORDER BY Salary DESC
LIMIT 3;

-- Task B13
SELECT EmpName, HireDate
FROM Employee
ORDER BY HireDate DESC
LIMIT 5;

-- Task B14
SELECT EmpName, Salary
FROM Employee
ORDER BY Salary ASC
LIMIT 3;

-- Task B15
SELECT EmpName, DeptName, HireDate
FROM Employee
ORDER BY DeptName ASC, HireDate ASC;
