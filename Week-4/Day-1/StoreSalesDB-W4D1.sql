CREATE DATABASE StoreSalesDB;


USE StoreSalesDB;

--Stores Table

CREATE TABLE stores (
    store_id INT IDENTITY(1,1) PRIMARY KEY,
    store_name VARCHAR(100) NOT NULL
);

--Products Table

CREATE TABLE products (
    product_id INT IDENTITY(1,1) PRIMARY KEY,
    product_name VARCHAR(150) NOT NULL
);

--Orders Table
CREATE TABLE orders (
    order_id INT IDENTITY(1,1) PRIMARY KEY,
    store_id INT,
    order_date DATE,
    FOREIGN KEY (store_id) REFERENCES stores(store_id)
);
--Order Items Table
CREATE TABLE order_items (
    item_id INT IDENTITY(1,1) PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    price DECIMAL(10,2),
    discount DECIMAL(5,2) NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);





CREATE FUNCTION fn_TotalPriceAfterDiscount
(
    @price DECIMAL(10,2),
    @quantity INT,
    @discount DECIMAL(5,2)
)
RETURNS DECIMAL(10,2)
AS
BEGIN

    DECLARE @total DECIMAL(10,2)

    SET @discount = ISNULL(@discount,0)

    SET @total = (@price * @quantity) - ((@price * @quantity) * @discount / 100)

    RETURN @total

END


CREATE PROCEDURE sp_TotalSalesPerStore
AS
BEGIN

SELECT 
    s.store_name,
    SUM(dbo.fn_TotalPriceAfterDiscount(oi.price,oi.quantity,oi.discount)) AS TotalSales
FROM stores s
JOIN orders o ON s.store_id = o.store_id
JOIN order_items oi ON o.order_id = oi.order_id
GROUP BY s.store_name

END


CREATE PROCEDURE sp_GetOrdersByDateRange
(
    @StartDate DATE,
    @EndDate DATE
)
AS
BEGIN

SELECT *
FROM orders
WHERE order_date BETWEEN @StartDate AND @EndDate

END

CREATE FUNCTION fn_Top5SellingProducts()
RETURNS TABLE
AS
RETURN
(
    SELECT TOP 5 
        p.product_name,
        SUM(oi.quantity) AS TotalSold
    FROM products p
    JOIN order_items oi ON p.product_id = oi.product_id
    GROUP BY p.product_name
    ORDER BY TotalSold DESC
)

==================================================================


--Level-2 Problem 2: Stock Auto-Update Trigger



-- Create an AFTER INSERT trigger on order_items.

-- Reduce the corresponding quantity in stocks table.

-- Prevent stock from becoming negative.

-- If stock is insufficient, rollback the transaction with a custom error message.

CREATE TRIGGER trg_UpdateStockAfterOrder
ON order_items
AFTER INSERT
AS
BEGIN

-- Check if stock is insufficient
IF EXISTS (
    SELECT 1
    FROM stocks s
    JOIN inserted i 
        ON s.product_id = i.product_id 
        AND s.store_id = i.store_id
    WHERE s.quantity < i.quantity
)
BEGIN
    RAISERROR ('Insufficient stock for the product.',16,1)
    ROLLBACK TRANSACTION
    RETURN
END

-- Reduce stock quantity
UPDATE s
SET s.quantity = s.quantity - i.quantity
FROM stocks s
JOIN inserted i
    ON s.product_id = i.product_id
    AND s.store_id = i.store_id

END

