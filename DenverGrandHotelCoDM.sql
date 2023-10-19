--Created for Data Warehousing course 
--02/20/2023
-- Create the Datamart DenverGrandHotelCoDM


IF NOT EXISTS(SELECT name FROM master.dbo.sysdatabases			
	WHERE name = N'DenverGrandHotelCoDM')
	CREATE DATABASE DenverGrandHotelCoDM
GO

USE DenverGrandHotelCoDM
GO
--
--Drop the tables if exist
IF EXISTS(
	SELECT *
	FROM sys.tables
	WHERE NAME = N'FactInvoice')

	DROP TABLE FactInvoice;
--
IF EXISTS(
	SELECT *
	FROM sys.tables
	WHERE NAME = N'DimEmployee')

	DROP TABLE DimEmployee;
--
IF EXISTS(
	SELECT *
	FROM sys.tables
	WHERE NAME = N'DimRoom')

	DROP TABLE DimRoom;
-- 
IF EXISTS(
	SELECT *
	FROM sys.tables
	WHERE NAME = N'DimCustomer')

	DROP TABLE DimCustomer;
-- 
IF EXISTS(
	SELECT *
	FROM sys.tables
	WHERE NAME = N'DimDate')

	DROP TABLE DimDate;

-- 
CREATE TABLE DimDate
	(
	Date_SK				INT PRIMARY KEY, 
	Date				DATE,
	FullDate			NCHAR(10),-- Date in MM-dd-yyyy format
	DayOfMonth			INT, -- Field will hold day number of Month
	DayName				NVARCHAR(9), -- Contains name of the day, Sunday, Monday 
	DayOfWeek			INT,-- First Day Sunday=1 and Saturday=7
	DayOfWeekInMonth	INT, -- 1st Monday or 2nd Monday in Month
	DayOfWeekInYear		INT,
	DayOfQuarter		INT,
	DayOfYear			INT,
	WeekOfMonth			INT,-- Week Number of Month 
	WeekOfQuarter		INT, -- Week Number of the Quarter
	WeekOfYear			INT,-- Week Number of the Year
	Month				INT, -- Number of the Month 1 to 12{}
	MonthName			NVARCHAR(9),-- January, February etc
	MonthOfQuarter		INT,-- Month Number belongs to Quarter
	Quarter				NCHAR(2),
	QuarterName			NVARCHAR(9),-- First,Second..
	Year				INT,-- Year value of Date stored in Row
	YearName			CHAR(7), -- CY 2017,CY 2018
	MonthYear			CHAR(10), -- Jan-2018,Feb-2018
	MMYYYY				INT,
	FirstDayOfMonth		DATE,
	LastDayOfMonth		DATE,
	FirstDayOfQuarter	DATE,
	LastDayOfQuarter	DATE,
	FirstDayOfYear		DATE,
	LastDayOfYear		DATE,
	IsHoliday			BIT,-- Flag 1=National Holiday, 0-No National Holiday
	IsWeekday			BIT,-- 0=Week End ,1=Week Day
	Holiday				NVARCHAR(50),--Name of Holiday in US
	Season				NVARCHAR(10)--Name of Season
	);
--
CREATE TABLE DimEmployee
	(
	EmployeeID_SK			INT IDENTITY (1,1) NOT NULL PRIMARY KEY,
	EmployeeID_AK			INT NOT NULL,
	EmployeeFirstName		VARCHAR(50) NOT NULL,		
	EmployeeLastName		VARCHAR(50) NOT NULL,
	EmployeeTitle			VARCHAR(50) NOT NULL,
	EmployeeDepartmentName	VARCHAR(100) NOT NULL,
	EmployeeCity			VARCHAR(50) NOT NULL,
	EmployeeState			VARCHAR(50) NOT NULL,
	);
--
CREATE TABLE DimRoom
	(
	RoomID_SK				INT IDENTITY (1,1) NOT NULL PRIMARY KEY,
	RoomID_AK				INT NOT NULL,
	RoomType				VARCHAR(100) NOT NULL,
	RoomAmenityType			VARCHAR(100) NOT NULL,
	RoomAmenitySupplierName	VARCHAR(100) NOT NULL,
	);
--


CREATE TABLE DimCustomer
	(
	CustomerID_SK			INT IDENTITY (1,1) NOT NULL PRIMARY KEY,
	CustomerID_AK			INT NOT NULL,
	CustomerDOB				DATE NOT NULL,		
	CustomerGender			NVARCHAR(10) NOT NULL,
	CustomerNationality		NVARCHAR(50) NOT NULL,
	CustomerType			NVARCHAR(50) NOT NULL,
	StartDate				DATETIME NOT NULL,
	EndDate					DATETIME NULL,
	);
--

CREATE TABLE FactInvoice
	(
	EmployeeID_SK		INT NOT NULL,
	RoomID_SK			INT NOT NULL,
	CustomerID_SK		INT NOT NULL,
	Date_SK				INT NOT NULL,
	InvoiceID_DD		INT NOT NULL,
	RoomPrice			INT NOT NULL,
	NightsStayed		INT NOT NULL,
	CONSTRAINT pk_FactInvoice					PRIMARY KEY (EmployeeID_SK,RoomID_SK,CustomerID_SK,Date_SK),
	CONSTRAINT fk_FactInvoice_DimDate			FOREIGN KEY (Date_SK) REFERENCES DimDate(Date_SK),
	CONSTRAINT fk_FactInvoice_DimEmployee		FOREIGN KEY (EmployeeID_SK) REFERENCES DimEmployee(EmployeeID_SK),
	CONSTRAINT fk_FactInvoice_DimRoom			FOREIGN KEY (RoomID_SK) REFERENCES DimRoom(RoomID_SK),
	CONSTRAINT fk_FactInvoice_DimCustomer		FOREIGN KEY (CustomerID_SK) REFERENCES DimCustomer(CustomerID_SK)
	);