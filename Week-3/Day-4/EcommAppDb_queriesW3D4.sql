--Level-1: Problem 1 – Product Analysis Using Nested Queries

--1. Retrieve product details (product_name, model_year, list_price).

--2. Compare each product’s price with the average price of products in the same category using a nested query.

--3. Display only those products whose price is greater than the category average.

--4. Show calculated difference between product price and category average.

--5. Concatenate product name and model year as a single column (e.g., 'ProductName (2017)').



-- Requirement 1: Retrieve product details (product_name, model_year, list_price)

SELECT 

    -- Requirement 5: Concatenate product name and model year using string manipulation
    p.product_name + ' (' + CAST(p.model_year AS VARCHAR(4)) + ')' AS product_details,

    p.product_name,
    p.model_year,
    p.list_price,

    -- Requirement 4: Calculate difference between product price and category average
    p.list_price -
    (
        -- Requirement 2: Nested query to calculate average price of the same category
        SELECT AVG(p2.list_price)
        FROM products p2
        WHERE p2.category_id = p.category_id
    ) AS price_difference

FROM products p

-- Requirement 3: Display only products priced higher than category average
-- Technical Constraint: Subquery used in WHERE clause
WHERE p.list_price >
(
    -- Requirement 2: AVG() aggregate function used in nested query
    SELECT AVG(p3.list_price)
    FROM products p3
    WHERE p3.category_id = p.category_id
);


==========================================================================================================

--Level-1: Problem 2 – Customer Activity Classification

--1. Use nested query to calculate total order value per customer.

--2. Classify customers using conditional logic:

-- - 'Premium' if total order value > 10000

-- - 'Regular' if total order value between 5000 and 10000

-- - 'Basic' if total order value < 5000

--3. Use UNION to display customers with orders and customers without orders.

--4. Display full name using string concatenation.

--5. Handle NULL cases appropriately.


-- Customers who have placed orders

SELECT 
    c.customer_id,

    -- Requirement 4: Display full name using string concatenation
    c.first_name + ' ' + c.last_name AS full_name,

    -- Requirement 1: Nested query to calculate total order value per customer
    (
        SELECT SUM(oi.quantity * oi.list_price * (1 - oi.discount))
        FROM orders o
        JOIN order_items oi 
            ON o.order_id = oi.order_id
        WHERE o.customer_id = c.customer_id
    ) AS total_order_value,

    -- Requirement 2: Classify customers using CASE statement
    CASE
        WHEN (
            SELECT SUM(oi.quantity * oi.list_price * (1 - oi.discount))
            FROM orders o
            JOIN order_items oi 
                ON o.order_id = oi.order_id
            WHERE o.customer_id = c.customer_id
        ) > 10000 THEN 'Premium'

        WHEN (
            SELECT SUM(oi.quantity * oi.list_price * (1 - oi.discount))
            FROM orders o
            JOIN order_items oi 
                ON o.order_id = oi.order_id
            WHERE o.customer_id = c.customer_id
        ) BETWEEN 5000 AND 10000 THEN 'Regular'

        ELSE 'Basic'
    END AS customer_category

FROM customers c

-- Technical Constraint: JOIN between customers and orders
JOIN orders o
    ON c.customer_id = o.customer_id

GROUP BY c.customer_id, c.first_name, c.last_name


-- Requirement 3: UNION to include customers without orders
UNION


SELECT 
    c.customer_id,

    -- Requirement 4: Full name concatenation
    c.first_name + ' ' + c.last_name AS full_name,

    -- Requirement 5: Handle NULL case for customers without orders
    NULL AS total_order_value,

    -- Customers without orders classified as Basic
    'Basic' AS customer_category

FROM customers c

-- Identify customers without orders
WHERE c.customer_id NOT IN
(
    SELECT customer_id FROM orders
);


==================================================================================================
--Level-2: Problem 3 – Store Performance and Stock Validation

--Requirements

--1. Identify products sold in each store using nested queries.

--2. Compare sold products with current stock using INTERSECT and EXCEPT operators.

--3. Display store_name, product_name, total quantity sold.

--4. Calculate total revenue per product (quantity × list_price – discount).

--5. Update stock quantity to 0 for discontinued products (simulation).



-- Requirement 1: Identify products sold in each store using subquery in FROM clause

SELECT 
    s.store_name,           -- Requirement 3: Display store_name
    p.product_name,         -- Requirement 3: Display product_name

    -- Requirement 3: Total quantity sold
    SUM(sp.quantity) AS total_quantity_sold,

    -- Requirement 4: Revenue calculation using arithmetic expression
    SUM(sp.quantity * sp.list_price * (1 - sp.discount)) AS total_revenue

FROM
(
    -- Subquery to retrieve sold products from orders and order_items
    SELECT 
        o.store_id,
        oi.product_id,
        oi.quantity,
        oi.list_price,
        oi.discount
    FROM orders o
    JOIN order_items oi
        ON o.order_id = oi.order_id
) sp

-- Join with stores table
INNER JOIN stores s
    ON sp.store_id = s.store_id

-- Join with products table
INNER JOIN products p
    ON sp.product_id = p.product_id

GROUP BY s.store_name, p.product_name;

=================================================================================================

--Level-2: Problem 4 – Order Cleanup and Data Maintenance

--Requirements

--1. Insert archived records into a new table (archived_orders) using INSERT INTO SELECT.

--2. Delete orders where order_status = 3 (Rejected) and older than 1 year.

--3. Use nested query to identify customers whose all orders are completed.

--4. Display order processing delay (DATEDIFF between shipped_date and order_date).

--5. Mark orders as 'Delayed' or 'On Time' using CASE expression based on required_date.



-- Create archived_orders table first

CREATE TABLE archived_orders
(
    order_id INT,
    customer_id INT,
    order_date DATE,
    store_id INT,
    staff_id INT,
    order_status INT
);

-- Requirement 1: Insert rejected orders older than 1 year into archived_orders table

INSERT INTO archived_orders
SELECT 
    order_id,
    customer_id,
    order_date,
    store_id,
    staff_id,
    order_status
FROM orders
WHERE order_status = 3
AND order_date < DATEADD(YEAR, -1, GETDATE());

-- Requirement 2: Delete rejected orders older than 1 year

DELETE FROM orders
WHERE order_status = 3
AND order_date < DATEADD(YEAR, -1, GETDATE());

-- Requirement 3: Identify customers whose all orders are completed

SELECT c.customer_id,
       c.first_name + ' ' + c.last_name AS customer_name
FROM customers c
WHERE NOT EXISTS
(
    SELECT 1
    FROM orders o
    WHERE o.customer_id = c.customer_id
    AND o.order_status <> 4
);

-- Requirement 4: Calculate processing delay between order_date and shipped_date

SELECT 
    order_id,
    order_date,
    shipped_date,
    DATEDIFF(DAY, order_date, shipped_date) AS processing_delay_days
FROM orders;

-- Requirement 5: Classify orders as Delayed or On Time


-- Add required_date and shipped_date columns to orders table

ALTER TABLE orders
ADD required_date DATE,
    shipped_date DATE;

-- Update sample values for testing

UPDATE orders
SET required_date = DATEADD(DAY, 5, order_date),
    shipped_date = DATEADD(DAY, 3, order_date);

SELECT 
    order_id,
    order_date,
    required_date,
    shipped_date,
    CASE
        WHEN shipped_date > required_date THEN 'Delayed'
        ELSE 'On Time'
    END AS delivery_status
FROM orders;
