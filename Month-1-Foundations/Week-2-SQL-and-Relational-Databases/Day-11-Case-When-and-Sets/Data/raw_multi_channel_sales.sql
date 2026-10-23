USE Data_Analytics_90Days;
GO

-- 1. Clean up existing tables
IF OBJECT_ID('Fact_Web_Sales', 'U') IS NOT NULL DROP TABLE Fact_Web_Sales;
IF OBJECT_ID('Fact_Store_Sales', 'U') IS NOT NULL DROP TABLE Fact_Store_Sales;
GO

-- 2. Create Web Sales Table (contains NULLs and raw web orders)
CREATE TABLE Fact_Web_Sales (
    Order_ID INT PRIMARY KEY,
    Customer_Name VARCHAR(100) NOT NULL,
    Product_Category VARCHAR(50) NOT NULL,
    Order_Amount DECIMAL(10, 2),
    Discount_Amount DECIMAL(10, 2), -- May contain NULLs
    Order_Status VARCHAR(20) NOT NULL
);

-- 3. Create Store Sales Table (contains retail store orders)
CREATE TABLE Fact_Store_Sales (
    Order_ID INT PRIMARY KEY,
    Customer_Name VARCHAR(100) NOT NULL,
    Product_Category VARCHAR(50) NOT NULL,
    Order_Amount DECIMAL(10, 2),
    Discount_Amount DECIMAL(10, 2), -- May contain NULLs
    Order_Status VARCHAR(20) NOT NULL
);

-- 4. Seed Data into Web Sales
INSERT INTO Fact_Web_Sales (Order_ID, Customer_Name, Product_Category, Order_Amount, Discount_Amount, Order_Status) VALUES
(9001, 'Alpha Corp', 'Software', 1500.00, 150.00, 'Completed'),
(9002, 'Beta Systems', 'Hardware', 4500.00, NULL, 'Completed'), -- NULL Discount
(9003, 'Gamma LLC', 'Services', 800.00, 0.00, 'Pending'),
(9004, 'Delta Inc', 'Software', 3200.00, 320.00, 'Completed'),
(9005, 'Epsilon Retail', 'Hardware', NULL, NULL, 'Cancelled'); -- NULL Amount & Discount

-- 5. Seed Data into Store Sales (Some overlap with Web Sales for set testing)
INSERT INTO Fact_Store_Sales (Order_ID, Customer_Name, Product_Category, Order_Amount, Discount_Amount, Order_Status) VALUES
(9001, 'Alpha Corp', 'Software', 1500.00, 150.00, 'Completed'), -- Duplicate record
(9006, 'Zeta Global', 'Hardware', 2100.00, 100.00, 'Completed'),
(9007, 'Eta Enterprise', 'Services', 1200.00, NULL, 'Completed'), -- NULL Discount
(9008, 'Theta Partners', 'Software', 5000.00, 500.00, 'Completed');
GO
