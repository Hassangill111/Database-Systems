-- =========================================
-- TASK 3: 2NF
-- =========================================

CREATE TABLE Customer (
CustID VARCHAR(10) PRIMARY KEY,
CustName VARCHAR(50),
CustEmail VARCHAR(50)
);

CREATE TABLE Orders (
OrderID VARCHAR(10) PRIMARY KEY,
OrderDate DATE,
CustID VARCHAR(10),
FOREIGN KEY (CustID) REFERENCES Customer(CustID)
);

CREATE TABLE Book (
BookID VARCHAR(10) PRIMARY KEY,
Title VARCHAR(50),
Publisher VARCHAR(50),
UnitPrice INT
);

CR-EATE TABLE OrderDetails (
OrderID VARCHAR(10),
BookID VARCHAR(10),
Qty INT,
PRIMARY KEY (OrderID, BookID),
FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
FOREIGN KEY (BookID) REFERENCES Book(BookID)
);

-- Insert Data (2NF)

INSERT INTO Customer VALUES
('C-11','Bilal','[bilal@x.com](mailto:bilal@x.com)'),
('C-12','Areeba','[areeba@x.com](mailto:areeba@x.com)');

INSERT INTO Orders VALUES
('O-501','2026-04-02','C-11'),
('O-502','2026-04-03','C-12'),
('O-503','2026-04-05','C-11');

INSERT INTO Book VALUES
('B-1','SQL Basics','Pearson',1200),
('B-2','Python 101','OReilly',1500),
('B-3','Networks','Pearson',1800);

INSERT INTO OrderDetails VALUES
('O-501','B-1',1),
('O-501','B-2',2),
('O-502','B-1',3),
('O-503','B-3',1),
('O-503','B-2',1);

-- =========================================
-- TASK 4: 3NF
-- =========================================

CREATE TABLE Publisher (
PublisherID INT AUTO_INCREMENT PRIMARY KEY,
PublisherName VARCHAR(50)
);

CREATE TABLE Book_3NF (
BookID VARCHAR(10) PRIMARY KEY,
Title VARCHAR(50),
UnitPrice INT,
PublisherID INT,
FOREIGN KEY (PublisherID) REFERENCES Publisher(PublisherID)
);

-- Insert Data (3NF)

INSERT INTO Publisher (PublisherName) VALUES
('Pearson'),
('OReilly');

INSERT INTO Book_3NF VALUES
('B-1','SQL Basics',1200,1),
('B-2','Python 101',1500,2),
('B-3','Networks',1800,1);

-- =========================================
-- TASK 5: VERIFICATION QUERIES
-- =========================================

-- Recreate Original Report
SELECT
o.OrderID,
o.OrderDate,
c.CustName,
c.CustEmail,
b.Title,
p.PublisherName,
b.UnitPrice,
od.Qty
FROM OrderDetails od
JOIN Orders o ON od.OrderID = o.OrderID
JOIN Customer c ON o.CustID = c.CustID
JOIN Book_3NF b ON od.BookID = b.BookID
JOIN Publisher p ON b.PublisherID = p.PublisherID;

-- Total Spend Per Customer
SELECT
c.CustName,
SUM(b.UnitPrice * od.Qty) AS Total_Spend
FROM OrderDetails od
JOIN Orders o ON od.OrderID = o.OrderID
JOIN Customer c ON o.CustID = c.CustID
JOIN Book_3NF b ON od.BookID = b.BookID
GROUP BY c.CustName;

-- =========================================
-- END OF FILE
-- =========================================
CREATE DATABASE Hospital_Normalization;
USE Hospital_Normalization;

-- =========================
-- 2NF
-- =========================
-- VisitID -> VisitDate, PatientID, DoctorID, Diagnosis, Fee
-- PatientID -> PatientName, PatientPhone

CREATE TABLE Patient_2NF (
    PatientID VARCHAR(10) PRIMARY KEY,
    PatientName VARCHAR(50),
    PatientPhone VARCHAR(20)
);

CREATE TABLE Visit_2NF (
    VisitID VARCHAR(10) PRIMARY KEY,
    VisitDate DATE,
    PatientID VARCHAR(10),
    DoctorID VARCHAR(10),
    DoctorName VARCHAR(50),
    Specialty VARCHAR(50),
    DeptName VARCHAR(50),
    DeptHead VARCHAR(50),
    Diagnosis VARCHAR(100),
    Fee DECIMAL(10,2),

    FOREIGN KEY (PatientID) REFERENCES Patient_2NF(PatientID)
);

INSERT INTO Patient_2NF VALUES
('P-201','Hassan','0300-1112233'),
('P-202','Mehreen','0301-4445566'),
('P-203','Junaid','0302-7778899');

INSERT INTO Visit_2NF VALUES
('V-9001','2026-04-10','P-201','D-30','Dr. Imran',
 'Cardiology','Heart Care','Dr. Tariq','Hypertension',2500),
('V-9002','2026-04-10','P-202','D-31','Dr. Asma',
 'Dermatology','Skin Clinic','Dr. Asma','Eczema',2000),
('V-9003','2026-04-11','P-201','D-31','Dr. Asma',
 'Dermatology','Skin Clinic','Dr. Asma','Allergy',2000),
('V-9004','2026-04-12','P-203','D-30','Dr. Imran',
 'Cardiology','Heart Care','Dr. Tariq','Arrhythmia',3000);


-- =========================
-- 3NF
-- =========================
-- DoctorID -> DoctorName, Specialty, DeptName
-- DeptName -> DeptHead

CREATE TABLE Department (
    DeptName VARCHAR(50) PRIMARY KEY,
    DeptHead VARCHAR(50)
);

CREATE TABLE Doctor (
    DoctorID VARCHAR(10) PRIMARY KEY,
    DoctorName VARCHAR(50),
    Specialty VARCHAR(50),
    DeptName VARCHAR(50),
    FOREIGN KEY (DeptName) REFERENCES Department(DeptName)
);

CREATE TABLE Patient (
    PatientID VARCHAR(10) PRIMARY KEY,
    PatientName VARCHAR(50),
    PatientPhone VARCHAR(20)
);

CREATE TABLE Visit (
    VisitID VARCHAR(10) PRIMARY KEY,
    VisitDate DATE,
    PatientID VARCHAR(10),
    DoctorID VARCHAR(10),
    Diagnosis VARCHAR(100),
    Fee DECIMAL(10,2),
    FOREIGN KEY (PatientID) REFERENCES Patient(PatientID),
    FOREIGN KEY (DoctorID) REFERENCES Doctor(DoctorID)
);

INSERT INTO Department VALUES
('Heart Care','Dr. Tariq'),
('Skin Clinic','Dr. Asma');

INSERT INTO Doctor VALUES
('D-30','Dr. Imran','Cardiology','Heart Care'),
('D-31','Dr. Asma','Dermatology','Skin Clinic');

INSERT INTO Patient VALUES
('P-201','Hassan','0300-1112233'),
('P-202','Mehreen','0301-4445566'),
('P-203','Junaid','0302-7778899');

INSERT INTO Visit VALUES
('V-9001','2026-04-10','P-201','D-30','Hypertension',2500),
('V-9002','2026-04-10','P-202','D-31','Eczema',2000),
('V-9003','2026-04-11','P-201','D-31','Allergy',2000),
('V-9004','2026-04-12','P-203','D-30','Arrhythmia',3000);


-- Recreate original report
SELECT
    v.VisitID, v.VisitDate,
    p.PatientID, p.PatientName, p.PatientPhone,
    d.DoctorID, d.DoctorName, d.Specialty,
    dp.DeptName, dp.DeptHead,
    v.Diagnosis, v.Fee
FROM Visit v
JOIN Patient p ON v.PatientID = p.PatientID
JOIN Doctor d ON v.DoctorID = d.DoctorID
JOIN Department dp ON d.DeptName = dp.DeptName;

-- =========================================
-- END OF FILE
-- =========================================

====================================================================================================================================================================================================================================
                                                 Prepared by: Hassan Gillani
                                                 Roll No: 2024-SE-42
                                                 Semester/Department: 4th Software Engineering
                                                 Submitted to: Engr. Awais Rathore
====================================================================================================================================================================================================================================