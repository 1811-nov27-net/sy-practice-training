-- Show the first name and the email address of customer with CompanyName 'Bike World'
SELECT DISTINCT c.FirstName, c.EmailAddress, c.CompanyName
FROM SalesLT.Customer AS c
WHERE c.CompanyName = 'Bike World';

-- Show the CompanyName for all customers with an address in City 'Dallas'.
SELECT DISTINCT c.CompanyName
FROM SalesLT.Customer AS c
	INNER JOIN SalesLT.CustomerAddress AS ca ON ca.CustomerID = c.CustomerID
	INNER JOIN SalesLT.Address AS a ON a.AddressID = ca.AddressID
WHERE a.City = 'Dallas';

-- How many items with ListPrice more than $1000 have been sold?
-- SELECT COUNT(sod.OrderQty) AS [Quantity Sold] only gives the number of different products sold
-- SUM adds up the data in the column OrderQty
SELECT SUM(sod.OrderQty) AS [Quantity Sold]
FROM SalesLT.SalesOrderDetail AS sod
	INNER JOIN SalesLT.Product AS p ON p.ProductID = sod.ProductID
WHERE p.ListPrice > 1000;

-- Give the CompanyName of those customers with orders over $100000. Include the subtotal plus tax plus freight.
SELECT c.CompanyName, soh.TotalDue
FROM SalesLT.Customer AS c
	INNER JOIN SalesLT.SalesOrderHeader AS soh ON soh.CustomerID = c.CustomerID
WHERE soh.TotalDue > 100000;

-- Find the number of left racing socks ('Racing Socks, L') ordered by CompanyName 'Riding Cycles'.
SELECT p.Name, sod.OrderQty, c.CompanyName
FROM SalesLT.SalesOrderDetail AS sod
	INNER JOIN SalesLT.Product AS p ON p.ProductID = sod.ProductID
	INNER JOIN SalesLT.SalesOrderHeader AS soh ON soh.SalesOrderID = sod.SalesOrderID
	INNER JOIN SalesLT.Customer AS c ON c.CustomerID = soh.CustomerID
WHERE p.Name = 'Racing Socks, L' AND c.CompanyName = 'Riding Cycles';

-- Show the SalesOrderID and the UnitPrice for every customer order where only one item is ordered.
-- shows orders that have multiple single item orders in the same order
SELECT DISTINCT sod.SalesOrderID, sod.UnitPrice
FROM SalesLT.SalesOrderDetail AS sod
	INNER JOIN SalesLT.SalesOrderHeader AS soh ON soh.SalesOrderID = sod.SalesOrderID
WHERE sod.OrderQty = 1;

-- List the product name and the CompanyName for all Customers who ordered ProductModel 'Racing Socks'.
-- There is no ProductModel 'Racing Socks'
SELECT p.Name, c.CompanyName
FROM SalesLT.Customer AS c
	INNER JOIN SalesLT.SalesOrderHeader AS soh ON soh.CustomerID = c.CustomerID
	INNER JOIN SalesLT.SalesOrderDetail AS sod ON sod.SalesOrderID = soh.SalesOrderID
	INNER JOIN SalesLT.Product AS p ON p.ProductID = sod.ProductID
	INNER JOIN SalesLT.ProductCategory AS pc ON pc.ProductCategoryID = p.ProductCategoryID
WHERE pc.Name = 'Racing Socks';

-- Results from this show that there are only "Racing Socks" in "Socks"
SELECT p.Name, c.CompanyName
FROM SalesLT.Customer AS c
	INNER JOIN SalesLT.SalesOrderHeader AS soh ON soh.CustomerID = c.CustomerID
	INNER JOIN SalesLT.SalesOrderDetail AS sod ON sod.SalesOrderID = soh.SalesOrderID
	INNER JOIN SalesLT.Product AS p ON p.ProductID = sod.ProductID
	INNER JOIN SalesLT.ProductCategory AS pc ON pc.ProductCategoryID = p.ProductCategoryID
WHERE pc.Name = 'Socks';

-- Show the product description for culture 'fr' for product with ProductID 736.
SELECT pd.Description
FROM SalesLT.Product AS p
	INNER JOIN SalesLT.ProductModel AS pm ON pm.ProductModelID = p.ProductModelID
	INNER JOIN SalesLT.ProductModelProductDescription AS pmpd ON pmpd.ProductModelID = pm.ProductModelID
	INNER JOIN SalesLT.ProductDescription AS pd ON pd.ProductDescriptionID = pmpd.ProductDescriptionID
WHERE pmpd.Culture = 'fr' AND p.ProductID = 736;

-- Use the SubTotal value in SalesOrderHeader to list orders from the largest to the smallest.
-- For each order show the CompanyName and the SubTotal and the total weight of the order.
SELECT c.CompanyName, soh.SubTotal, (sod.OrderQty * p.Weight) AS [Total Weight]
FROM SalesLT.Customer AS c
	INNER JOIN SalesLT.SalesOrderHeader AS soh ON soh.CustomerID = c.CustomerID
	INNER JOIN SalesLT.SalesOrderDetail AS sod ON sod.SalesOrderID = soh.SalesOrderID
	INNER JOIN SalesLT.Product AS p ON p.ProductID = sod.ProductID
ORDER BY soh.SubTotal DESC;

-- How many products in ProductCategory 'Cranksets' have been sold to an address in 'London'?
SELECT SUM(sod.OrderQty) AS [Total Sold]
FROM SalesLT.Customer AS c
	INNER JOIN SalesLT.SalesOrderHeader AS soh ON soh.CustomerID = c.CustomerID
	INNER JOIN SalesLT.Address AS a ON a.AddressID = soh.ShipToAddressID
	INNER JOIN SalesLT.SalesOrderDetail AS sod ON sod.SalesOrderID = soh.SalesOrderID
	INNER JOIN SalesLT.Product AS p ON p.ProductID = sod.ProductID
	INNER JOIN SalesLT.ProductCategory AS pc ON pc.ProductCategoryID = p.ProductCategoryID
WHERE pc.Name = 'Cranksets' AND a.City = 'London';

-- For every customer with a 'Main Office' in 'Dallas' show AddressLine1 of the 'Main Office' and AddressLine1 of the 'Shipping' address
-- if there is no shipping address leave it - blank. Use one row per customer.
SELECT c.CustomerID, soh.ShipToAddressID, a.AddressLine1
FROM SalesLT.Customer AS c
	INNER JOIN SalesLT.CustomerAddress AS ca ON ca.CustomerID = c.CustomerID
	INNER JOIN SalesLT.SalesOrderHeader AS soh ON soh.CustomerID = c.CustomerID
	FULL OUTER JOIN SalesLT.Address AS a ON a.AddressID = soh.ShipToAddressID
WHERE ca.AddressType = 'Main Office' AND a.City = 'Dallas';

-- Show the best selling item by value.

-- Show the total order value for each CountryRegion. List by value with the highest first.

-- Find the best customer in each region.