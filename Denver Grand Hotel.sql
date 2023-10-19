DROP DATABASE DenverGrandHotel

-- Run this code to create the database the model will be stored under
CREATE DATABASE DenverGrandHotel;
-- Run this code to access the database
USE DenverGrandHotel
GO

-- Use this code to create the table for the Room information
-- It includes the variables RoomID and RoomType
-- The check prevents the RoomID from being negative
CREATE TABLE Room
(
RoomID INT NOT NULL CONSTRAINT PK_Room_ID PRIMARY KEY (RoomID),
RoomType VARCHAR(100) NOT NULL,
CHECK (RoomID > 0)
)

-- Use this code to create the table for the Customer information
-- It includes the varaibles CustomerId, First and Last Name of customer, their email, and their phone number
-- The check prevents the customerID and phone number from being negative
CREATE TABLE	 Customer
(
CustomerID INT NOT NULL CONSTRAINT PK_Customer_ID PRIMARY KEY (CustomerID),
FirstName NVARCHAR(100) NOT NULL,
LastName NVARCHAR(100) NOT NULL,
Email NVARCHAR(100) NOT NULL,
PhoneNumber VARCHAR(12) NOT NULL,
CHECK (CustomerID > 0),
)

-- Use this code to create the table for the Invoice Information
-- It includes the variables InvoiceID, date of booking, check-in date, check-out date, and customerID
-- The check prevents the InvoiceID from being negative
CREATE TABLE Invoice
(
InvoiceID INT NOT NULL CONSTRAINT PK_Invoice_ID PRIMARY KEY (InvoiceID),
DateOfBooking DATETIME NOT NULL,
CheckInDate DATETIME NOT NULL,
CheckOutDate DATETIME NOT NULL,
CustomerID INT NOT NULL FOREIGN KEY REFERENCES Customer (CustomerID),
CHECK (InvoiceID > 0)
)

-- Use this code to create the tabel for associative table Room_invoice
-- It uses the variables RoomID and InvoiceID
CREATE TABLE Room_Invoice
(
RoomID INT NOT NULL FOREIGN KEY REFERENCES Room (RoomID),
InvoiceID INT NOT NULL FOREIGN KEY REFERENCES Invoice (InvoiceID),
CONSTRAINT PK_RoomID_InvoiceID PRIMARY KEY (RoomID, InvoiceID)
)

-- Run this code to create the Branch Table
-- It includes the branchID, street address, city, state, and zip code of the branch
-- The check prevents the BranchID and ZipCode from being negative
CREATE TABLE Branch
(
BranchID INT NOT NULL CONSTRAINT PK_Branch_ID PRIMARY KEY (BranchID),
StreetAddress VARCHAR(100) NOT NULL,
City VARCHAR(50) NOT NULL,
State VARCHAR(50) NOT NULL,
ZipCode INT NOT NULL,
CHECK (BranchID > 0),
CHECK (ZipCode > 0)
)

-- Use this code to create the Department Table
-- It includes the DepartmentID, the BranchID, and the department name
-- The check prevents the DepartmentID from being negative
CREATE TABLE Department
(
DepartmentID INT NOT NULL CONSTRAINT PK_Department_ID PRIMARY KEY (DepartmentID),
DepartmentName VARCHAR(100) NOT NULL,
BranchID INT NOT NULL FOREIGN KEY REFERENCES Branch (BranchID),
CHECK (DepartmentID > 0)
)


-- Run this code to create the employee table
-- It includes the variables EmployeeID, First and Last name of employee, the title, and the departmentID they belong too
-- The check prevents the EmployeeID from being negative
CREATE TABLE Employee
(
EmployeeID INT NOT NULL CONSTRAINT PK_Employee_ID PRIMARY KEY (EmployeeID),
FirstName VARCHAR(50) NOT NULL,
LastName VARCHAR(50) NOT NULL,
EmployeeTitle VARCHAR(50) NOT NULL,
DepartmentID INT NOT NULL FOREIGN KEY REFERENCES Department (DepartmentID),
CHECK (EmployeeID > 0)
)

-- Run this code to create the associative table Employee_Room
-- It includes the varaibles EmployeeID and RoomID
CREATE TABLE Employee_Room
(
EmployeeID INT NOT NULL FOREIGN KEY REFERENCES Employee (EmployeeID),
RoomID INT NOT NULL FOREIGN KEY REFERENCES Room (RoomID),
CONSTRAINT PK_EmployeeID_RoomID PRIMARY KEY (EmployeeID, RoomID)
)

-- Use this code to create the supplier information table
-- It includes the variables of supplierid and supplier name
-- The check prevents the SupplierID from being negative
CREATE TABLE Supplier
(
SupplierID INT NOT NULL CONSTRAINT PK_Supplier_ID PRIMARY KEY (SupplierID),
SupplierName VARCHAR(100) NOT NULL,
CHECK (SupplierID > 0)
)

-- Use this table to create the Amenity Table
-- It includes the amenityid, amenity type, and the supplierid of the amenity
-- The check prevents the AmenityID from being negative
CREATE TABLE Amenity
(
AmenityID INT NOT NULL CONSTRAINT PK_Amenity_ID PRIMARY KEY (AmenityID),
AmenityType VARCHAR(100) NOT NULL,
SupplierID INT NOT NULL FOREIGN KEY REFERENCES Supplier (SupplierID),
CHECK (AmenityID > 0)
)

-- Use this code to create the associative table
-- It uses the RoomID and AmenityID
CREATE TABLE Amenity_Room
(
RoomID INT NOT NULL FOREIGN KEY REFERENCES Room (RoomID),
AmenityID INT NOT NULL FOREIGN KEY REFERENCES Amenity (AmenityID)
CONSTRAINT PK_RoomID_AmenityID PRIMARY KEY (RoomID, AmenityID)
)

-- Run this code to create the Repair Area Table
-- It includes the RepairID, and start and end date of the repair
-- The check prevents the RepairID from being negative
CREATE TABLE RepairArea
(
RepairID INT NOT NULL CONSTRAINT PK_Repair_ID PRIMARY KEY (RepairID),
StartDate DATETIME NOT NULL,
EndDate DATETIME NULL,
CHECK (RepairID > 0)
)

-- Run this code to create the associative table RepairArea_Employee
-- It contains the repairID and employeeID
CREATE TABLE RepairArea_Employee
(
RepairID INT NOT NULL FOREIGN KEY REFERENCES RepairArea (RepairID), 
EmployeeID INT NOT NULL FOREIGN KEY REFERENCES Employee (EmployeeID),
CONSTRAINT PK_RepairID_EmployeeID PRIMARY KEY (RepairID, EmployeeID)
)

--Use this code to insert data into Room Table
INSERT INTO DenverGrandHotel.dbo.Room (RoomID,Roomtype)
VALUES (101, 'King'), 
(105, 'Double Queen'),
(107,'Suite'),
(115, 'Double Queen'),
(222, 'King'),
(209, 'Double Queen'),
(211, 'Suite'),
(315, 'Suite'),
(310, 'Double Queen'),
(333, 'King'),
(340, 'Double Queen'),
(401, 'King'),
(405, 'Suite'), 
(407, 'Double Queen'),
(444, 'King'),
(501, 'Suite'),
(517, 'Suite'),
(520, 'Suite'),
(525, 'VP Suite'),
(555, 'Presidential Suite');

-- Insert Data in Customer
-- This code allows us to put the customer information in
INSERT INTO DenverGrandHotel.dbo.Customer (CustomerID,FirstName, LastName, Email, PhoneNumber)
VALUES (1,'John', 'Doe', 'jdoe@zmail.com','5176253585'),
(2,'Jacob', 'Lambin', 'taforinfo@coolmail.edu','6651234578'),
(3,'Valerie', 'Bartlet', 'vbartlet@inlook.com', '5554444333'),
(4,'Catherine', 'Carlo', 'ccarlo@inlook.com','4879999784'),
(5,'Akansha','Acharya', 'aacharya@yehoo.com', '4441234789'),
(6,'Maya', 'Avila','aavila@coolmail.com', '8791235465'),
(7,'Dhwani', 'Desai', 'ddesai@yehoo.com', '8974561234'),
(8,'Robel', 'Desta', 'rdesta@inlook.com', '5469875233'),
(9,'Yi', 'Fang', 'yfang@coolmail.com', '12578943654'),
(10,'Ally', 'Haar', 'ahaar@inlook.com', '4456655321'),
(11,'Liz', 'Hsu', 'lhsu@zmail.com', '4157864233'),
(12,'Bhargavi', 'Chandrasekaran', 'bchan@zmail.com', '5789854126'),
(13,'Anna', 'Krekling', 'akrekling@yehaw.com', '3231211456'),
(14,'Alec', 'Liautaud', 'aliautaud@coolmail.com', '6567898124'),
(15,'Tsimba', 'Malonga', 'tmalonga@coolmail.com', '7894561323'),
(16,'Brad', 'Miller', 'bmiller@zmail.com', '1599511456'),
(17,'Georgia', 'Miller', 'gmiller@zmail.com', '9519511456'),
(18,'Vera', 'Norli', 'vnorli@yehoo.com', '3137894578'),
(19,'Busayo', 'Ogunniyan', 'bogunniyan@yehoo.com', '2125454897'),
(20,'Slater', 'Podgorny', 'spodgorny@yehoo.com', '8789874564'),
(21,'Caleb', 'Posey', 'cposey@yehoo.com', '4066987854'),
(22,'Nicole', 'Postlewaight', 'npostleweight@yehoo.com', '7845691548'),
(23,'Stephen', 'Prejean', 'sprejean@coolmail.com', '6469898777'),
(24,'Sabrina', 'Rivera', 'srivera@coolmail.com', '8789994541'),
(25,'Anish', 'Sriniketh', 'asriniketh@inlook.com', '4546566732'),
(26,'Nicole', 'Stefani', 'nstefani@yehoo.com', '3134789654'),
(27,'Joey', 'Streeter', 'jstreeter@coolmail.com', '7974588962'),
(28,'Darcy', 'Thompson', 'dthompson@zmail.com', '8987877414'),
(29,'Maria', 'Marin', 'mmarin@inlook.com','4145155616'),
(30,'Jielong', 'Xie', 'jxie@zmail.com', '5855955423'),
(31,'Tiger', 'Zhang', 'tzhang@coolmail.com', '1477411985');

--Use this code to create invoice statemnts for the customers
INSERT INTO DenverGrandHotel.dbo.Invoice (InvoiceID, DateOfBooking, CheckInDate, CheckOutDate, CustomerID)
VALUES (1, '2022-01-01 02:23:00 PM', '2022-07-03 04:03:02 PM', '2022-07-04 08:05:23 AM', 1),
(2, '2022-02-02 04:40:04 PM', '2022-06-07 06:59:01 PM', '2022-06-12 9:59:03 AM', 2),
(3, '2022-03-03 08:32:01 PM', '2022-03-04 05:45:45 PM', '2022-03-05 7:57:45 AM', 3),
(4, '2022-04-04 04:04:04 PM', '2022-08-08 04:35:37 PM', '2022-08-12 6:52:01 AM', 4),
(5, '2022-05-05 05:05:05 PM', '2022-09-09 09:09:09 PM', '2022-09-27 5:45:32 AM', 5),
(6, '2022-06-06 06:06:06 PM', '2022-10-10 10:10:10 PM', '2022-10-14 8:26:27 AM', 6),
(7, '2022-07-07 07:07:07 AM', '2022-11-11 11:11:11 PM', '2022-11-12 8:35:35 AM', 7),
(8, '2022-07-08 08:08:09 AM', '2022-10-31 04:32:11 PM', '2022-11-10 9:32:23 AM', 8),
(9, '2022-07-10 10:12:37 PM', '2022-07-10 03:42:10 PM', '2022-07-15 7:57:45 AM', 9),
(10, '2022-07-15 05:45:56 PM', '2022-08-07 05:56:12 PM', '2022-08-09 08:32:10 AM', 10),
(11, '2022-07-20 07:56:42 AM', '2022-07-21 08:45:45 PM', '2022-07-22 06:32:32 AM', 11),
(12, '2022-07-25 05:32:15 PM', '2022-08-01 02:30:00 PM', '2022-08-03 06:57:25 AM', 12),
(13, '2022-07-30 08:32:15 PM', '2022-09-15 05:52:03 PM', '2022-09-19 07:32:31 AM', 13),
(14, '2022-07-30 09:45:26 AM', '2022-09-15 05:32:02 PM', '2022-09-17 07:58:24 AM', 14),
(15, '2022-07-30 10:23:25 AM', '2022-08-05 06:23:15 PM', '2022-08-25 06:59:01 AM', 15),
(16, '2022-08-01 12:12:12 PM', '2022-09-30 08:16:14 PM', '2022-10-05 06:42:32 AM', 16),
(17, '2022-08-02 12:24:15 AM', '2022-08-04 09:21:15 PM', '2022-08-05 09:54:58 AM', 17),
(18, '2022-08-02 06:06:24 PM', '2022-08-05 10:15:34 PM', '2022-08-06 08:59:54 AM', 18),
(19, '2022-08-03 03:45:27 PM', '2022-09-09 09:32:02 PM', '2022-09-12 08:46:52 AM', 19),
(20, '2022-08-05 04:32:21 PM', '2022-09-10 05:12:06 PM', '2022-09-12 09:02:03 AM', 20),
(21, '2022-08-08 05:23:54 PM', '2022-10-02 06:28:07 PM', '2022-10-05 07:23:57 AM', 21),
(22, '2022-08-12 07:25:16 AM', '2022-08-12 07:58:07 PM', '2022-08-13 07:01:56 AM', 22),
(23, '2022-08-15 08:46:25 AM', '2022-08-27 08:56:01 PM', '2022-08-30 09:01:03 AM', 23),
(24, '2022-08-27 04:52:21 PM', '2022-08-29 07:07:07 PM', '2022-09-01 06:42:06 AM', 24),
(25, '2022-08-29 11:56:42 AM', '2022-08-30 03:56:42 PM', '2022-09-12 07:03:04 AM', 25),
(26, '2022-09-02 07:06:35 PM', '2022-09-05 07:45:34 PM', '2022-09-08 06:45:03 AM', 26),
(27, '2022-09-05 10:11:23 AM', '2022-10-10 08:23:02 PM', '2022-10-16 08:53:02 AM', 27),
(28, '2022-09-10 04:26:48 PM', '2022-09-13 04:02:00 PM', '2022-09-23 08:42:05 AM', 28),
(29, '2022-09-25 06:33:52 AM', '2022-09-27 08:08:09 PM', '2022-09-30 10:11:15 AM', 29),
(30, '2022-10-07 09:17:36 PM', '2022-10-09 05:54:03 PM', '2022-10-16 08:55:03 AM', 30),
(31, '2022-11-01 02:32:56 PM', '2022-11-03 07:54:52 PM', '2022-11-08 08:27:54 AM', 31);

--Use this code to insert data into Branch table
INSERT INTO DenverGrandHotel.dbo.Branch (BranchID, StreetAddress, City, State, ZipCode)
VALUES (1, '123 Denver Way', 'Denver', 'Colorado', 80000),
(2, '125 Colorado Way', 'Denver', 'Colorado', 80001)

--Use this code to isnert data into Department table
INSERT INTO DenverGrandHotel.dbo.Department (DepartmentID, DepartmentName, BranchID)
VALUES (1, 'Finance', 1),
(2, 'Marketing', 1),
(3, 'HR', 1),
(4, 'Management', 1),
(5, 'Front Office', 1),
(6, 'Housekeeping', 1),
(7, 'Guest Services', 1),
(8, 'Security', 1),
(9, 'Accounts', 1),
(10, 'Kitchen', 1),
(11, 'Finance', 2),
(12, 'Marketing', 2),
(13, 'HR', 2),
(14, 'Management', 2),
(15, 'Front Office', 2),
(16, 'Housekeeping', 2),
(17, 'Guest Services', 2),
(18, 'Security', 2),
(19, 'Accounts', 2),
(20, 'Kitchen', 2)

--Use this code to insert data into Employee Table
INSERT INTO DenverGrandHotel.dbo.Employee (EmployeeID, FirstName, LastName, EmployeeTitle, DepartmentID)
VALUES (1, 'Paul', 'Smith', 'Financial Officer', 1),
(2, 'Karen', 'Welsh', 'Marketing Officer', 1),
(3, 'Carol', 'Henry', 'HR Rep', 1),
(4, 'Michael', 'Quant', 'Manager', 1),
(5, 'Casper', 'Friendly', 'Receptionist', 1),
(6, 'Jake', 'Hughe', 'Housekeeper', 1),
(7, 'Linda', 'Sprite', 'Guest Services Specialist', 1),
(8, 'Paul', 'Pepper', 'Gaurd', 1),
(9, 'Jim', 'Spam', 'Accountant', 1),
(10, 'Chase', 'Carr', 'Chef', 1),
(11, 'Charles', 'Prince', 'Financial Officer', 2),
(12, 'Charlie', 'Down', 'Marketing Officer', 2),
(13, 'Riley', 'Tremmel', 'HR Rep', 2),
(14, 'Aliya', 'Getchell', 'Manager', 2),
(15, 'Casey', 'Bradly', 'Receptionist', 2),
(16, 'Chris', 'Lahey', 'Housekeeper', 2),
(17, 'Julian', 'Duluan', 'Guest Services Specialist', 2),
(18, 'Cater', 'Jones', 'Gaurd', 2),
(19, 'Jamie', 'Beck', 'Accountant', 2),
(20, 'Hunter', 'Weber', 'Chef', 2)

--Use this code to insert data into the Supplier Table
INSERT INTO DenverGrandHotel.dbo.Supplier (SupplierID, SupplierName)
VALUES (1, 'Crest'),
(2, 'Bath and Body Works'),
(3, 'Shamrock Foods'),
(4, 'Coca Cola'),
(5, 'Pens are Us'),
(6, '123 Furnishings'),
(7, 'Crazy Artwork Co.'),
(8, 'Lights are Bright Co.'),
(9, 'Quick Construction Co.'),
(10, 'Netflix')

-- Use this code to add entries to the Amenity Table
INSERT INTO DenverGrandHotel.dbo.Amenity (AmenityID, AmenityType, SupplierID)
VALUES (1, 'Toothpaste', 1),
(2, 'Shampoo', 2),
(3, 'Lotion', 2),
(4, 'Coke', 3),
(5, 'Pens', 5),
(6, 'Beds', 6),
(7, 'Art', 7),
(8, 'Floor Lamp', 8),
(9, 'Tool Kit', 9),
(10, 'Netflix Subscriptions', 10),
(11, 'Steak', 3)

-- Use this code to add data into the RepairArea table
INSERT INTO DenverGrandHotel.dbo.RepairArea (RepairID, StartDate, EndDate)
VALUES (1, '2022-01-02 12:37:45 PM', '2022-03-03 8:37:12 AM'),
(2, '2022-11-10 9:45:37 AM', '')

-- Use this code to link/match RoomID to the correct InvoiceID
INSERT INTO Room_Invoice (RoomID, InvoiceID)
VALUES (101,1),
(222, 2),
(209, 3),
(405, 4),
(517, 5),
(555, 6),
(520, 7),
(407, 8),
(405, 9),
(333, 10),
(107, 11),
(407, 12),
(501, 13),
(115, 14),
(107, 15),
(525, 16),
(310, 17),
(525, 18),
(209, 19),
(520, 20),
(211, 21),
(101, 22),
(105, 23),
(340, 24),
(340, 25),
(525, 26),
(211, 27),
(115, 28),
(340, 29),
(517, 30),
(555, 31)

-- Use this code to link/match the repair area and employee
INSERT INTO DenverGrandHotel.dbo.RepairArea_Employee (RepairID, EmployeeID)
VALUES (1, 6),
(2, 14)

-- Use this code to link/match the amenity and the room
INSERT INTO DenverGrandHotel.dbo.Amenity_Room (RoomID, AmenityID)
VALUES (101, 1), 
(101, 2), 
(101, 3),
(101, 5),
(101, 6),
(101, 7),
(101, 8),
(105, 1), 
(105, 2), 
(105, 3),
(105, 5),
(105, 6),
(105, 7),
(105, 8),
(107, 1), 
(107, 2), 
(107, 3),
(107, 5),
(107, 6),
(107, 7),
(107, 8),
(115, 1), 
(115, 2), 
(115, 3),
(115, 5),
(115, 6),
(115, 7),
(115, 8),
(222, 1), 
(222, 2), 
(222, 3),
(222, 5),
(222, 6),
(222, 7),
(222, 8),
(209, 1), 
(209, 2), 
(209, 3),
(209, 5),
(209, 6),
(209, 7),
(209, 8),
(211, 1), 
(211, 2), 
(211, 3),
(211, 5),
(211, 6),
(211, 7),
(211, 8),
(315, 1), 
(315, 2), 
(315, 3),
(315, 5),
(315, 6),
(315, 7),
(315, 8),
(310, 1), 
(310, 2), 
(310, 3),
(310, 5),
(310, 6),
(310, 7),
(310, 8),
(333, 1), 
(333, 2), 
(333, 3),
(333, 5),
(333, 6),
(333, 7),
(333, 8),
(340, 1), 
(340, 2), 
(340, 3),
(340, 5),
(340, 6),
(340, 7),
(340, 8),
(401, 1), 
(401, 2), 
(401, 3),
(401, 5),
(401, 6),
(401, 7),
(401, 8),
(405, 1), 
(405, 2), 
(405, 3),
(405, 5),
(405, 6),
(405, 7),
(405, 8),
(407, 1), 
(407, 2), 
(407, 3),
(407, 5),
(407, 6),
(407, 7),
(407, 8),
(444, 1), 
(444, 2), 
(444, 3),
(444, 5),
(444, 6),
(444, 7),
(444, 8),
(501, 1), 
(501, 2), 
(501, 3),
(501, 5),
(501, 6),
(501, 7),
(501, 8),
(517, 1), 
(517, 2), 
(517, 3),
(517, 5),
(517, 6),
(517, 7),
(517, 8),
(520, 1), 
(520, 2), 
(520, 3),
(520, 5),
(520, 6),
(520, 7),
(520, 8),
(525, 1), 
(525, 2), 
(525, 3),
(525, 4),
(525, 5),
(525, 6),
(525, 7),
(525, 8),
(525, 9),
(525, 10),
(555, 1), 
(555, 2), 
(555, 3),
(555, 4),
(555, 5),
(555, 6),
(555, 7),
(555, 8),
(555, 9),
(555, 10),
(555, 11)

ALTER TABLE DenverGrandHotel.dbo.Room
ADD RoomPrice FLOAT;

UPDATE DenverGrandHotel.dbo.Room
SET RoomPrice = 120 
WHERE RoomType = 'King'

UPDATE DenverGrandHotel.dbo.Room
SET RoomPrice = 140 
WHERE RoomType = 'Double Queen' 

UPDATE DenverGrandHotel.dbo.Room
SET RoomPrice = 180 
WHERE RoomType = 'Suite' 

UPDATE DenverGrandHotel.dbo.Room
SET RoomPrice = 220 
WHERE RoomType = 'VP Suite' 

UPDATE DenverGrandHotel.dbo.Room
SET RoomPrice = 250
WHERE RoomType = 'Presidential Suite' 

ALTER TABLE DenverGrandHotel.dbo.RepairArea
ADD RepairArea_Cost FLOAT;

UPDATE DenverGrandHotel.dbo.RepairArea
SET RepairArea_Cost = 1000
WHERE RepairID = 1 

UPDATE DenverGrandHotel.dbo.RepairArea
SET RepairArea_Cost = 2000
WHERE RepairID = 2 

ALTER TABLE DenverGrandHotel.dbo.Customer
ADD CustomerDOB DATE;





