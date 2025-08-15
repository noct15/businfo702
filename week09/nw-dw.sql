-- nw-dw.sql
-- Purpose: Export DW-ready CSVs from Northwind database, then build and load a new Northwind DW
-- Usage: sqlite3 nw.db < nw-dw.sql
-- Notes: 1) this script expects the operational database to have tables named exactly as in the nw.sql; 2) it writes CSVs into same folder / directory as the nw.db; 3) it uses .once and .import commands; 4) it creates a nw-dw.db in the same folder / directory to represent the data warehouse

-------------------------------------------------
-- EXPORT CSVs FROM OPERATIONAL NORTHWIND DB
-------------------------------------------------
.headers on
.mode csv

-- 1) Time dimension
.once Time.csv
SELECT DISTINCT
    CAST(STRFTIME('%Y%m%d', OrderDate) AS INTEGER) TimeID,
    CAST(STRFTIME('%Y', OrderDate) AS INTEGER) Year,
    'Q' || ((CAST(STRFTIME('%m', OrderDate) AS INTEGER) - 1) / 3 + 1) Quarter,
    CAST(STRFTIME('%m', OrderDate) AS INTEGER) Month,
    CASE STRFTIME('%w', OrderDate)
        WHEN '0' THEN 'Sunday'
        WHEN '1' THEN 'Monday'
        WHEN '2' THEN 'Tuesday'
        WHEN '3' THEN 'Wednesday'
        WHEN '4' THEN 'Thursday'
        WHEN '5' THEN 'Friday'
        WHEN '6' THEN 'Saturday'
    END DayOfWeek,
    CAST(STRFTIME('%d', OrderDate) AS INTEGER) Day
FROM [Order]
ORDER BY TimeID;

-- 2) Customer dimension
.once Customer.csv
SELECT DISTINCT CustomerID, CompanyName, Country, Region, City
FROM Customer
ORDER BY CustomerID;

-- 3) Product dimension
.once Product.csv
SELECT DISTINCT ProductID, ProductName, CategoryName, CompanyName SupplierName, UnitPrice
FROM Product p JOIN Category c ON p.CategoryID = c.CategoryID
JOIN Supplier s ON p.SupplierID  = s.SupplierID
ORDER BY ProductID;

-- 4) Employee dimension
.once Employee.csv
SELECT
    e.EmployeeID,
    e.FirstName || ' ' || e.LastName EmployeeName,
    CASE WHEN m.EmployeeID IS NOT NULL THEN m.FirstName || ' ' || m.LastName
         ELSE NULL
    END ManagerName,
    e.Country, e.Region, e.City
FROM Employee e LEFT JOIN Employee m ON e.ReportsTo = m.EmployeeID
ORDER BY e.EmployeeID;

-- 5) Shipper dimension
.once Shipper.csv
SELECT DISTINCT ShipperID, CompanyName
FROM Shipper
ORDER BY ShipperID;

-- 6) Sale fact
.once Sale.csv
SELECT CAST(STRFTIME('%Y%m%d', OrderDate) AS INTEGER) TimeID,
    CustomerID,
    ProductID,
    EmployeeID,
    ShipVia ShipperID,
    Quantity QuantitySold,
    UnitPrice UnitPriceAtSale,
    IFNULL(Discount, 0.0) Discount,
    UnitPrice * Quantity * (1.0 - IFNULL(Discount, 0.0)) DollarSold
FROM OrderDetail od JOIN [Order] o
ON o.OrderID = od.OrderID
ORDER BY TimeID, CustomerID, ProductID, EmployeeID, ShipperID;

-------------------------------------------------
-- CREATE A NEW DW DATABASE AND LOAD THE CSVs
-------------------------------------------------
-- Close current DB handle and open a brand-new DW file
.open nw-dw.db
PRAGMA journal_mode = WAL;
PRAGMA foreign_keys = ON;

-- Drop in case of re-run
DROP TABLE IF EXISTS Time;
DROP TABLE IF EXISTS Customer;
DROP TABLE IF EXISTS Product;
DROP TABLE IF EXISTS Employee;
DROP TABLE IF EXISTS Shipper;
DROP TABLE IF EXISTS Sale;

-- ===== Dimensions =====
CREATE TABLE Time (
    TimeID INTEGER PRIMARY KEY,
    Year INTEGER,
    Quarter TEXT,
    Month INTEGER,
    DayOfWeek TEXT,
    Day INTEGER
);

CREATE TABLE Customer (
    CustomerID TEXT PRIMARY KEY,
    CompanyName TEXT,
    Country TEXT,
    Region TEXT,
    City TEXT
);

CREATE TABLE Product (
    ProductID INTEGER PRIMARY KEY,
    ProductName TEXT,
    CategoryName TEXT,
    SupplierName TEXT,
    UnitPrice REAL
);

CREATE TABLE Employee (
    EmployeeID INTEGER PRIMARY KEY,
    EmployeeName TEXT,
    ManagerName TEXT,
    Country TEXT,
    Region TEXT,
    City TEXT
);

CREATE TABLE Shipper (
    ShipperID INTEGER PRIMARY KEY,
    CompanyName TEXT
);

-- ===== Fact =====
CREATE TABLE Sale (
    TimeID INTEGER,
    CustomerID TEXT,
    ProductID INTEGER,
    EmployeeID INTEGER,
    ShipperID INTEGER,
    QuantitySold INTEGER,
    UnitPriceAtSale REAL,
    Discount REAL,
    DollarSold REAL,
    PRIMARY KEY (TimeID, CustomerID, ProductID, EmployeeID, ShipperID),
    FOREIGN KEY (TimeID) REFERENCES Time (TimeID),
    FOREIGN KEY (CustomerID) REFERENCES Customer (CustomerID),
    FOREIGN KEY (ProductID) REFERENCES Product (ProductID),
    FOREIGN KEY (EmployeeID) REFERENCES Employee (EmployeeID),
    FOREIGN KEY (ShipperID) REFERENCES Shipper (ShipperID)
);

-- ===== Import CSVs =====
.mode csv
.headers on

.import --csv --skip 1 Time.csv Time
.import --csv --skip 1 Customer.csv Customer
.import --csv --skip 1 Product.csv Product
.import --csv --skip 1 Employee.csv Employee
.import --csv --skip 1 Shipper.csv Shipper
.import --csv --skip 1 Sale.csv Sale

-- Sanity check
.mode list
.headers off
SELECT 'Rows in Time = ' || COUNT(*) FROM Time;
SELECT 'Rows in Customer = ' || COUNT(*) FROM Customer;
SELECT 'Rows in Product  = ' || COUNT(*) FROM Product;
SELECT 'Rows in Employee = ' || COUNT(*) FROM Employee;
SELECT 'Rows in Shipper  = ' || COUNT(*) FROM Shipper;
SELECT 'Rows in Sale = ' || COUNT(*) FROM Sale;

-- Quick smoke test: Yearly sale
.headers on
SELECT Year, ROUND(SUM(s.DollarSold), 2) TotalSale
FROM Sale s JOIN Time t ON t.TimeID = s.TimeID
GROUP BY Year
ORDER BY Year;
