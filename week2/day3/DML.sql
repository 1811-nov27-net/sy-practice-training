-- DML
-- Database Maniplulation Language
-- the subset of SQL which accesses and modifies individual rows.
-- SELECT, INSERT, UPDATE, DELETE, and TRUNCATE TABLE

-- SELECT is by far the more complicated

SELECT * FROM SalesLT.Address;

-- INSERT
-- simple insert with all columns.
INSERT INTO SalesLT.Address VALUES
('123 Main Street', NULL, 'Dallas', 'Texas', 'United States', '12345', '268AF621-76D7-4C78-9441-144FD139827A', GETUTCDATE());

-- better insert, more readable, be explicit about column names.
-- allows relying on defaults for nullable columns, for rowguids, etc.
INSERT INTO SalesLT.Address(AddressLine1, City, StateProvince, CountryRegion, PostalCode)
VALUES
('123 Main Street', 'Dallas', 'Texas', 'United States', '12345'),
(REPLACE('123 Main Street', '123', '456'), 'Dallas', 'Texas', 'United States', '12345');

-- there are ways to do bulk inserts from things like CSV files
-- BULK INSERT SalesLT.Address FROM 'data.csv' WITH (FIELDTERMINATOR = ',', ROWTERMINATOR = '\n')

INSERT INTO SalesLT.Address(AddressLine1, City, StateProvince, CountryRegion, PostalCode)
	SELECT AddressLine1, City, StateProvince, CountryRegion, REVERSE(PostalCode)
	FROM SalesLT.Address
	WHERE ModifiedDate > '2018'; -- YEAR(ModifiedDate) >= 2018

-- we have temporary table variables we can use
SELECT AddressLine1, City, StateProvince, CountryRegion, PostalCode
INTO any_table
FROM SalesLT.Address
WHERE ModifiedDate > '2018';

INSERT INTO SalesLT.Address(AddressLine1, City, StateProvince, CountryRegion, PostalCode)
	SELECT * FROM any_table;

-- UPDATE
SELECT * FROM SalesLT.Address WHERE YEAR(ModifiedDate) >= '2018';

-- for every recently modified row, update the address line 2 and set the postal code
-- equal to the most recently modified row's postal code
UPDATE SalesLT.Address
SET AddressLine2 = 'Apt 45', 
	PostalCode = 
	(
		SELECT TOP(1) PostalCode FROM SalesLT.Address ORDER BY ModifiedDate DESC
	)
WHERE YEAR(ModifiedDate) >= '2018';

-- DELETE

-- delete every row in the table (slow way, one by one)
-- DELETE FROM SalesLT.Address;

DELETE FROM SalesLT.Address
WHERE ModifiedDate > '2018';

-- TRUNCATE TABLE deletes every row in the table all at once, fast way
-- (table itself still exists, but empty)
-- TRUNCATE TABLE SalesLT.Address;
