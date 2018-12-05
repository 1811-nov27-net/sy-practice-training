CREATE SCHEMA di;
GO
CREATE TABLE di.Department (
	Id int IDENTITY(10,10) NOT NULL PRIMARY KEY,
	Name NVARCHAR(100) NOT NULL,
	Location NVARCHAR(100) NOT NULL
);
GO
CREATE TABLE di.Employee (
	Id int IDENTITY(1,1) NOT NULL PRIMARY KEY,
	FirstName NVARCHAR(50) NOT NULL,
	LastName NVARCHAR(50) NOT NULL,
	Ssn NVARCHAR(11) NOT NULL, -- formatted as "xxx-xx-xxxx", so 11 characters
	DeptID int NOT NULL FOREIGN KEY REFERENCES di.Department(Id)
);
GO
CREATE TABLE di.EmpDetails (
	EmployeeId int NOT NULL PRIMARY KEY FOREIGN KEY REFERENCES di.Employee(Id),
	Salary MONEY NOT NULL,
	Address1 NVARCHAR(100) NOT NULL,
	Address2 NVARCHAR(100) NOT NULL,
	City NVARCHAR(100) NOT NULL,
	State NVARCHAR(100) NOT NULL,
	Country NVARCHAR(100) NOT NULL
);
GO
-- inserting data into Department
INSERT INTO di.Department (Name, Location) VALUES
	('HR', '2nd Floor');
INSERT INTO di.Department (Name, Location) VALUES
	('IT', '3rd Floor');
INSERT INTO di.Department (Name, Location) VALUES
	('Sales', '4th Floor');
SELECT * FROM di.Department;
-- inserting data into Employee
INSERT INTO di.Employee (FirstName, LastName, Ssn, DeptID) VALUES
	('John', 'Smith', '000-00-0000', 20);
INSERT INTO di.Employee (FirstName, LastName, Ssn, DeptID) VALUES
	('Jane', 'Doe', '111-11-1111', 10);
INSERT INTO di.Employee (FirstName, LastName, Ssn, DeptID) VALUES
	('Bob', 'Doet', '222-22-2222', 30);
SELECT * FROM di.Employee;
SELECT * FROM di.Department;
-- inserting data into EmpDetails
INSERT INTO di.EmpDetails (EmployeeId, Salary, Address1, Address2, City, State, Country) VALUES
	(1, 80000, '123 Main Street', '', 'Stockton', 'California', 'United States');
INSERT INTO di.EmpDetails (EmployeeId, Salary, Address1, Address2, City, State, Country) VALUES
	(2, 75000, '802 Lemmings Avenue', 'Suite 503', 'Topeka', 'Kansas', 'United States');
INSERT INTO di.EmpDetails (EmployeeId, Salary, Address1, Address2, City, State, Country) VALUES
	(3, 95000, '666 Why Court', '', 'MiddleOfNowhere', 'Oklahoma', 'United States');
SELECT * FROM di.EmpDetails;
-- add Marketing department
INSERT INTO di.Department (Name, Location) VALUES
	('Marketing', 'Main Office');
SELECT * FROM di.Department;
-- add Tina Smith Employee (marketing), adding base wage
INSERT INTO di.Employee (FirstName, LastName, Ssn, DeptID) VALUES
	('Tina', 'Smith', '123-45-6789', 40);
INSERT INTO di.EmpDetails (EmployeeId, Salary, Address1, Address2, City, State, Country) VALUES
	(4, 60000, '1562 Test Boulevard', '', 'Tampa', 'Florida', 'United States');
SELECT * FROM di.Employee;
SELECT * FROM di.EmpDetails;
-- list all employeees in marketing
SELECT *
FROM di.Employee AS e
	INNER JOIN di.Department AS d ON d.Id = e.DeptID
WHERE d.Name = 'Marketing';
-- report total salary of marketing
SELECT SUM(ed.Salary) AS [Total Salary]
FROM di.Employee AS e
	INNER JOIN di.Department AS d ON d.Id = e.DeptID
	INNER JOIN di.EmpDetails AS ed ON ed.EmployeeId = e.Id
WHERE d.Name = 'Marketing';
-- report total employees by department
SELECT d.Name, COUNT(e.Id) AS [# Employees]
FROM di.Employee AS e
	INNER JOIN di.Department AS d ON d.Id = e.DeptID
GROUP BY d.Name;
-- increase salary of Tina Smith to $90,000
UPDATE di.EmpDetails
	SET Salary = 90000
WHERE EmployeeId = 4;
SELECT * FROM di.EmpDetails;