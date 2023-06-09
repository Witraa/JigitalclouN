-- Membuat Database

CREATE DATABASE JigitalclouN

use JigitalclouN

-- Membuat Table
CREATE TABLE MsStaff (
	StaffID VARCHAR(9) PRIMARY KEY CHECK (StaffID LIKE 'JCN-S[3-7][1-2][0-9][0-9]'),
	StaffName VARCHAR(200) not null,
	StaffGender VARCHAR(50)
		CONSTRAINT validateStaffGender CHECK (StaffGender LIKE 'Male' or StaffGender LIKE 'Female'),
	StaffEmail VARCHAR(200)
		CONSTRAINT validateStaffEmail CHECK(StaffEmail LIKE '%@%.%'),
	StaffDOB Date not null,
	StaffPhoneNumber VARCHAR(12) not null,
	StaffAddress VARCHAR(200) not null,
	StaffSalary VARCHAR(200)
		CONSTRAINT validateStaffSalary CHECK (StaffSalary >3500000 AND StaffSalary <20000000)
)

CREATE TABLE MsMemory (
	MemoryID VARCHAR(9) PRIMARY KEY CHECK (MemoryID LIKE 'JCN-M[3-7][1-2][0-9][0-9]'),
	MemoryName VARCHAR(200) not null,
	MemoryModel VARCHAR(200) not null,
	MemoryFrequency VARCHAR(200) not null
		CONSTRAINT ValidateMemoryFrequency CHECK (MemoryFrequency LIKE '%MHz'),
	MemoryCapacity VARCHAR(200) not null
		CONSTRAINT ValidateMemoryCapacity CHECK (MemoryCapacity LIKE '%GB')
)

CREATE TABLE MsProcessor (
	ProcessorID VARCHAR(9) PRIMARY KEY CHECK (ProcessorID LIKE 'JCN-P[3-7][1-2][0-9][0-9]'),
	ProcessorName VARCHAR(200) not null,
	ProcessorModel VARCHAR(200) not null,
	ProcessorPrice VARCHAR(200) not null,
	ProcessorClockSpeed VARCHAR(200) not null
		CONSTRAINT ValidateProcessorClockSpeed CHECK (ProcessorClockSpeed LIKE '%MHz'),
	ProcessorCores VARCHAR(200) not null
)

CREATE TABLE MsLocation (
	LocationID VARCHAR(9) PRIMARY KEY CHECK (LocationID LIKE 'JCN-L[3-7][1-2][0-9][0-9]'),
	LocationCityName VARCHAR(200) not null,
	LocationCountryName VARCHAR(200) not null,
	LocationZipcode VARCHAR(200) not null,
	LocationLatitude INT
		CONSTRAINT validateLocationLatitude CHECK (
		LocationLatitude >-90 AND LocationLatitude <90 
		AND LocationLatitude LIKE '[0-9][0-9][0-9][0-9][0-9][0-9]'
		),
	LocationLongitude INT
		CONSTRAINT validateLocationLongitude CHECK (
		LocationLongitude >-180 AND LocationLongitude <180
		AND LocationLongitude LIKE '[0-9][0-9][0-9][0-9][0-9][0-9]'
		)
)

CREATE TABLE MsServer (
	ServerID VARCHAR(9) PRIMARY KEY CHECK (ServerID LIKE 'JCN-V[3-7][1-2][0-9][0-9]'),
	MemoryID VARCHAR(9) REFERENCES MsMemory(MemoryID),
	ProcessorID VARCHAR(9) REFERENCES MsProcessor(ProcessorID),
	LocationID VARCHAR(9) REFERENCES MsLocation(LocationID)
)

CREATE TABLE MsCustomer (
	CustomerID VARCHAR (9) PRIMARY KEY CHECK (CustomerID LIKE 'JCN-C[3-7][1-2][0-9][0-9]'),
	CustomerName VARCHAR(200) not null,
	CustomerGender VARCHAR(200)
		CONSTRAINT validateCustomerGender CHECK (
		CustomerGender LIKE 'Male, Female'
		),
	CustomerEmail VARCHAR(200) not null,
	CustomerDOB Date not null,
	CustomerPhoneNumber VARCHAR(200) not null,
	CustomerAddress VARCHAR(200) not null,
	CustomerAge INT
		CONSTRAINT validateCustomerAge CHECK (
		CustomerAge > 15	
		)
)

CREATE TABLE RentalTransaction (
	RentID VARCHAR(9) PRIMARY KEY CHECK (RentID LIKE 'JCN-R[0-2][1-2][0-9][0-9]'),
	StaffID VARCHAR(9) FOREIGN KEY REFERENCES MsStaff (StaffID),
	CustomerID VARCHAR(9) FOREIGN KEY REFERENCES MsCustomer(CustomerID),
	ServerID VARCHAR(9) FOREIGN KEY REFERENCES MsServer(ServerID),
	RentDate Date NOT NULL,
	RentDuration INT
		CONSTRAINT validateRentDuration CHECK (RentDuration >=1 AND RentDuration <=12) NOT NULL
)

CREATE TABLE SaleTransaction (
	SaleID VARCHAR(9) PRIMARY KEY CHECK (SaleID LIKE 'JCN-S[0-2][1-2][0-9][0-9]'),
	StaffID VARCHAR(9) FOREIGN KEY REFERENCES MsStaff (StaffID),
	CustomerID VARCHAR(9) FOREIGN KEY REFERENCES MsCustomer (CustomerID),
	ServerSold VARCHAR(50) NOT NULL,
	TransactionDate Date NOT NULL
)

Select *
From MsCustomer
