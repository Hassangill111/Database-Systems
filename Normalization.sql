-- =========================================
-- DATABASE NORMALIZATION LAB (1NF)
-- =========================================

-- Create Database
CREATE DATABASE bookstore_lab;
USE bookstore_lab;

-- =========================================
-- TASK 1: FUNCTIONAL DEPENDENCIES
-- =========================================
-- OrderID → OrderDate, CustID
-- CustID → CustName, CustEmail
-- BookID → Title, Publisher, UnitPrice
-- (OrderID, BookID) → Qty

-- =========================================
-- TASK 2: 1NF
-- =========================================

CREATE TABLE OrderBook_1NF (
OrderID VARCHAR(10),
OrderDate DATE,
CustID VARCHAR(10),
CustName VARCHAR(50),
CustEmail VARCHAR(50),
BookID VARCHAR(10),
Title VARCHAR(50),
Publisher VARCHAR(50),
UnitPrice INT,
Qty INT,
PRIMARY KEY (OrderID, BookID)
);

INSERT INTO OrderBook_1NF VALUES
('O-501','2026-04-02','C-11','Bilal','[bilal@x.com](mailto:bilal@x.com)','B-1','SQL Basics','Pearson',1200,1),
('O-501','2026-04-02','C-11','Bilal','[bilal@x.com](mailto:bilal@x.com)','B-2','Python 101','OReilly',1500,2),
('O-502','2026-04-03','C-12','Areeba','[areeba@x.com](mailto:areeba@x.com)','B-1','SQL Basics','Pearson',1200,3),
('O-503','2026-04-05','C-11','Bilal','[bilal@x.com](mailto:bilal@x.com)','B-3','Networks','Pearson',1800,1),
('O-503','2026-04-05','C-11','Bilal','[bilal@x.com](mailto:bilal@x.com)','B-2','Python 101','OReilly',1500,1);

-- =========================================
-- END OF FILE
-- =========================================

====================================================================================================================================================================================================================================
                                                 Prepared by: Hassan Gillani
                                                 Roll No: 2024-SE-42
                                                 Semester/Department: 4th Software Engineering
                                                 Submitted to: Engr. Awais Rathore
====================================================================================================================================================================================================================================