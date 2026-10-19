-- ============================================================
-- DAY 09: SQL AGGREGATIONS, GROUP BY & BUSINESS METRICS
-- Database: Data_Analytics_90Days
-- Environment: SQL Server / SSMS
-- ============================================================

USE Data_Analytics_90Days;
GO

-- ------------------------------------------------------------
-- BLOCK 1: BASIC AGGREGATIONS & SINGLE-DIMENSION GROUPING
-- ------------------------------------------------------------
-- Task 1.1: Gross Summary
SELECT 
    COUNT(*) AS Total_Completed_Orders,
    SUM(Order_Quantity) AS Total_Units_Sold,
    AVG(Unit_Price) AS Avg_Unit_Price,
    MIN(Unit_Price) AS Min_Unit_Price,
    MAX(Unit_Price) AS Max_Unit_Price
FROM Fact_Daily_Sales
WHERE Order_Status = 'Completed';

-- Task 1.2: Regional Revenue Aggregation
SELECT 
    Store_Region,
    COUNT(*) AS Total_Orders,
    SUM(Order_Quantity * Unit_Price) AS Gross_Revenue
FROM Fact_Daily_Sales
GROUP BY Store_Region
ORDER BY Gross_Revenue DESC;

-- Task 1.3: Distinct Segment Count
SELECT 
    Sales_Channel,
    COUNT(DISTINCT Customer_Segment) AS Unique_Segments
FROM Fact_Daily_Sales
GROUP BY Sales_Channel;

-- ------------------------------------------------------------
-- BLOCK 2: MULTI-DIMENSIONAL GROUPING & HAVING FILTERS
-- ------------------------------------------------------------
-- Task 2.1: Multi-Column Breakdown
SELECT 
    Store_Region,
    Product_Category,
    SUM((Order_Quantity * Unit_Price) - Discount_Amount) AS Net_Revenue
FROM Fact_Daily_Sales
GROUP BY Store_Region, Product_Category
ORDER BY Store_Region, Net_Revenue DESC;

-- Task 2.2: HAVING Filter on Revenue
SELECT 
    Sales_Channel,
    SUM((Order_Quantity * Unit_Price) - Discount_Amount) AS Net_Revenue
FROM Fact_Daily_Sales
WHERE Order_Status <> 'Cancelled'
GROUP BY Sales_Channel
HAVING SUM((Order_Quantity * Unit_Price) - Discount_Amount) > 5000.00;

-- Task 2.3: High-Volume Segment Filter
SELECT 
    Customer_Segment,
    SUM(Order_Quantity) AS Total_Units
FROM Fact_Daily_Sales
WHERE Order_Status = 'Completed'
GROUP BY Customer_Segment
HAVING SUM(Order_Quantity) >= 15;

-- ------------------------------------------------------------
-- BLOCK 3: BUSINESS METRICS & E-COMMERCE KPIs
-- ------------------------------------------------------------
-- Task 3.1: Average Order Value (AOV)
SELECT 
    Customer_Segment,
    COUNT(*) AS Total_Orders,
    SUM((Order_Quantity * Unit_Price) - Discount_Amount) AS Net_Revenue,
    SUM((Order_Quantity * Unit_Price) - Discount_Amount) / COUNT(*) AS AOV
FROM Fact_Daily_Sales
WHERE Order_Status = 'Completed'
GROUP BY Customer_Segment
ORDER BY AOV DESC;

-- Task 3.2: Discount Leakage Analysis
SELECT 
    Sales_Channel,
    SUM(Discount_Amount) AS Total_Discount_Given,
    AVG(Discount_Amount) AS Avg_Discount_Per_Order
FROM Fact_Daily_Sales
GROUP BY Sales_Channel
ORDER BY Total_Discount_Given DESC;

-- Task 3.3: Channel Mix Contribution %
SELECT 
    Sales_Channel,
    SUM(Order_Quantity) AS Channel_Units,
    CAST(SUM(Order_Quantity) * 100.0 / (SELECT SUM(Order_Quantity) FROM Fact_Daily_Sales) AS DECIMAL(5,2)) AS Channel_Mix_Pct
FROM Fact_Daily_Sales
GROUP BY Sales_Channel
ORDER BY Channel_Units DESC;
