CREATE DATABASE TechWorldHRDB;
GO

USE TechWorldHRDB;
GO

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FullName NVARCHAR(100) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE,
    Salary DECIMAL(10, 2) NOT NULL,
    BirthDate DATE,
    HireDate DATETIME,
    IsActive BIT
);

ALTER TABLE Employees
ADD PhoneNumber VARCHAR(20);

INSERT INTO Employees
    (EmployeeID, FullName, Email, Salary, BirthDate, HireDate, IsActive, PhoneNumber)
VALUES
    (1, 'Ahmad Ali', 'ahmad@example.com', 1500.00, '19950515', '20240110', 1, '0791111111'),
    (2, 'Sara Hassan', 'sara@example.com', 900.00, '19980820', '20240301', 1, '0792222222'),
    (3, 'Zaid Omar', 'zaid@example.com', 1200.00, '19970312', '20240615', 1, '0793333333');

SELECT * FROM Employees;

SELECT FullName, Salary
FROM Employees;

SELECT *
FROM Employees
WHERE Salary > 1000.00;

UPDATE Employees
SET Salary = 1000.00
WHERE EmployeeID = 2;

SELECT * FROM Employees;

SELECT COUNT(*) AS EmployeeCount
FROM Employees;

SELECT SUM(Salary) AS TotalSalary
FROM Employees;

SELECT AVG(Salary) AS AverageSalary
FROM Employees;

SELECT MIN(Salary) AS LowestSalary
FROM Employees;

SELECT MAX(Salary) AS HighestSalary
FROM Employees;

DELETE FROM Employees
WHERE EmployeeID = 3;

SELECT * FROM Employees;

CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName NVARCHAR(100) NOT NULL UNIQUE
);

ALTER TABLE Departments
ADD Location NVARCHAR(100);

INSERT INTO Departments (DepartmentID, DepartmentName, Location)
VALUES (1, 'IT', 'Amman'),
       (2, 'HR', 'Irbid');

SELECT * FROM Departments;

TRUNCATE TABLE Departments;

SELECT * FROM Departments;

DROP TABLE Departments;
GO

CREATE DATABASE BasicPracticeDB;
GO

USE master;
GO

DROP DATABASE BasicPracticeDB;
GO

USE TechWorldHRDB;
GO
