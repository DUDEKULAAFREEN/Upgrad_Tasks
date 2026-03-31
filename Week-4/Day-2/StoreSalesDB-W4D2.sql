

--Level-2 Problem 1: Transactions and Trigger Implementation

--Requirements

-- Write a transaction to insert data into orders and order_items tables.

-- Check stock availability before confirming order.

-- Create a trigger to reduce stock quantity after order insertion.

-- Rollback transaction if stock quantity is insufficient.


CREATE TRIGGER trg_AutoReduceStock
ON order_items
AFTER INSERT
AS
BEGIN

-- Check for insufficient stock (for multiple rows)
IF EXISTS (
    SELECT 1
    FROM stocks s
    JOIN inserted i
        ON s.product_id = i.product_id
        AND s.store_id = i.store_id
    GROUP BY s.product_id, s.store_id, s.quantity
    HAVING s.quantity < SUM(i.quantity)
)
BEGIN
    RAISERROR('Insufficient stock. Transaction failed.',16,1)
    ROLLBACK TRANSACTION
    RETURN
END

-- Reduce stock
UPDATE s
SET s.quantity = s.quantity - i.total_qty
FROM stocks s
JOIN (
    SELECT product_id, store_id, SUM(quantity) AS total_qty
    FROM inserted
    GROUP BY product_id, store_id
) i
ON s.product_id = i.product_id
AND s.store_id = i.store_id

END




====================================================================================================================




Level-2 Problem 2: Atomic Order Cancellation with SAVEPOINT

Requirements

- Begin a transaction when cancelling an order.

- Restore stock quantities based on order_items.

- Update order_status to 3.

- Use SAVEPOINT before stock restoration.

- If stock restoration fails, rollback to SAVEPOINT.

- Commit transaction only if all operations succeed.


ALTER TABLE orders
ADD order_status INT;



CREATE PROCEDURE sp_CancelOrder
    @order_id INT
AS
BEGIN

BEGIN TRANSACTION

BEGIN TRY

    -- Savepoint before stock restoration
    SAVE TRANSACTION sp_before_stock_restore

    -- Restore stock (add back quantities)
    UPDATE s
    SET s.quantity = s.quantity + oi.quantity
    FROM stocks s
    JOIN order_items oi
        ON s.product_id = oi.product_id
        AND s.store_id = oi.store_id
    WHERE oi.order_id = @order_id

    -- Check if any issue occurred (optional validation example)
    IF @@ROWCOUNT = 0
    BEGIN
        RAISERROR('Stock restoration failed or no items found.',16,1)
    END

    -- Update order status to Rejected (3)
    UPDATE orders
    SET order_status = 3
    WHERE order_id = @order_id

    -- Final success
    COMMIT TRANSACTION

END TRY

BEGIN CATCH

    -- Rollback only to savepoint (stock part)
    IF @@TRANCOUNT > 0
        ROLLBACK TRANSACTION sp_before_stock_restore

    PRINT 'Error: ' + ERROR_MESSAGE()

    -- Rollback full transaction
    ROLLBACK TRANSACTION

END CATCH

END