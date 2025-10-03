USE EcommerceDB;
GO

------------------------------------------------------------
-- 1. Create Stored Procedure
------------------------------------------------------------
-- Stored Procedure: Get all orders of a customer
CREATE PROCEDURE GetCustomerOrders
    @CustomerID INT
AS
BEGIN
    SELECT o.order_id, o.order_date, o.status, o.total_amount
    FROM Orders o
    WHERE o.customer_id = @CustomerID;
END;
GO

-- Execute the stored procedure
EXEC GetCustomerOrders @CustomerID = 1;

------------------------------------------------------------
-- 2. Create Function
------------------------------------------------------------
-- Function: Calculate total spent by a customer
CREATE FUNCTION GetCustomerTotalSpent (@CustomerID INT)
RETURNS DECIMAL(10,2)
AS
BEGIN
    DECLARE @Total DECIMAL(10,2);

    SELECT @Total = SUM(total_amount)
    FROM Orders
    WHERE customer_id = @CustomerID;

    RETURN ISNULL(@Total, 0);
END;
GO

-- Use the function
SELECT dbo.GetCustomerTotalSpent(1) AS TotalSpentByCustomer1;
