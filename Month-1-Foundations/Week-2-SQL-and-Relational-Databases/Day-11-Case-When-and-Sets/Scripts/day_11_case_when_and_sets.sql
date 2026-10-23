-- ============================================================
-- DAY 11: CONDITIONAL LOGIC, NULL SAFETY & SET OPERATORS
-- Database: Data_Analytics_90Days
-- Environment: SQL Server / SSMS
-- ============================================================

USE Data_Analytics_90Days;
GO

-- ------------------------------------------------------------
-- BLOCK 1: CONDITIONAL LOGIC & NULL SAFETY
-- ------------------------------------------------------------
-- Task 1.1: Order Value Categorization
SELECT 
    Order_ID,
    Customer_Name,
    Order_Amount,
    CASE 
        WHEN Order_Amount >= 3000.00 THEN 'Enterprise'
        WHEN Order_Amount BETWEEN 1000.00 AND 2999.99 THEN 'Mid-Market'
        WHEN Order_Amount < 1000.00 THEN 'SMB'
        ELSE 'Unprocessed'
    END AS Deal_Tier
FROM Fact_Web_Sales;

-- Task 1.2: COALESCE Discount Sanitization
SELECT 
    Order_ID,
    Customer_Name,
    COALESCE(Order_Amount, 0.00) AS Clean_Amount,
    COALESCE(Discount_Amount, 0.00) AS Clean_Discount,
    (COALESCE(Order_Amount, 0.00) - COALESCE(Discount_Amount, 0.00)) AS Net_Revenue
FROM Fact_Web_Sales;

-- Task 1.3: Division-by-Zero Protection with NULLIF
SELECT 
    Order_ID,
    Order_Amount,
    COALESCE(Discount_Amount, 0.00) AS Discount_Amount,
    CAST(
        (COALESCE(Discount_Amount, 0.00) * 100.0) / NULLIF(Order_Amount, 0.00) 
    AS DECIMAL(5, 2)) AS Effective_Discount_Pct
FROM Fact_Web_Sales;

-- ------------------------------------------------------------
-- BLOCK 2: SET OPERATIONS ACROSS CHANNELS
-- ------------------------------------------------------------
-- Task 2.1: Full Portfolio Union (UNION ALL vs UNION)
-- UNION ALL (Preserves duplicates)
SELECT Order_ID, Customer_Name, Product_Category, Order_Amount, 'WEB' AS Channel FROM Fact_Web_Sales
UNION ALL
SELECT Order_ID, Customer_Name, Product_Category, Order_Amount, 'STORE' AS Channel FROM Fact_Store_Sales;

-- UNION (Deduplicates exact matches)
SELECT Customer_Name, Product_Category FROM Fact_Web_Sales
UNION
SELECT Customer_Name, Product_Category FROM Fact_Store_Sales;

-- Task 2.2: Cross-Channel Customer Overlap (INTERSECT)
SELECT Customer_Name FROM Fact_Web_Sales
INTERSECT
SELECT Customer_Name FROM Fact_Store_Sales;

-- Task 2.3: Channel Exclusivity Audit (EXCEPT)
SELECT Customer_Name FROM Fact_Web_Sales
EXCEPT
SELECT Customer_Name FROM Fact_Store_Sales;

-- ------------------------------------------------------------
-- BLOCK 3: BUSINESS METRICS & CONDITIONAL AGGREGATIONS
-- ------------------------------------------------------------
-- Task 3.1: Conditional Aggregation / Revenue Pivot
WITH Consolidated_Sales AS (
    SELECT Product_Category, Order_Amount, Discount_Amount, Order_Status FROM Fact_Web_Sales
    UNION ALL
    SELECT Product_Category, Order_Amount, Discount_Amount, Order_Status FROM Fact_Store_Sales
)
SELECT 
    Product_Category,
    SUM(CASE 
        WHEN Order_Status = 'Completed' THEN (COALESCE(Order_Amount, 0) - COALESCE(Discount_Amount, 0)) 
        ELSE 0 
    END) AS Completed_Revenue,
    SUM(CASE 
        WHEN Order_Status <> 'Completed' THEN (COALESCE(Order_Amount, 0) - COALESCE(Discount_Amount, 0)) 
        ELSE 0 
    END) AS Non_Completed_Revenue
FROM Consolidated_Sales
GROUP BY Product_Category;

-- Task 3.2: Executive Order Status Summary
WITH Consolidated_Sales AS (
    SELECT Product_Category, Order_Status FROM Fact_Web_Sales
    UNION ALL
    SELECT Product_Category, Order_Status FROM Fact_Store_Sales
)
SELECT 
    Product_Category,
    COUNT(CASE WHEN Order_Status = 'Completed' THEN 1 END) AS Completed_Orders_Count,
    COUNT(CASE WHEN Order_Status = 'Pending' THEN 1 END) AS Pending_Orders_Count,
    COUNT(CASE WHEN Order_Status = 'Cancelled' THEN 1 END) AS Cancelled_Orders_Count
FROM Consolidated_Sales
GROUP BY Product_Category;
