-- ============================================================
-- DAY 10: MULTI-TABLE JOINS, ERD DESIGN & RELATIONAL SCHEMA
-- Database: Data_Analytics_90Days
-- Environment: SQL Server / SSMS
-- ============================================================

USE Data_Analytics_90Days;
GO

-- ------------------------------------------------------------
-- BLOCK 1: RELATIONAL FOUNDATIONS & TWO-TABLE INNER JOINS
-- ------------------------------------------------------------
-- Task 1.1: Customer Purchase Ledger
SELECT 
    o.Order_ID,
    c.Customer_Name,
    c.Region,
    (o.Order_Quantity * o.Selling_Price) AS Gross_Revenue
FROM Fact_Orders o
INNER JOIN Dim_Customers c ON o.Customer_ID = c.Customer_ID;

-- Task 1.2: Product Profitability Join
SELECT 
    o.Order_ID,
    p.Product_Name,
    o.Order_Quantity,
    (o.Selling_Price - p.Unit_Cost) * o.Order_Quantity AS Total_Margin
FROM Fact_Orders o
INNER JOIN Dim_Products p ON o.Product_ID = p.Product_ID;

-- Task 1.3: Segment Order Breakdown
SELECT 
    c.Customer_Segment,
    COUNT(o.Order_ID) AS Total_Orders,
    SUM(o.Order_Quantity * o.Selling_Price) AS Segment_Revenue
FROM Fact_Orders o
INNER JOIN Dim_Customers c ON o.Customer_ID = c.Customer_ID
GROUP BY c.Customer_Segment;

-- ------------------------------------------------------------
-- BLOCK 2: MULTI-TABLE JOINS & OUTER JOIN ANALYSIS
-- ------------------------------------------------------------
-- Task 2.1: Full 3-Table Star Schema Join
SELECT 
    o.Order_ID,
    c.Customer_Name,
    p.Product_Name,
    p.Category,
    (o.Order_Quantity * o.Selling_Price) AS Total_Revenue
FROM Fact_Orders o
INNER JOIN Dim_Customers c ON o.Customer_ID = c.Customer_ID
INNER JOIN Dim_Products p ON o.Product_ID = p.Product_ID;

-- Task 2.2: Customer Retention Audit via LEFT JOIN
SELECT 
    c.Customer_ID,
    c.Customer_Name,
    c.Region
FROM Dim_Customers c
LEFT JOIN Fact_Orders o ON c.Customer_ID = o.Customer_ID
WHERE o.Order_ID IS NULL;

-- Task 2.3: Unsold Product Inventory via FULL OUTER JOIN
SELECT 
    p.Product_ID,
    p.Product_Name,
    p.Category
FROM Dim_Products p
LEFT JOIN Fact_Orders o ON p.Product_ID = o.Product_ID
WHERE o.Order_ID IS NULL;

-- ------------------------------------------------------------
-- BLOCK 3: COMPLEX RELATIONAL BUSINESS METRICS
-- ------------------------------------------------------------
-- Task 3.1: Regional Margin % by Category
SELECT 
    c.Region,
    p.Category,
    SUM(o.Order_Quantity * o.Selling_Price) AS Gross_Sales,
    SUM(o.Order_Quantity * (o.Selling_Price - p.Unit_Cost)) AS Net_Profit,
    CAST(
        (SUM(o.Order_Quantity * (o.Selling_Price - p.Unit_Cost)) * 100.0) / 
        NULLIF(SUM(o.Order_Quantity * o.Selling_Price), 0) 
    AS DECIMAL(5, 2)) AS Gross_Margin_Pct
FROM Fact_Orders o
INNER JOIN Dim_Customers c ON o.Customer_ID = c.Customer_ID
INNER JOIN Dim_Products p ON o.Product_ID = p.Product_ID
GROUP BY c.Region, p.Category;

-- Task 3.2: Customer Lifetime Revenue Ranking
SELECT 
    c.Customer_ID,
    c.Customer_Name,
    COUNT(o.Order_ID) AS Total_Orders,
    SUM(o.Order_Quantity * o.Selling_Price) AS Lifetime_Revenue
FROM Dim_Customers c
INNER JOIN Fact_Orders o ON c.Customer_ID = o.Customer_ID
GROUP BY c.Customer_ID, c.Customer_Name
ORDER BY Lifetime_Revenue DESC;

-- Task 3.3: Cross-Channel Category Performance
SELECT 
    o.Sales_Channel,
    p.Category,
    SUM(o.Order_Quantity) AS Total_Units_Sold,
    AVG(o.Selling_Price) AS Avg_Selling_Price
FROM Fact_Orders o
INNER JOIN Dim_Products p ON o.Product_ID = p.Product_ID
GROUP BY o.Sales_Channel, p.Category
ORDER BY o.Sales_Channel, Total_Units_Sold DESC;
