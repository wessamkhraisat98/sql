USE TechWorldHRDB;
GO

CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(50) NOT NULL UNIQUE
);

INSERT INTO Departments VALUES
(1, 'IT'),
(2, 'HR'),
(3, 'Finance');

ALTER TABLE Employees ADD DepartmentID INT;

UPDATE Employees SET DepartmentID = 1 WHERE EmployeeID = 1;
UPDATE Employees SET DepartmentID = 2 WHERE EmployeeID = 2;

INSERT INTO Employees (EmployeeID, FullName, Email, Salary, BirthDate, HireDate, IsActive, PhoneNumber, DepartmentID)
VALUES (3, 'Zaid Omar', 'zaid@example.com', 1500, '19970312', '20240615', 1, '0793333333', 1);

CREATE TABLE AccessCards (
    CardID INT PRIMARY KEY,
    CardNumber VARCHAR(50) NOT NULL UNIQUE,
    EmployeeID INT UNIQUE FOREIGN KEY REFERENCES Employees(EmployeeID)
);

CREATE TABLE Projects (
    ProjectID INT PRIMARY KEY,
    ProjectName VARCHAR(100) NOT NULL
);

CREATE TABLE EmployeeProjects (
    EmployeeID INT FOREIGN KEY REFERENCES Employees(EmployeeID),
    ProjectID INT FOREIGN KEY REFERENCES Projects(ProjectID),
    AssignedDate DATE,
    PRIMARY KEY (EmployeeID, ProjectID)
);

INSERT INTO AccessCards VALUES
(101, 'CARD101', 1),
(102, 'CARD102', 2),
(103, 'CARD103', 3);

INSERT INTO Projects VALUES
(1, 'AI & Security Training'),
(2, 'Cloud Migration');

INSERT INTO EmployeeProjects VALUES
(1, 1, '20261001'),
(1, 2, '20261001'),
(2, 1, '20261001'),
(3, 2, '20261001');

SELECT e.FullName, e.Salary, d.DepartmentName
FROM Employees e INNER JOIN Departments d ON e.DepartmentID = d.DepartmentID;

SELECT d.DepartmentName, e.FullName
FROM Departments d LEFT JOIN Employees e ON d.DepartmentID = e.DepartmentID;

SELECT e.FullName, a.CardNumber
FROM Employees e INNER JOIN AccessCards a ON e.EmployeeID = a.EmployeeID;

SELECT e.FullName, p.ProjectName, ep.AssignedDate
FROM Employees e
INNER JOIN EmployeeProjects ep ON e.EmployeeID = ep.EmployeeID
INNER JOIN Projects p ON ep.ProjectID = p.ProjectID;

SELECT DepartmentID, SUM(Salary) AS TotalSalary, COUNT(*) AS EmployeeCount
FROM Employees GROUP BY DepartmentID;

SELECT DepartmentID, AVG(Salary) AS AvgSalary
FROM Employees GROUP BY DepartmentID HAVING AVG(Salary) > 1000;

SELECT * FROM Employees
WHERE Salary > (SELECT AVG(Salary) FROM Employees);
GO

CREATE VIEW vw_EmployeeDetails AS
SELECT e.EmployeeID, e.FullName, e.Email, d.DepartmentName
FROM Employees e INNER JOIN Departments d ON e.DepartmentID = d.DepartmentID;
GO

CREATE PROCEDURE sp_GetEmployeesByDepartment @DeptID INT
AS
SELECT * FROM Employees WHERE DepartmentID = @DeptID;
GO

CREATE TABLE EmployeeAudit (
    AuditID INT IDENTITY(1,1) PRIMARY KEY,
    EmployeeID INT,
    Action VARCHAR(50),
    ActionDate DATETIME
);
GO

CREATE TRIGGER trg_EmployeeDelete ON Employees
AFTER DELETE
AS
INSERT INTO EmployeeAudit (EmployeeID, Action, ActionDate)
SELECT EmployeeID, 'DELETE', GETDATE() FROM deleted;
GO
