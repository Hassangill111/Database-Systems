# Lab 02 – Point of Sale (POS) Database

## Student Information

| Detail           | Information                               |
| ---------------- | ----------------------------------------- |
| **Student Name** | Syed Muhammad Hassan Gillani              |
| **Roll Number**  | 2024-SE-42                                |
| **Program**      | BS Software Engineering                   |
| **Semester**     | 2nd Semester                              |
| **Batch**        | 2024–2028                                 |
| **University**   | University of Azad Jammu & Kashmir (UAJK) |
| **Campus**       | Chella Campus, Muzaffarabad               |
| **Department**   | Department of Software Engineering        |
| **Course**       | Database Systems                          |
| **Lab**          | Lab 02                                    |

---

## 📌 Project Overview

This project implements a **Point of Sale (POS) Database System** using MySQL.

The database is designed to manage important POS operations such as:

* User and role management
* Permission management
* Product and category management
* Inventory tracking
* Discount management
* Customer orders
* Order details
* Sales information
* Basic reporting

The database uses **Primary Keys, Foreign Keys, Constraints, and Relationships** to maintain data consistency.

---

## 🗄️ Database Structure

The database contains the following main tables:

* `roles`
* `permissions`
* `role_permissions`
* `users`
* `categories`
* `products`
* `inventory`
* `discounts`
* `orders`
* `order_details`

These tables are connected using foreign-key relationships where required.

---

## 🔐 Role & Permission Management

The system includes a simple **Role-Based Access Control (RBAC)** structure.

Users can be assigned different roles, while permissions determine the operations associated with those roles.

Example roles include:

* Administrator
* Manager
* Cashier

---

## 📦 Product & Inventory Management

The product section stores information about:

* Product name
* Product category
* Product price

The inventory table records changes in stock and keeps information about the user responsible for the operation.

---

## 🧾 Orders & Sales

The order system stores sales information through:

* Orders
* Order details
* Products
* Quantities
* Purchase prices
* Discounts
* Total amounts
* Order dates

This structure allows multiple products to be associated with a single order.

---

## 💰 Discount Management

The database includes a discount system where discount rules can contain:

* Discount name
* Percentage
* Expiry date
* Active/inactive status

Discounts can then be associated with orders.

---

## 📊 SQL Reports

The SQL file also contains different reporting queries for retrieving useful information from the database, such as:

* Product information
* Category-wise products
* Inventory changes
* User and role information
* Orders
* Order details
* Discount information
* Sales-related information

---

## ⚙️ Technologies Used

* **MySQL 8.x**
* **SQL**
* **XAMPP / MySQL**
* **phpMyAdmin or MySQL Workbench**

---

## ▶️ How to Run

1. Open **XAMPP**.
2. Start **Apache** and **MySQL**.
3. Open **phpMyAdmin**.
4. Create/open the SQL import section.
5. Import or paste the provided `.sql` file.
6. Execute the complete script.
7. The database and required tables will be created automatically.
8. Run the provided SELECT queries to view the results.

---

## 📁 Project File

```text
Lab-02-POSPOS/
│
├── Lab 2 POS 2024-SE.42.sql
└── README.md
```

---

## 🎯 Learning Objectives

Through this lab, I practiced:

* Creating a relational database
* Creating tables using SQL
* Defining primary and foreign keys
* Applying constraints
* Establishing relationships between tables
* Inserting sample records
* Managing inventory data
* Creating orders and order details
* Writing SQL queries for reporting
* Understanding database design for a real-world POS system

---

## 👨‍💻 Student

**Syed Muhammad Hassan Gillani**
**Roll No:** 2024-SE-42
**BS Software Engineering – 2nd Semester**
**University of Azad Jammu & Kashmir (UAJK)**
**Chella Campus, Muzaffarabad**

---

## 📚 Academic Project

This repository contains the work completed for **Database Systems – Lab 02** as part of the BS Software Engineering program.
