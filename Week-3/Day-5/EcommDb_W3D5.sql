--Level-1 Problem 1: Basic Setup and Data Retrieval in EcommDb

--Requirements

-- Create EcommDb and all tables using the provided schema.

-- Insert at least 5 records in categories, brands, products, customers, and stores.

-- Write SELECT queries to retrieve all products with their brand and category names.

-- Retrieve all customers from a specific city.

-- Display total number of products available in each category.



-- Requirement: Create EcommDb database

CREATE DATABASE EcommDb;


USE EcommDb;

-- Categories table
CREATE TABLE categories (
    category_id INT IDENTITY(1,1) PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL
);

-- Brands table
CREATE TABLE brands (
    brand_id INT IDENTITY(1,1) PRIMARY KEY,
    brand_name VARCHAR(100) NOT NULL
);

-- Products table
CREATE TABLE products (
    product_id INT IDENTITY(1,1) PRIMARY KEY,
    product_name VARCHAR(150) NOT NULL,
    brand_id INT,
    category_id INT,
    model_year INT,
    list_price DECIMAL(10,2),
    FOREIGN KEY (brand_id) REFERENCES brands(brand_id),
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

-- Customers table
CREATE TABLE customers (
    customer_id INT IDENTITY(1,1) PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    city VARCHAR(100)
);

-- Stores table
CREATE TABLE stores (
    store_id INT IDENTITY(1,1) PRIMARY KEY,
    store_name VARCHAR(150),
    city VARCHAR(100)
);


INSERT INTO categories (category_name) VALUES
('Mountain Bikes'),
('Road Bikes'),
('Electric Bikes'),
('Hybrid Bikes'),
('Kids Bikes');

INSERT INTO brands (brand_name) VALUES
('Trek'),
('Giant'),
('Specialized'),
('Cannondale'),
('Scott');


INSERT INTO products (product_name, brand_id, category_id, model_year, list_price) VALUES
('Trek 820',1,1,2022,450),
('Giant ATX',2,1,2023,520),
('Specialized Allez',3,2,2023,1100),
('Cannondale Quick',4,4,2022,900),
('Scott Voltage',5,5,2023,300);

INSERT INTO customers (first_name,last_name,city) VALUES
('Rahul','Sharma','Bangalore'),
('Anita','Reddy','Hyderabad'),
('Kiran','Kumar','Bangalore'),
('Sneha','Patel','Mumbai'),
('Arjun','Verma','Hyderabad');

INSERT INTO stores (store_name,city) VALUES
('Bike World','Bangalore'),
('Cycle Hub','Hyderabad'),
('Urban Bikes','Mumbai'),
('Pro Cycling','Delhi'),
('Ride Zone','Chennai');


-- Requirement: Display products with brand and category names

SELECT 
    p.product_name,
    b.brand_name,
    c.category_name,
    p.model_year,
    p.list_price
FROM products p
INNER JOIN brands b
    ON p.brand_id = b.brand_id
INNER JOIN categories c
    ON p.category_id = c.category_id;

SELECT *
FROM customers
WHERE city = 'Bangalore';



-- Requirement: Count products per category

SELECT 
    c.category_name,
    COUNT(p.product_id) AS total_products
FROM categories c
LEFT JOIN products p
    ON c.category_id = p.category_id
GROUP BY c.category_name;



============================================================================================================================

--Level-1 Problem 2: Creating Views and Indexes for Performance
-- Create a view that shows product name, brand name, category name, model year and list price.

-- Requirement: Create view for product details

CREATE VIEW vw_ProductDetails
AS
SELECT 
    p.product_name,
    b.brand_name,
    c.category_name,
    p.model_year,
    p.list_price
FROM products p
INNER JOIN brands b
    ON p.brand_id = b.brand_id
INNER JOIN categories c
    ON p.category_id = c.category_id;

--Test the View
SELECT * FROM vw_ProductDetails;

-- Create a view that shows order details with customer name, store name and staff name.

SELECT * FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_NAME = 'orders';


-- Staffs table
CREATE TABLE staffs (
    staff_id INT IDENTITY(1,1) PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    store_id INT
);

-- Orders table
CREATE TABLE orders (
    order_id INT IDENTITY(1,1) PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    store_id INT,
    staff_id INT
);

-- Requirement: Create order summary view

CREATE VIEW vw_OrderSummary
AS
SELECT 
    o.order_id,
    c.first_name + ' ' + c.last_name AS customer_name,
    s.store_name,
    st.first_name + ' ' + st.last_name AS staff_name,
    o.order_date
FROM orders o
INNER JOIN customers c
    ON o.customer_id = c.customer_id
INNER JOIN stores s
    ON o.store_id = s.store_id
INNER JOIN staffs st
    ON o.staff_id = st.staff_id;

--Test the view
SELECT * FROM vw_OrderSummary;


-- Create appropriate indexes on foreign key columns.

-- Create order_items table

CREATE TABLE order_items (
    order_id INT,
    product_id INT,
    quantity INT,
    list_price DECIMAL(10,2),
    discount DECIMAL(4,2),
    PRIMARY KEY (order_id, product_id)
);


ALTER TABLE order_items
ADD CONSTRAINT FK_orderitems_orders
FOREIGN KEY (order_id) REFERENCES orders(order_id);

ALTER TABLE order_items
ADD CONSTRAINT FK_orderitems_products
FOREIGN KEY (product_id) REFERENCES products(product_id);


DROP INDEX idx_products_brand ON products;

CREATE INDEX idx_products_brand
ON products(brand_id);

CREATE INDEX idx_orderitems_product
ON order_items(product_id);


-- Index on products.brand_id
CREATE INDEX idx_products_brand
ON products(brand_id);

-- Index on products.category_id
CREATE INDEX idx_products_category
ON products(category_id);

-- Index on orders.customer_id
CREATE INDEX idx_orders_customer
ON orders(customer_id);

-- Index on orders.store_id
CREATE INDEX idx_orders_store
ON orders(store_id);

-- Index on orders.staff_id
CREATE INDEX idx_orders_staff
ON orders(staff_id);

-- Index on order_items.product_id
CREATE INDEX idx_orderitems_product
ON order_items(product_id);

-- Test performance improvement using execution plan.

SELECT *
FROM vw_ProductDetails
WHERE category_name = 'Mountain Bikes';

