USE Data_Analytics_90Days;
GO

-- 1. Drop tables if they exist (handling FK dependencies)
IF OBJECT_ID('Fact_Orders', 'U') IS NOT NULL DROP TABLE Fact_Orders;
IF OBJECT_ID('Dim_Customers', 'U') IS NOT NULL DROP TABLE Dim_Customers;
IF OBJECT_ID('Dim_Products', 'U') IS NOT NULL DROP TABLE Dim_Products;
GO

-- 2. Create Customer Dimension
CREATE TABLE Dim_Customers (
    Customer_ID INT PRIMARY KEY,
    Customer_Name VARCHAR(100) NOT NULL,
    Customer_Segment VARCHAR(50) NOT NULL,
    Region VARCHAR(50) NOT NULL
);

-- 3. Create Product Dimension
CREATE TABLE Dim_Products (
    Product_ID INT PRIMARY KEY,
    Product_Name VARCHAR(100) NOT NULL,
    Category VARCHAR(50) NOT NULL,
    Unit_Cost DECIMAL(10, 2) NOT NULL
);

-- 4. Create Orders Fact Table
CREATE TABLE Fact_Orders (
    Order_ID INT PRIMARY KEY,
    Customer_ID INT FOREIGN KEY REFERENCES Dim_Customers(Customer_ID),
    Product_ID INT FOREIGN KEY REFERENCES Dim_Products(Product_ID),
    Order_Date DATE NOT NULL,
    Order_Quantity INT NOT NULL,
    Selling_Price DECIMAL(10, 2) NOT NULL,
    Sales_Channel VARCHAR(50) NOT NULL
);

-- 5. Seed Dimension & Fact Tables
INSERT INTO Dim_Customers (Customer_ID, Customer_Name, Customer_Segment, Region) VALUES
(101, 'Alpha Tech Solutions', 'Enterprise', 'North'),
(102, 'Beta Logistics', 'SMB', 'South'),
(103, 'Gamma Dynamics', 'Enterprise', 'East'),
(104, 'Delta Ventures', 'Retail', 'West'),
(105, 'Epsilon Retail', 'Retail', 'Central'); -- Customer with no orders

INSERT INTO Dim_Products (Product_ID, Product_Name, Category, Unit_Cost) VALUES
(501, 'Analytics Platform License', 'Software', 400.00),
(502, 'Cloud Storage Connector', 'Software', 150.00),
(503, 'Data Engineering Onboarding', 'Services', 200.00),
(504, 'Legacy Mainframe Plugin', 'Hardware', 800.00); -- Product with no orders

INSERT INTO Fact_Orders (Order_ID, Customer_ID, Product_ID, Order_Date, Order_Quantity, Selling_Price, Sales_Channel) VALUES
(8001, 101, 501, '2026-10-01', 2, 1200.00, 'ONLINE_WEB'),
(8002, 102, 502, '2026-10-02', 5, 300.00, 'RETAIL_STORE'),
(8003, 101, 503, '2026-10-03', 1, 800.00, 'ONLINE_APP'),
(8004, 103, 501, '2026-10-04', 1, 1250.00, 'ONLINE_WEB'),
(8005, 104, 502, '2026-10-05', 10, 280.00, 'RETAIL_STORE'),
(8006, 101, 502, '2026-10-06', 4, 290.00, 'ONLINE_WEB');
GO
