
USE Data_Analytics_90Days;
GO

----------------------------------------------------
-- BLOCK 1 SOLUTIONS
----------------------------------------------------
-- Task 1.1: Scalar Subquery Benchmark
SELECT 
    Transaction_ID,
    Account_ID,
    Revenue_Amount,
    (SELECT AVG(Revenue_Amount) FROM Fact_Account_Revenue) AS Portfolio_Avg_Revenue
FROM Fact_Account_Revenue
WHERE Revenue_Amount > (SELECT AVG(Revenue_Amount) FROM Fact_Account_Revenue);

-- Task 1.2: Subquery with IN Operator
SELECT 
    Account_ID,
    Account_Name,
    Industry,
    Region
FROM Dim_Enterprise_Accounts
WHERE Account_ID IN (
    SELECT DISTINCT Account_ID 
    FROM Fact_Account_Revenue 
    WHERE Product_Category = 'Cloud Software'
);

-- Task 1.3: Correlated Subquery with EXISTS
SELECT 
    a.Account_ID,
    a.Account_Name,
    a.Region
FROM Dim_Enterprise_Accounts a
WHERE EXISTS (
    SELECT 1 
    FROM Fact_Account_Revenue r 
    WHERE r.Account_ID = a.Account_ID 
    GROUP BY r.Account_ID 
    HAVING SUM(r.Revenue_Amount) > 10000.00
);


----------------------------------------------------
-- BLOCK 2 SOLUTIONS
----------------------------------------------------
-- Task 2.1: Basic CTE Summarization
WITH Account_Totals AS (
    SELECT 
        Account_ID,
        SUM(Revenue_Amount) AS Total_Revenue,
        SUM(Cost_Amount) AS Total_Cost,
        SUM(Revenue_Amount - Cost_Amount) AS Gross_Profit
    FROM Fact_Account_Revenue
    GROUP BY Account_ID
)
SELECT 
    Account_ID,
    Total_Revenue,
    Total_Cost,
    Gross_Profit
FROM Account_Totals
ORDER BY Gross_Profit DESC;

-- Task 2.2: Multi-CTE Chaining (Corrected Transaction-Level Avg)
WITH Account_Summary AS (
    SELECT 
        r.Account_ID,
        a.Account_Name,
        a.Industry,
        SUM(r.Revenue_Amount) AS Total_Account_Revenue
    FROM Fact_Account_Revenue r
    JOIN Dim_Enterprise_Accounts a ON r.Account_ID = a.Account_ID
    GROUP BY r.Account_ID, a.Account_Name, a.Industry
),
Industry_Avg AS (
    SELECT 
        a.Industry,
        AVG(b.Revenue_Amount) AS Avg_Transaction_Revenue_Per_Industry
    FROM Account_Summary a
    INNER JOIN Fact_Account_Revenue b ON a.Account_ID = b.Account_ID
    GROUP BY a.Industry
)
SELECT 
    s.Account_ID,
    s.Account_Name,
    s.Industry,
    s.Total_Account_Revenue,
    CAST(i.Avg_Transaction_Revenue_Per_Industry AS DECIMAL(10,2)) AS Avg_Industry_Txn_Revenue
FROM Account_Summary s
JOIN Industry_Avg i ON s.Industry = i.Industry
WHERE s.Total_Account_Revenue > i.Avg_Transaction_Revenue_Per_Industry
ORDER BY s.Total_Account_Revenue DESC;

-- Task 2.3: Category Share Analysis via CTE
WITH Category_Totals AS (
    SELECT 
        Product_Category,
        SUM(Revenue_Amount) AS Category_Revenue
    FROM Fact_Account_Revenue
    GROUP BY Product_Category
)
SELECT 
    Product_Category,
    Category_Revenue,
    CAST((Category_Revenue * 100.0) / (SELECT SUM(Revenue_Amount) FROM Fact_Account_Revenue) AS DECIMAL(5,2)) AS Revenue_Share_Pct
FROM Category_Totals
ORDER BY Category_Revenue DESC;


----------------------------------------------------
-- BLOCK 3 SOLUTIONS
----------------------------------------------------
-- Task 3.1: Account Margin Contribution Ranking
WITH Account_Margin_CTE AS (
    SELECT 
        Account_ID,
        SUM(Revenue_Amount) AS Total_Revenue,
        SUM(Revenue_Amount - Cost_Amount) AS Total_Margin,
        CAST(
            (SUM(Revenue_Amount - Cost_Amount) * 100.0) / NULLIF(SUM(Revenue_Amount), 0) 
        AS DECIMAL(5,2)) AS Margin_Pct
    FROM Fact_Account_Revenue
    GROUP BY Account_ID
)
SELECT 
    a.Account_Name,
    a.Contract_Tier,
    m.Total_Revenue,
    m.Total_Margin,
    m.Margin_Pct
FROM Account_Margin_CTE m
JOIN Dim_Enterprise_Accounts a ON m.Account_ID = a.Account_ID
WHERE m.Margin_Pct > 60.00
ORDER BY m.Margin_Pct DESC;

-- Task 3.2: Tier 1 vs Non-Tier 1 Revenue Contribution
WITH Joined_Sales AS (
    SELECT 
        r.Revenue_Amount,
        a.Contract_Tier
    FROM Fact_Account_Revenue r
    JOIN Dim_Enterprise_Accounts a ON r.Account_ID = a.Account_ID
)
SELECT 
    SUM(CASE WHEN Contract_Tier = 'Tier 1' THEN Revenue_Amount ELSE 0 END) AS Tier1_Revenue,
    SUM(CASE WHEN Contract_Tier <> 'Tier 1' THEN Revenue_Amount ELSE 0 END) AS Non_Tier1_Revenue,
    SUM(Revenue_Amount) AS Total_Enterprise_Revenue,
    CAST(
        (SUM(CASE WHEN Contract_Tier = 'Tier 1' THEN Revenue_Amount ELSE 0 END) * 100.0) / SUM(Revenue_Amount)
    AS DECIMAL(5,2)) AS Tier1_Contribution_Pct
FROM Joined_Sales;
