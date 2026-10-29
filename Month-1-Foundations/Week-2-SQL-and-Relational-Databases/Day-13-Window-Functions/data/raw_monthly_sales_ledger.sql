-- ============================================================
-- DAY 13: ANALYTICAL WINDOW FUNCTIONS & WINDOW FRAMING
-- Database: Data_Analytics_90Days
-- Environment: SQL Server / SSMS
-- ============================================================

USE Data_Analytics_90Days;
GO

-- ------------------------------------------------------------
-- BLOCK 1: RANKING FUNCTION DRILLS
-- ------------------------------------------------------------
-- Task 1.1: Ranking Tie Behavior Analysis
SELECT 
    Sales_Rep,
    Order_Month,
    Monthly_Revenue,
    ROW_NUMBER() OVER(ORDER BY Monthly_Revenue DESC) AS RowNum,
    RANK() OVER(ORDER BY Monthly_Revenue DESC) AS RankNum,
    DENSE_RANK() OVER(ORDER BY Monthly_Revenue DESC) AS DenseRankNum,
    NTILE(4) OVER(ORDER BY Monthly_Revenue DESC) AS Quartile
FROM Fact_Monthly_Sales_Ledger;

-- Task 1.2: Top Performing Month per Rep
WITH Ranked_Sales AS (
    SELECT 
        Sales_Rep,
        Order_Month,
        Monthly_Revenue,
        Deals_Closed,
        ROW_NUMBER() OVER(PARTITION BY Sales_Rep ORDER BY Monthly_Revenue DESC) AS Rep_Rank
    FROM Fact_Monthly_Sales_Ledger
)
SELECT 
    Sales_Rep,
    Order_Month AS Peak_Month,
    Monthly_Revenue AS Peak_Revenue,
    Deals_Closed
FROM Ranked_Sales
WHERE Rep_Rank = 1;

-- Task 1.3: Regional Tier Categorization (Corrected Mapping)
WITH Regional_Tiers AS (
    SELECT 
        Sales_Rep,
        Region,
        Order_Month,
        Monthly_Revenue,
        NTILE(3) OVER(PARTITION BY Region ORDER BY Monthly_Revenue DESC) AS Tier_Bucket
    FROM Fact_Monthly_Sales_Ledger
)
SELECT 
    Sales_Rep,
    Region,
    Order_Month,
    Monthly_Revenue,
    CASE 
        WHEN Tier_Bucket = 1 THEN 'High'
        WHEN Tier_Bucket = 2 THEN 'Mid'
        WHEN Tier_Bucket = 3 THEN 'Low'
    END AS Performance_Tier
FROM Regional_Tiers
ORDER BY Region, Monthly_Revenue DESC;

-- ------------------------------------------------------------
-- BLOCK 2: VALUE FUNCTIONS & TIME-SERIES GROWTH
-- ------------------------------------------------------------
-- Task 2.1: Prior Month Revenue via LAG
SELECT 
    Sales_Rep,
    Order_Month,
    Monthly_Revenue,
    LAG(Monthly_Revenue, 1) OVER(PARTITION BY Sales_Rep ORDER BY Order_Month) AS Prior_Month_Revenue
FROM Fact_Monthly_Sales_Ledger;

-- Task 2.2: Month-over-Month Growth %
WITH Monthly_Comparison AS (
    SELECT 
        Sales_Rep,
        Order_Month,
        Monthly_Revenue,
        LAG(Monthly_Revenue, 1) OVER(PARTITION BY Sales_Rep ORDER BY Order_Month) AS Prior_Month_Revenue
    FROM Fact_Monthly_Sales_Ledger
)
SELECT 
    Sales_Rep,
    Order_Month,
    Monthly_Revenue,
    Prior_Month_Revenue,
    CAST(
        ((Monthly_Revenue - Prior_Month_Revenue) * 100.0) / NULLIF(Prior_Month_Revenue, 0)
    AS DECIMAL(5,2)) AS MoM_Growth_Pct
FROM Monthly_Comparison;

-- Task 2.3: Next Month Target Comparison via LEAD
SELECT 
    Sales_Rep,
    Order_Month,
    Monthly_Revenue,
    LEAD(Monthly_Revenue, 1) OVER(PARTITION BY Sales_Rep ORDER BY Order_Month) AS Next_Month_Revenue
FROM Fact_Monthly_Sales_Ledger;

-- ------------------------------------------------------------
-- BLOCK 3: WINDOW FRAMING & ROLLING SUMMARIES
-- ------------------------------------------------------------
-- Task 3.1: Cumulative YTD Revenue Running Total
SELECT 
    Sales_Rep,
    Order_Month,
    Monthly_Revenue,
    SUM(Monthly_Revenue) OVER(
        PARTITION BY Sales_Rep 
        ORDER BY Order_Month 
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS Cumulative_YTD_Revenue
FROM Fact_Monthly_Sales_Ledger;

-- Task 3.2: Rolling 3-Month Average Revenue
SELECT 
    Sales_Rep,
    Order_Month,
    Monthly_Revenue,
    CAST(
        AVG(Monthly_Revenue) OVER(
            PARTITION BY Sales_Rep 
            ORDER BY Order_Month 
            ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
        ) 
    AS DECIMAL(10,2)) AS Rolling_3Month_Avg_Revenue
FROM Fact_Monthly_Sales_Ledger;

-- Task 3.3: Regional Contribution % without GROUP BY
SELECT 
    Region,
    Sales_Rep,
    Order_Month,
    Monthly_Revenue,
    SUM(Monthly_Revenue) OVER(PARTITION BY Region) AS Total_Regional_Revenue,
    CAST(
        (Monthly_Revenue * 100.0) / SUM(Monthly_Revenue) OVER(PARTITION BY Region)
    AS DECIMAL(5,2)) AS Regional_Contribution_Pct
FROM Fact_Monthly_Sales_Ledger
ORDER BY Region, Order_Month;