CREATE DATABASE EcommAppDb;
USE EcommAppDb;

CREATE TABLE categories (
    category_id INT IDENTITY(1,1) PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL
);

CREATE TABLE brands (
    brand_id INT IDENTITY(1,1) PRIMARY KEY,
    brand_name VARCHAR(100) NOT NULL
);

CREATE TABLE products (
    product_id INT IDENTITY(1,1) PRIMARY KEY,
    product_name VARCHAR(150) NOT NULL,
    brand_id INT NOT NULL,
    category_id INT NOT NULL,
    model_year SMALLINT NOT NULL,
    list_price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (brand_id) REFERENCES brands(brand_id),
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

CREATE TABLE customers (
    customer_id INT IDENTITY(1,1) PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    email VARCHAR(150)
);

CREATE TABLE stores (
    store_id INT IDENTITY(1,1) PRIMARY KEY,
    store_name VARCHAR(150),
    city VARCHAR(100)
);

CREATE TABLE staffs (
    staff_id INT IDENTITY(1,1) PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    store_id INT,
    FOREIGN KEY (store_id) REFERENCES stores(store_id)
);

CREATE TABLE orders (
    order_id INT IDENTITY(1,1) PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    store_id INT,
    staff_id INT,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (store_id) REFERENCES stores(store_id),
    FOREIGN KEY (staff_id) REFERENCES staffs(staff_id)
);


CREATE TABLE stocks (
    store_id INT,
    product_id INT,
    quantity INT,
    PRIMARY KEY (store_id, product_id),
    FOREIGN KEY (store_id) REFERENCES stores(store_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

CREATE TABLE order_items (
    order_id INT,
    product_id INT,
    quantity INT,
    list_price DECIMAL(10,2),
    discount DECIMAL(4,2),
    PRIMARY KEY (order_id, product_id),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);


--INSERTING DATA OR RECORDS INTO THE TABLES

INSERT INTO categories (category_name) VALUES
('Mountain Bikes'),
('Road Bikes'),
('Electric Bikes');

INSERT INTO brands (brand_name) VALUES
('Trek'),
('Giant'),
('Specialized');

INSERT INTO products (product_name, brand_id, category_id, model_year, list_price) VALUES
('Trek 820', 1, 1, 2022, 450.00),
('Trek Marlin 5', 1, 1, 2023, 600.00),
('Giant ATX', 2, 1, 2022, 520.00),
('Specialized Rockhopper', 3, 1, 2023, 750.00),
('Trek Domane', 1, 2, 2023, 1200.00),
('Giant Contend', 2, 2, 2022, 950.00),
('Specialized Allez', 3, 2, 2023, 1100.00),
('Trek E-Caliber', 1, 3, 2023, 3500.00),
('Giant Explore E+', 2, 3, 2022, 2800.00),
('Specialized Turbo Vado', 3, 3, 2023, 4000.00);


INSERT INTO customers (first_name, last_name, email) VALUES
('Rahul', 'Sharma', 'rahul@email.com'),
('Anita', 'Reddy', 'anita@email.com'),
('Kiran', 'Kumar', 'kiran@email.com'),
('Sneha', 'Patel', 'sneha@email.com'),
('Arjun', 'Verma', 'arjun@email.com');

INSERT INTO stores (store_name, city) VALUES
('Bike World Bangalore', 'Bangalore'),
('Cycle Hub Hyderabad', 'Hyderabad');

INSERT INTO staffs (first_name, last_name, store_id) VALUES
('Manoj', 'K', 1),
('Priya', 'S', 1),
('Ramesh', 'P', 2);


INSERT INTO orders (customer_id, order_date, store_id, staff_id) VALUES
(1, '2026-03-01', 1, 1),
(2, '2026-03-02', 1, 2),
(3, '2026-03-03', 2, 3),
(4, '2026-03-04', 1, 1),
(5, '2026-03-05', 2, 3);


INSERT INTO stocks VALUES
(1, 1, 10),
(1, 2, 15),
(1, 3, 8),
(1, 4, 12),
(1, 5, 5),
(2, 6, 9),
(2, 7, 7),
(2, 8, 6),
(2, 9, 4),
(2, 10, 3);

INSERT INTO order_items VALUES
(1, 1, 2, 450.00, 0.10),
(1, 2, 1, 600.00, 0.05),
(2, 3, 1, 520.00, 0.00),
(2, 4, 2, 750.00, 0.15),
(3, 5, 1, 1200.00, 0.10),
(4, 6, 1, 950.00, 0.05),
(4, 7, 2, 1100.00, 0.20),
(5, 8, 1, 3500.00, 0.10),
(5, 9, 1, 2800.00, 0.05),
(5, 10, 1, 4000.00, 0.10);

--LEVEL-1 PROBLEM-1

--1. Retrieve customer first name, last name, order_id, order_date, and order_status.

--2. Display only orders with status Pending (1) or Completed (4).

--3. Sort the results by order_date in descending order.

ALTER TABLE orders
ADD order_status INT;


UPDATE orders SET order_status = 1 WHERE order_id IN (1,3);
UPDATE orders SET order_status = 4 WHERE order_id IN (2,4,5);

SELECT 
    c.first_name,
    c.last_name,
    o.order_id,
    o.order_date,
    o.order_status
FROM customers c
INNER JOIN orders o
    ON c.customer_id = o.customer_id
WHERE o.order_status = 1
   OR o.order_status = 4
ORDER BY o.order_date DESC;


--LEVEL-1  PROBLEM-2
--1. Display product_name, brand_name, category_name, model_year, and list_price.

--2. Filter products with list_price greater than 500.

--3. Sort results by list_price in ascending order.


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
    ON p.category_id = c.category_id
WHERE p.list_price > 500
ORDER BY p.list_price ASC;


--LEVEL-2  PROBLEM-1
--1. Display store_name and total sales amount.

--2. Calculate total sales using (quantity * list_price * (1 - discount)).

--3. Include only completed orders (order_status = 4).

--4. Group results by store_name.

--5. Sort total sales in descending order.



SELECT 
    s.store_name,
    SUM(oi.quantity * oi.list_price * (1 - oi.discount)) AS total_sales
FROM stores s
INNER JOIN orders o
    ON s.store_id = o.store_id
INNER JOIN order_items oi
    ON o.order_id = oi.order_id
WHERE o.order_status = 4
GROUP BY s.store_name
ORDER BY total_sales DESC;


--LEVEL-2  PROBLEM-2
--1. Display product_name, store_name, available stock quantity, and total quantity sold.

--2. Include products even if they have not been sold (use appropriate join).

--3. Group results by product_name and store_name.

--4. Sort results by product_name.

SELECT 
    p.product_name,
    s.store_name,
    st.quantity AS available_stock,
    ISNULL(SUM(oi.quantity), 0) AS total_quantity_sold
FROM stocks st
INNER JOIN products p
    ON st.product_id = p.product_id
INNER JOIN stores s
    ON st.store_id = s.store_id
LEFT JOIN order_items oi
    ON st.product_id = oi.product_id
GROUP BY 
    p.product_name,
    s.store_name,
    st.quantity
ORDER BY p.product_name;
