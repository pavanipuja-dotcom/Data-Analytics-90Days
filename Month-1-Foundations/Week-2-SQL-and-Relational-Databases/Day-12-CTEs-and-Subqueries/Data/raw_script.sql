USE Data_Analytics_90Days;
GO

-- 1. Clean up existing tables
IF OBJECT_ID('Fact_Account_Revenue', 'U') IS NOT NULL DROP TABLE Fact_Account_Revenue;
IF OBJECT_ID('Dim_Enterprise_Accounts', 'U') IS NOT NULL DROP TABLE Dim_Enterprise_Accounts;
GO

-- 2. Create Accounts Dimension
CREATE TABLE Dim_Enterprise_Accounts (
    Account_ID INT PRIMARY KEY,
    Account_Name VARCHAR(100) NOT NULL,
    Industry VARCHAR(50) NOT NULL,
    Region VARCHAR(50) NOT NULL,
    Contract_Tier VARCHAR(20) NOT NULL
);

-- 3. Create Revenue Fact Table
CREATE TABLE Fact_Account_Revenue (
    Transaction_ID INT PRIMARY KEY,
    Account_ID INT FOREIGN KEY REFERENCES Dim_Enterprise_Accounts(Account_ID),
    Order_Date DATE NOT NULL,
    Product_Category VARCHAR(50) NOT NULL,
    Revenue_Amount DECIMAL(10, 2) NOT NULL,
    Cost_Amount DECIMAL(10, 2) NOT NULL
);

-- 4. Seed Data into Accounts Dimension
INSERT INTO Dim_Enterprise_Accounts (Account_ID, Account_Name, Industry, Region, Contract_Tier) VALUES
(1001, 'Acme Financial Services', 'Banking', 'North', 'Tier 1'),
(1002, 'Apex Healthcare System', 'Healthcare', 'South', 'Tier 2'),
(1003, 'Global Logistics Corp', 'Logistics', 'East', 'Tier 1'),
(1004, 'Titanium Manufacturing', 'Manufacturing', 'West', 'Tier 3'),
(1005, 'Vanguard Tech Solutions', 'Technology', 'North', 'Tier 2'),
(1006, 'Horizon Media Group', 'Media', 'Central', 'Tier 3'); -- Account with low activity

-- 5. Seed Data into Revenue Fact Table
INSERT INTO Fact_Account_Revenue (Transaction_ID, Account_ID, Order_Date, Product_Category, Revenue_Amount, Cost_Amount) VALUES
(5001, 1001, '2026-10-01', 'Cloud Software', 12500.00, 3000.00),
(5002, 1002, '2026-10-02', 'Professional Services', 4200.00, 1800.00),
(5003, 1001, '2026-10-03', 'Hardware Plugins', 8500.00, 4500.00),
(5004, 1003, '2026-10-04', 'Cloud Software', 22000.00, 5000.00),
(5005, 1004, '2026-10-05', 'Hardware Plugins', 3100.00, 2000.00),
(5006, 1005, '2026-10-06', 'Cloud Software', 18500.00, 4000.00),
(5007, 1002, '2026-10-07', 'Cloud Software', 9500.00, 2200.00),
(5008, 1003, '2026-10-08', 'Professional Services', 6000.00, 3000.00),
(5009, 1001, '2026-10-09', 'Professional Services', 5000.00, 2000.00),
(5010, 1006, '2026-10-10', 'Hardware Plugins', 1200.00, 800.00);
GO
