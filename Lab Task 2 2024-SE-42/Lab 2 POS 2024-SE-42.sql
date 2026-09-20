```sql
-- ============================================================
-- LAB 02: POINT OF SALE DATABASE SYSTEM
-- Student: Syed Muhammad Hassan Gillani
-- Roll No: 2024-SE-42
-- Course: Database Systems (CS-2204)
-- Instructor Name: Engr. Awais Rathore
-- ============================================================

CREATE DATABASE IF NOT EXISTS POS_System;
USE POS_System;


-- ============================================================
-- 1. DATABASE TABLES
-- ============================================================

-- Roles
CREATE TABLE roles (
    role_id INT AUTO_INCREMENT PRIMARY KEY,
    role_name VARCHAR(50) NOT NULL UNIQUE
);

-- Permissions
CREATE TABLE permissions (
    permission_id INT AUTO_INCREMENT PRIMARY KEY,
    permission_name VARCHAR(50) NOT NULL UNIQUE
);

-- Role Permissions
CREATE TABLE role_permissions (
    role_id INT,
    permission_id INT,
    PRIMARY KEY (role_id, permission_id),
    FOREIGN KEY (role_id) REFERENCES roles(role_id),
    FOREIGN KEY (permission_id) REFERENCES permissions(permission_id)
);

-- System Users
CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    role_id INT NOT NULL,
    username VARCHAR(50) NOT NULL UNIQUE,
    user_password VARCHAR(255) NOT NULL,
    FOREIGN KEY (role_id) REFERENCES roles(role_id)
);


-- ============================================================
-- 2. PRODUCT AND INVENTORY MANAGEMENT
-- ============================================================

CREATE TABLE categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    category_id INT NOT NULL,
    product_name VARCHAR(150) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

CREATE TABLE inventory (
    inventory_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT NOT NULL,
    user_id INT NOT NULL,
    quantity_change INT NOT NULL,
    action_reason VARCHAR(50) NOT NULL,
    action_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES products(product_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);


-- ============================================================
-- 3. SALES AND DISCOUNTS
-- ============================================================

CREATE TABLE discounts (
    discount_id INT AUTO_INCREMENT PRIMARY KEY,
    discount_name VARCHAR(100) NOT NULL,
    percentage DECIMAL(5,2) NOT NULL,
    expiry_date DATETIME NOT NULL,
    active_status TINYINT DEFAULT 1
);

CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    discount_id INT NULL,
    total_amount DECIMAL(10,2) DEFAULT 0.00,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (discount_id) REFERENCES discounts(discount_id)
);

CREATE TABLE order_details (
    detail_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    purchase_price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);


-- ============================================================
-- 4. INSERT BASIC DATA
-- ============================================================

INSERT INTO roles (role_name) VALUES
('Administrator'),
('Cashier'),
('Customer');

INSERT INTO permissions (permission_name) VALUES
('View Products'),
('Add Product'),
('Edit Product'),
('Delete Product'),
('View Orders'),
('Create Order'),
('Apply Discount'),
('Manage Users'),
('View Reports'),
('Manage Inventory');

INSERT INTO role_permissions VALUES
(1,1),(1,2),(1,3),(1,4),(1,5),
(1,6),(1,7),(1,8),(1,9),(1,10),
(2,1),(2,5),(2,6),(2,7),(2,9),(2,10),
(3,1),(3,5),(3,6);


-- ============================================================
-- 5. USERS
-- ============================================================

INSERT INTO users (role_id, username, user_password) VALUES
(1,'system_admin',MD5('admin123')),
(1,'store_admin',MD5('admin456')),
(2,'cashier_ali',MD5('cash123')),
(2,'cashier_nida',MD5('cash456')),
(2,'cashier_bilal',MD5('cash789')),
(3,'customer_hassan',MD5('cust123')),
(3,'customer_sara',MD5('cust456')),
(3,'customer_umar',MD5('cust789')),
(3,'customer_hina',MD5('cust321')),
(3,'customer_ahmed',MD5('cust654'));


-- ============================================================
-- 6. PRODUCT CATEGORIES
-- ============================================================

INSERT INTO categories (category_name) VALUES
('Electronics'),
('Clothing'),
('Food'),
('Drinks'),
('Stationery'),
('Shoes'),
('Dairy'),
('Bakery'),
('Household'),
('Personal Care');


-- ============================================================
-- 7. PRODUCTS
-- ============================================================

INSERT INTO products (category_id, product_name, price) VALUES
(1,'Wireless Mouse',850.00),
(1,'USB Type-C Hub',1200.00),
(2,'Polo Shirt',950.00),
(3,'Basmati Rice 5kg',650.00),
(4,'Mineral Water 1.5L',60.00),
(5,'Ballpoint Pen Pack',120.00),
(6,'Running Shoes',3500.00),
(7,'Full Cream Milk 1L',180.00),
(8,'Whole Wheat Bread',110.00),
(9,'Dishwashing Liquid',160.00);


-- ============================================================
-- 8. INVENTORY RECORDS
-- ============================================================

INSERT INTO inventory
(product_id, user_id, quantity_change, action_reason)
VALUES
(1,1,50,'Opening Stock'),
(2,1,30,'Opening Stock'),
(3,1,100,'Opening Stock'),
(4,1,200,'Opening Stock'),
(5,3,-8,'Sale'),
(6,3,-12,'Sale'),
(7,4,20,'Restock'),
(8,4,-5,'Sale'),
(9,1,60,'Opening Stock'),
(10,3,-10,'Sale');


-- ============================================================
-- 9. DISCOUNT OFFERS
-- ============================================================

INSERT INTO discounts
(discount_name, percentage, expiry_date, active_status)
VALUES
('Summer Offer',15.00,'2026-12-31 23:59:59',1),
('Student Discount',8.00,'2026-12-31 23:59:59',1),
('Loyalty Offer',5.00,'2026-12-31 23:59:59',1),
('Weekend Deal',12.00,'2026-10-31 23:59:59',1),
('First Order',18.00,'2026-12-31 23:59:59',1);


-- ============================================================
-- 10. ORDERS
-- ============================================================

INSERT INTO orders
(user_id, discount_id, total_amount, order_date)
VALUES
(6,5,1530.00,'2026-09-01 10:15:00'),
(7,NULL,850.00,'2026-09-02 11:30:00'),
(8,3,2812.50,'2026-09-03 14:00:00'),
(9,2,900.00,'2026-09-04 09:45:00'),
(10,NULL,1200.00,'2026-09-05 16:20:00'),
(6,4,585.00,'2026-09-06 12:00:00');


-- ============================================================
-- 11. ORDER DETAILS
-- ============================================================

INSERT INTO order_details
(order_id, product_id, quantity, purchase_price)
VALUES
(1,1,1,850.00),
(1,5,8,60.00),
(2,1,1,850.00),
(3,7,1,3500.00),
(4,3,1,950.00),
(5,2,1,1200.00),
(6,4,1,650.00);


-- ============================================================
-- 12. REPORTING QUERIES
-- ============================================================

-- Q1: Display products with their categories

SELECT
    p.product_id,
    p.product_name,
    c.category_name,
    p.price
FROM products p
JOIN categories c
ON p.category_id = c.category_id
ORDER BY c.category_name;


-- Q2: Display order information

SELECT
    o.order_id,
    u.username AS customer,
    d.discount_name,
    d.percentage,
    o.total_amount,
    o.order_date
FROM orders o
JOIN users u
ON o.user_id = u.user_id
LEFT JOIN discounts d
ON o.discount_id = d.discount_id
ORDER BY o.order_date;


-- Q3: Show products purchased in each order

SELECT
    od.order_id,
    u.username,
    p.product_name,
    od.quantity,
    od.purchase_price,
    (od.quantity * od.purchase_price) AS subtotal
FROM order_details od
JOIN orders o
ON od.order_id = o.order_id
JOIN users u
ON o.user_id = u.user_id
JOIN products p
ON od.product_id = p.product_id
ORDER BY od.order_id;


-- Q4: Total amount spent by each customer

SELECT
    u.username,
    COUNT(o.order_id) AS total_orders,
    SUM(o.total_amount) AS total_spent
FROM orders o
JOIN users u
ON o.user_id = u.user_id
GROUP BY u.username
ORDER BY total_spent DESC;


-- Q5: Best-selling products

SELECT
    p.product_name,
    SUM(od.quantity) AS units_sold
FROM order_details od
JOIN products p
ON od.product_id = p.product_id
GROUP BY p.product_name
ORDER BY units_sold DESC;


-- Q6: Revenue by product category

SELECT
    c.category_name,
    SUM(od.quantity * od.purchase_price) AS revenue
FROM order_details od
JOIN products p
ON od.product_id = p.product_id
JOIN categories c
ON p.category_id = c.category_id
GROUP BY c.category_name
ORDER BY revenue DESC;


-- Q7: Currently active discounts

SELECT
    discount_name,
    percentage,
    expiry_date
FROM discounts
WHERE active_status = 1
AND expiry_date > NOW()
ORDER BY percentage DESC;


-- Q8: Discounted vs non-discounted orders

SELECT
    CASE
        WHEN discount_id IS NULL THEN 'Without Discount'
        ELSE 'With Discount'
    END AS order_type,
    COUNT(*) AS number_of_orders,
    SUM(total_amount) AS total_revenue
FROM orders
GROUP BY order_type;


-- Q9: Users and their assigned roles

SELECT
    u.username,
    r.role_name
FROM users u
JOIN roles r
ON u.role_id = r.role_id
ORDER BY r.role_name;


-- Q10: Inventory activity report

SELECT
    i.action_time,
    u.username,
    p.product_name,
    i.quantity_change,
    i.action_reason
FROM inventory i
JOIN users u
ON i.user_id = u.user_id
JOIN products p
ON i.product_id = p.product_id
ORDER BY i.action_time;

-- ============================================================
-- END OF LAB 02
-- ============================================================
```
