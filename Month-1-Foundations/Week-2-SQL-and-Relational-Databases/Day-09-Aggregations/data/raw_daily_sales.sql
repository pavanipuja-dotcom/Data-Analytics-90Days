USE Data_Analytics_90Days;
GO

IF OBJECT_ID('Fact_Daily_Sales', 'U') IS NOT NULL 
    DROP TABLE Fact_Daily_Sales;
GO

CREATE TABLE Fact_Daily_Sales (
    Sales_ID INT IDENTITY(1,1) PRIMARY KEY,
    Store_Region VARCHAR(50) NOT NULL,
    Sales_Channel VARCHAR(50) NOT NULL,
    Product_Category VARCHAR(50) NOT NULL,
    Customer_Segment VARCHAR(50) NOT NULL,
    Order_Quantity INT NOT NULL,
    Unit_Price DECIMAL(10, 2) NOT NULL,
    Discount_Amount DECIMAL(10, 2) DEFAULT 0.00,
    Order_Status VARCHAR(20) NOT NULL
);

INSERT INTO Fact_Daily_Sales 
(Store_Region, Sales_Channel, Product_Category, Customer_Segment, Order_Quantity, Unit_Price, Discount_Amount, Order_Status)
VALUES
('North', 'ONLINE_WEB', 'Electronics', 'Enterprise', 5, 1200.00, 100.00, 'Completed'),
('North', 'ONLINE_WEB', 'Apparel', 'Retail', 12, 45.00, 0.00, 'Completed'),
('North', 'RETAIL_STORE', 'Electronics', 'Enterprise', 2, 1100.00, 50.00, 'Completed'),
('South', 'RETAIL_STORE', 'Furniture', 'SMB', 3, 350.00, 25.00, 'Completed'),
('South', 'ONLINE_APP', 'Electronics', 'Enterprise', 8, 950.00, 150.00, 'Completed'),
('South', 'ONLINE_APP', 'Apparel', 'Retail', 15, 30.00, 0.00, 'Pending'),
('East', 'ONLINE_WEB', 'Furniture', 'Enterprise', 4, 600.00, 80.00, 'Completed'),
('East', 'RETAIL_STORE', 'Apparel', 'SMB', 20, 25.00, 10.00, 'Completed'),
('East', 'ONLINE_APP', 'Electronics', 'SMB', 1, 1400.00, 0.00, 'Cancelled'),
('West', 'RETAIL_STORE', 'Electronics', 'Enterprise', 10, 1250.00, 200.00, 'Completed'),
('West', 'ONLINE_WEB', 'Furniture', 'Retail', 2, 800.00, 50.00, 'Completed'),
('West', 'ONLINE_WEB', 'Electronics', 'Enterprise', 3, 1300.00, 0.00, 'Completed');
GO
