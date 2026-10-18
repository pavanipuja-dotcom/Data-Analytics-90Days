CREATE DATABASE Data_Analytics_90Days;
GO

USE Data_Analytics_90Days;
GO

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
