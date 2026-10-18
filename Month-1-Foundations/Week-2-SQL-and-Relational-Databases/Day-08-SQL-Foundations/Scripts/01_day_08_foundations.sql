-- 1. Create Database
CREATE DATABASE Data_Analytics_90Days;
GO

USE Data_Analytics_90Days;
GO

-- 2. Create Raw Transactions Table
CREATE TABLE Fact_Transactions (
    Transaction_ID VARCHAR(20) PRIMARY KEY,
    Customer_Name VARCHAR(100) NOT NULL,
    Customer_Email VARCHAR(100),
    Order_Date DATE NOT NULL,
    Region VARCHAR(50),
    Sales_Channel VARCHAR(50),
    Product_Category VARCHAR(50),
    Order_Amount DECIMAL(10, 2),
    Account_Status VARCHAR(20)
);

-- 3. Insert Raw Dataset
INSERT INTO Fact_Transactions 
(Transaction_ID, Customer_Name, Customer_Email, Order_Date, Region, Sales_Channel, Product_Category, Order_Amount, Account_Status)
VALUES
('TXN-1001', 'Johnathon Smith', 'johnathon.smith@techcorp.com', '2026-10-01', 'North', 'ONLINE_WEB', 'Electronics', 1250.00, 'Active'),
('TXN-1002', 'Maria Garcia', 'maria_g@express-logistics.net', '2026-10-01', 'South', 'RETAIL_STORE', 'Apparel', 320.50, 'Active'),
('TXN-1003', 'David Lee', 'david.lee@innovate.org', '2026-10-02', 'East', 'ONLINE_APP', 'Furniture', 450.00, 'Pending'),
('TXN-1004', 'Sarah-Jane Parker', 's.parker@retailhub.co.uk', '2026-10-02', 'West', 'RETAIL_STORE', 'Electronics', 4100.00, 'Active'),
('TXN-1005', 'Robert Johnson', 'bob.j@global-store.com', '2026-10-03', 'North', 'ONLINE_WEB', 'Apparel', 890.00, 'Inactive'),
('TXN-1006', 'Emily Davis', 'emily.davis@techcorp.com', '2026-10-03', 'South', 'ONLINE_APP', 'Electronics', 2100.00, 'Active'),
('TXN-1007', 'Michael Brown', 'mbrown@consulting.com', '2026-10-04', 'East', 'RETAIL_STORE', 'Furniture', 150.00, 'Active'),
('TXN-1008', 'Jessica Taylor', 'jessica.t@innovate.org', '2026-10-05', 'West', 'ONLINE_WEB', 'Apparel', 1200.00, 'Pending');
GO
----------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------
/*Block 1 Challenge Tasks
Task 1.1 (Metadata Inspection): Write a query to inspect the structure and data types of Fact_Transactions using system views or sp_help.*/

EXEC sp_help 'Fact_Transactions';

--------------------------------
/*Task 1.2 (Constraint Verification): Write an INSERT statement that deliberately attempts to violate the PRIMARY KEY constraint on Transaction_ID = 'TXN-1001' to observe and record the exact T-SQL error message.*/
--------------------------------
INSERT INTO Fact_Transactions 
(Transaction_ID, Customer_Name, Customer_Email, Order_Date, Region, Sales_Channel, Product_Category, Order_Amount, Account_Status)
VALUES ('TXN-1001', 'Duplicate Test', 'test@test.com', '2026-10-06', 'North', 'ONLINE_WEB', 'Apparel', 100.00, 'Active');
--------------------------------
/*Task 1.3 (Column Alias & Ordering): Select Customer_Name, Order_Amount, and Order_Date aliased as [Client], [Revenue], and [Date], displaying the results sorted by [Revenue] in descending order.*/
--------------------------------
SELECT
Customer_Name AS Client,
Order_Amount AS Revenue,
Order_Date AS Date
FROM dbo.Fact_Transactions
Order BY Order_Amount Desc

--------------------------------
/*Block 2: Filtering & Wildcard Query Drills
Block 2 Challenge Tasks
Task 2.1 (Domain Wildcards & Status): Retrieve all records where Account_Status = 'Active' and the email domain ends in either .com or .org using wildcard pattern matching (LIKE).*/
--------------------------------
USE [Data_Analytics_90Days]
GO

SELECT [Transaction_ID]
      ,[Customer_Name]
      ,[Customer_Email]
      ,[Order_Date]
      ,[Region]
      ,[Sales_Channel]
      ,[Product_Category]
      ,[Order_Amount]
      ,[Account_Status]
  FROM [dbo].[Fact_Transactions]
  WHERE Account_Status = 'Active' AND (Customer_Email LIKE '%.org' OR Customer_Email LIKE '%.com')
  ORDER BY Order_Amount DESC

  -----------------------------
  /*Task 2.2 (Multi-Region High-Value Filter): Query Transaction_ID, Customer_Name, Region, and Order_Amount for orders originating from North or West regions (IN) where the Order_Amount is greater than or equal to $1,000.00.*/
  -----------------------------

  SELECT 
  Transaction_ID, 
  Customer_Name, 
  Region,
  Order_Amount
  FROM [dbo].[Fact_Transactions]
  WHERE Region IN ('North','West')
  AND Order_Amount >= 1000.00

  ----------------------------
  /*Task 2.3 (Date Range & Digital Channel Extraction): Extract all orders placed between 2026-10-01 and 2026-10-03 (BETWEEN) that were executed specifically through digital sales channels (ONLINE_WEB or ONLINE_APP).*/
  ----------------------------
  SELECT * FROM [dbo].Fact_Transactions
  WHERE Order_Date BETWEEN '2026-10-01' AND '2026-10-03'
  AND Sales_Channel IN ('ONLINE_WEB', 'ONLINE_APP')
  ------------------------------------------------
 /* Block 3: Business Metrics & Transactional Audit (16:30 – 18:30)
Block 3 Challenge Tasks
Task 3.1 (High-Value Order Audit): Write a query to flag enterprise sales by selecting transactions with Order_Amount > 2000.00 or where Sales_Channel = 'RETAIL_STORE' and Product_Category = 'Electronics', excluding any Inactive accounts.*/
  ------------------------------------------------
  SELECT * FROM dbo.Fact_Transactions
  WHERE Account_Status <> 'Inactive'
  AND Order_Amount > 2000.00
  OR (Sales_Channel = 'RETAIL_STORE' AND Product_Category = 'Electronics')
  -------------------------------------------
  /*Task 3.2 (Pending Account Audit): Identify all transactions where Account_Status is NOT 'Active' and Order_Amount exceeds $400.00, sorting the result by Order_Date in ascending order.*/
  -------------------------------------------
  SELECT * FROM dbo.Fact_Transactions
  WHERE Account_Status <> 'Inactive'
  AND Order_Amount > 400.00
  ORDER BY Order_Date
  ------------------------------
/*Task 3.3 (Specific String Pattern Search): Retrieve transactions where the Customer_Name contains a hyphen (e.g., 'Sarah-Jane') or where Customer_Email contains an underscore (_), demonstrating proper T-SQL character escape handling if required.*/
--------------------------------

SELECT * FROM dbo.Fact_Transactions
WHERE 1=1
AND Customer_Name LIKE '%-%'
OR Customer_Email LIKE '%\_%' ESCAPE '\';



