# Database Management System — Open-Ended Lab
## Car Rental Management System

**Lab / Task:** 13  
**DBMS:** MySQL 8.x  
**Scenario:** CarGo Rentals

---

## 1. Student Information

| Field | Details |
|---|---|
| Student Name | [ENTER STUDENT NAME] |
| Roll Number | [ENTER ROLL NUMBER] |
| Instructor Name | [ENTER INSTRUCTOR NAME] |
| Course Name | Database Management System |
| Course Code | [ENTER COURSE CODE] |
| Department | [ENTER DEPARTMENT] |
| Semester | [ENTER SEMESTER] |
| University Name | [ENTER UNIVERSITY NAME] |

---

## 2. Lab Objective

The purpose of this open-ended lab is to design and implement a complete relational database solution for a car rental company.

The solution demonstrates:

- Relational database design
- Primary and foreign keys
- NOT NULL, UNIQUE, CHECK, DEFAULT, and ENUM constraints
- Realistic sample data
- Normalization from 1NF through 3NF
- INNER JOIN and LEFT JOIN queries
- Aggregate reporting
- A reusable SQL VIEW
- A business-rule TRIGGER
- A STORED PROCEDURE for registering rentals
- Indexing and query optimization
- Management reports

The manual describes the problem as a spreadsheet-based rental operation suffering from duplicate information, inconsistent records, and reporting difficulties. The database created in this submission separates customers, vehicles, rentals, and payments into related tables.

---

## 3. Files in This Submission

This folder contains:

```text
Task_13_Open_Ended_Car_Rental/
│
├── Task_13_Open_Ended_Car_Rental.sql
└── README.md
```

### SQL File

`Task_13_Open_Ended_Car_Rental.sql`

Contains the complete implementation, including:

1. Database creation
2. Table definitions
3. Constraints
4. Indexes
5. Sample data
6. Normalization explanation
7. Required JOIN queries
8. VIEW
9. TRIGGER
10. STORED PROCEDURE
11. Optimization analysis and improved query
12. Additional management reports

---

# 4. Problem Scenario

CarGo Rentals is a local car rental company that rents vehicles to customers for daily or weekly use.

The company needs a relational database to maintain:

- Customer information
- Vehicle information
- Rental transactions
- Return information
- Payment information
- Rental charges
- Vehicle availability

A key business rule is that a vehicle must not be available for another rental while it is already rented.

The database also supports management reporting for:

- Customer rental history
- Currently rented vehicles
- Vehicle rental activity

---

# 5. Database Design

## 5.1 Customer Table

The `Customer` table stores information that belongs specifically to customers.

Important attributes:

- `CustomerID` — primary key
- `CustomerName`
- `Phone` — unique
- `Email` — unique
- `CNIC` — unique
- `Address`
- `CreatedAt`

## 5.2 Vehicle Table

The `Vehicle` table stores vehicle-specific information.

Important attributes:

- `VehicleID` — primary key
- `VehicleNumber` — unique registration/vehicle number
- `VehicleModel`
- `VehicleYear`
- `DailyRate`
- `WeeklyRate`
- `Status`

Vehicle status is controlled through:

- `AVAILABLE`
- `RENTED`
- `MAINTENANCE`

## 5.3 Rental Table

The `Rental` table represents the transaction between a customer and a vehicle.

Important attributes:

- `RentalID` — primary key
- `CustomerID` — foreign key
- `VehicleID` — foreign key
- `RentalDate`
- `ExpectedReturnDate`
- `ActualReturnDate`
- `DailyRate`
- `RentalDays`
- `RentalCharge`
- `RentalStatus`

Rental status values are:

- `ACTIVE`
- `RETURNED`
- `CANCELLED`

## 5.4 Payment Table

The `Payment` table stores payment transactions separately from rental details.

Important attributes:

- `PaymentID` — primary key
- `RentalID` — foreign key
- `PaymentDate`
- `Amount`
- `PaymentMethod`
- `PaymentStatus`

This separation avoids repeatedly storing payment information with customer and vehicle information.

---

# 6. Keys and Constraints

## Primary Keys

Primary keys uniquely identify records:

- `Customer.CustomerID`
- `Vehicle.VehicleID`
- `Rental.RentalID`
- `Payment.PaymentID`

## Foreign Keys

Foreign keys maintain relationships:

- `Rental.CustomerID → Customer.CustomerID`
- `Rental.VehicleID → Vehicle.VehicleID`
- `Payment.RentalID → Rental.RentalID`

## UNIQUE Constraints

Used to prevent duplicate:

- Customer phone numbers
- Customer email addresses
- CNIC numbers
- Vehicle numbers

## NOT NULL Constraints

Used for essential information such as:

- Customer name
- Customer phone
- Vehicle number
- Vehicle model
- Daily rate
- Rental customer and vehicle
- Rental dates
- Payment amount

## CHECK Constraints

Used to validate:

- Positive rental rates
- Positive payment amounts
- Valid rental-day values
- Valid return dates
- Non-negative rental charges

## DEFAULT Constraints

Examples include:

- Customer creation timestamp
- Vehicle availability
- Rental status
- Payment date
- Payment status

---

# 7. Sample Data

The SQL file contains realistic sample records for:

- 7 customers
- 7 vehicles
- 6 rental transactions
- 6 payment transactions

The sample data includes:

- Completed rentals
- Active rentals
- Available vehicles
- Rented vehicles
- A vehicle under maintenance
- Customers with different rental histories

This allows the JOINs, VIEW, TRIGGER, procedure, and reports to demonstrate meaningful results.

---

# 8. Normalization Analysis

The original unnormalized rental structure contains:

```text
RentalID
CustomerName
CustomerPhone
VehicleNumber
VehicleModel
DailyRate
RentalDate
ReturnDate
PaymentAmount
```

Example:

```text
R001 | Ali Khan | 0300-1234567 | ABC-123 | Toyota Corolla |
5000 | 2026-09-01 | 2026-09-04 | 15000
```

## 8.1 First Normal Form — 1NF

The table is converted to 1NF by ensuring:

- Each column contains atomic values.
- There are no repeating groups.
- Each row represents one rental record.

The customer, vehicle, rental date, return date, and payment amount are represented as individual atomic values.

### Problem Reduced

Repeating or multi-valued data is avoided, making individual records easier to insert, update, and query.

---

## 8.2 Second Normal Form — 2NF

The next step separates attributes according to the entity they describe.

Customer information belongs to the customer entity:

```text
CustomerID
CustomerName
CustomerPhone
```

Vehicle information belongs to the vehicle entity:

```text
VehicleID
VehicleNumber
VehicleModel
DailyRate
```

Rental information belongs to the rental transaction:

```text
RentalID
CustomerID
VehicleID
RentalDate
ReturnDate
RentalCharge
```

### Problem Reduced

Customer and vehicle information no longer has to be repeated for every rental.

This reduces redundancy and avoids update anomalies.

---

## 8.3 Third Normal Form — 3NF

In 3NF, non-key attributes should depend on the key of their own entity rather than indirectly on another non-key attribute.

The final design uses:

```text
Customer
Vehicle
Rental
Payment
```

Relationships:

```text
Customer 1 ─────< Rental >───── 1 Vehicle
                       |
                       |
                       v
                    Payment
```

Customer attributes remain in `Customer`, vehicle attributes remain in `Vehicle`, rental attributes remain in `Rental`, and payment transactions remain in `Payment`.

### Problems Reduced

The decomposition helps prevent:

- Update anomalies
- Insertion anomalies
- Deletion anomalies
- Repeated customer data
- Repeated vehicle data
- Inconsistent vehicle rates

---

# 9. Required JOIN Queries

The SQL file contains all four required business questions.

## Query 1 — Rental Details

Displays:

- Customer name
- Vehicle number
- Vehicle model
- Rental date
- Return date

Uses `INNER JOIN` because the result is for existing rental relationships.

## Query 2 — All Customers and Their Rentals

Uses `LEFT JOIN`.

This is important because customers who have never rented a vehicle must also appear.

## Query 3 — All Vehicles and Current Rental Information

Uses `LEFT JOIN` so that vehicles without an active rental are also included.

The condition for active rentals is placed in the JOIN condition so that available vehicles are not accidentally removed.

## Query 4 — Total Rentals Per Customer

Uses:

```sql
LEFT JOIN
COUNT()
GROUP BY
```

This allows customers with zero rentals to appear with a rental count of zero.

---

# 10. VIEW

The SQL file creates:

```text
vw_RentalReport
```

The view consolidates:

- Customer information
- Vehicle information
- Rental information
- Payment totals
- Outstanding balance

It calculates:

```text
Balance = RentalCharge - AmountPaid
```

### Why the View Is Useful

The view provides a reusable management report without requiring users to repeatedly write the same JOIN and aggregation logic.

It also presents related rental information in one convenient result set.

---

# 11. TRIGGER

The SQL file creates:

```text
trg_PreventDoubleRental
```

### Purpose

The trigger checks whether a vehicle already has an active rental.

If another active rental is attempted for the same vehicle, the trigger raises an error:

```text
Vehicle is already rented and cannot be assigned to another active rental.
```

### Business Rule Protected

A vehicle cannot be assigned to another active rental while it is already rented.

### Testing

The SQL file contains a commented test INSERT that intentionally attempts an invalid second active rental.

It is commented out so that the main script executes successfully.

Uncomment it after the initial setup if you want to demonstrate the trigger error.

---

# 12. STORED PROCEDURE

The SQL file creates:

```text
RegisterRental
```

### Input Parameters

The procedure accepts:

```text
p_customer_id
p_vehicle_id
p_rental_date
p_return_date
```

### Processing

The procedure:

1. Checks that the customer exists.
2. Checks that the vehicle exists.
3. Validates the rental and return dates.
4. Checks vehicle availability.
5. Reads the vehicle's daily rate.
6. Calculates the rental period.
7. Calculates the rental charge.
8. Inserts the rental record.
9. Changes the vehicle status to `RENTED`.
10. Returns the newly created rental information.

### Charge Calculation

The main calculation is:

```text
Rental Charge = Rental Days × Daily Rate
```

For a same-day rental, the procedure uses one rental day.

### Example

The SQL file includes a commented procedure call:

```sql
CALL RegisterRental(6, 1, '2026-09-15', '2026-09-18');
```

This can be uncommented to test the procedure using an available vehicle.

---

# 13. Optimization Analysis

## Identified Potential Inefficiency

Rental reports can repeatedly join:

```text
Rental
Customer
Vehicle
Payment
```

and calculate payment totals.

As the database grows, repeated joins and aggregation can increase query work.

## Improvement

The implementation uses indexes on important columns:

```text
Rental.CustomerID
Rental.VehicleID + RentalStatus
Rental.RentalDate + ExpectedReturnDate
Payment.RentalID
```

These indexes can help common joins and filtering operations.

The reusable `vw_RentalReport` also centralizes the commonly required consolidated rental report.

## Improved Query

When management only needs currently active rentals, the query filters:

```sql
WHERE r.RentalStatus = 'ACTIVE'
```

instead of retrieving every historical rental.

The SQL file also includes an `EXPLAIN` statement so the execution plan can be inspected in MySQL.

---

# 14. Additional Management Reports

The SQL file also includes reports for:

## Customer Rental History

Shows each customer's rental records and vehicle information.

## Currently Rented Vehicles

Shows:

- Vehicle
- Customer
- Rental date
- Expected return date
- Rental charge

for active rentals.

## Vehicle Rental Activity

Shows:

- Total rentals
- Total rental days
- Total revenue

for each vehicle.

These reports directly support the scenario's management reporting requirements.

---

# 15. How to Run the SQL File

## Step 1

Open MySQL Workbench, phpMyAdmin, or another MySQL 8.x-compatible client.

## Step 2

Open:

```text
Task_13_Open_Ended_Car_Rental.sql
```

## Step 3

Replace the student metadata placeholders at the top:

```text
[ENTER STUDENT NAME]
[ENTER ROLL NUMBER]
[ENTER INSTRUCTOR NAME]
...
```

## Step 4

Execute the complete script.

The script creates:

```text
CarGo_Rentals
```

database.

## Step 5

Verify the tables:

```sql
USE CarGo_Rentals;
SHOW TABLES;
```

Expected main tables:

```text
Customer
Vehicle
Rental
Payment
```

## Step 6

Test the VIEW:

```sql
SELECT * FROM vw_RentalReport;
```

## Step 7

Test the required JOIN queries.

## Step 8

Test the trigger using the commented invalid rental statement.

## Step 9

Test the stored procedure using the commented `CALL RegisterRental(...)`.

---

# 16. Screenshot / Output Requirements

The lab manual requires screenshots/output demonstrating execution.

After running the SQL file, take screenshots of:

1. Database and table creation
2. Sample data
3. Required JOIN Query 1 output
4. Required JOIN Query 2 output
5. Required JOIN Query 3 output
6. Required JOIN Query 4 output
7. `vw_RentalReport` output
8. Trigger validation/error demonstration
9. Stored procedure execution/result
10. Optimization / `EXPLAIN` output

Add the screenshots to the final report if your instructor requires a separate report.

---

# 17. Submission Checklist

Before submission, verify that you have:

- [x] Database creation
- [x] Table definitions
- [x] Primary keys
- [x] Foreign keys
- [x] NOT NULL constraints
- [x] UNIQUE constraints
- [x] CHECK constraints
- [x] DEFAULT values
- [x] Realistic sample data
- [x] 1NF explanation
- [x] 2NF explanation
- [x] 3NF explanation
- [x] Required JOIN Query 1
- [x] Required JOIN Query 2
- [x] Required JOIN Query 3
- [x] Required JOIN Query 4
- [x] VIEW
- [x] TRIGGER
- [x] STORED PROCEDURE
- [x] Optimization analysis
- [x] Improved query
- [x] EXPLAIN statement
- [x] Additional management reports
- [ ] Screenshots of execution
- [ ] Student information filled in

---

# 18. Important Notes

1. The exact database structure was not provided by the lab manual, so the database design is a justified implementation based on the stated CarGo Rentals scenario.
2. The main SQL script is written for MySQL 8.x.
3. The trigger demonstration that intentionally causes an error is commented out.
4. The stored procedure demonstration is commented out so the database setup remains reproducible without creating an additional rental each time.
5. Replace all student-information placeholders before final submission.
6. Screenshots must be captured from the student's own MySQL execution environment if they are required for submission.
7. Keep the SQL file and README together when submitting this ZIP.

---

# 19. Conclusion

The completed solution transforms the spreadsheet-style CarGo Rentals scenario into a structured relational database.

The design separates customers, vehicles, rentals, and payments to reduce redundancy and improve data consistency. Normalization is demonstrated through 1NF, 2NF, and 3NF. JOIN queries provide the required business reports, while the VIEW provides a reusable consolidated report. The TRIGGER protects the vehicle-availability business rule, and the STORED PROCEDURE automates rental registration and charge calculation. Indexes and a filtered reporting query provide a practical optimization approach.

This implementation addresses the major database-design, development, reporting, and optimization requirements of the open-ended lab.
