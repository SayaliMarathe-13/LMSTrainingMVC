use TrainingDB_SayaliMarathe 

--Authors Table
create table Authors(
AuthorId int primary key IDENTITY(1,1),
AuthorName varchar(15) not null,
IsActive BIT,
CreatedBy INT,
CreatedOn DATETIME,
ModifiedBy INT,
ModifiedOn DATETIME
)

--Authors Procedure To Insert Record
CREATE PROCEDURE UspAuthorsInsert 
@AuthorId int OUTPUT,
@AuthorName varchar(15),
@IsActive BIT,
@CreatedBy INT,
@CreatedOn DATETIME

AS
Begin
   INSERT INTO Authors
	(
		AuthorName,
		IsActive,
		CreatedBy,
		CreatedOn

	)
	VALUES
	(
		@AuthorName,
		@IsActive,
		@CreatedBy,
		@CreatedOn
	)
	SET @AuthorId = @@IDENTITY;
End
Go

DECLARE @NewAuthorId INT;
DECLARE @currentTime datetime;
set @currentTime=getdate();
EXEC UspAuthorsInsert @NewAuthorId OUTPUT,'Aravind Adiga',1, 1,@currentTime;
PRINT @NewAuthorId

select * from Authors;


/*CREATE PROCEDURE UspAuthorsCount
@AuthorsCount INT OUTPUT
AS
BEGIN
  SELECT @AuthorsCount=count(*) FROM Authors
END

DECLARE @AuthorsCount INT
EXECUTE UspAuthorsCount @AuthorsCount OUTPUT
PRINT @AuthorsCount */

--Publishers Table
CREATE TABLE Publishers(
PublisherId INT PRIMARY KEY IDENTITY(1,1),
PublisherName VARCHAR(20) NOT NULL,
IsActive BIT,
CreatedBy INT,
CreatedOn DATETIME,
ModifiedBy INT,
ModifiedOn DATETIME
)

--Publishers Procedure to insert record
CREATE PROCEDURE UspPublishersInsert
@PublisherId INT OUTPUT,
@PublisherName VARCHAR(20),
@IsActive BIT,
@CreatedBy INT,
@CreatedOn DATETIME

AS
Begin
   INSERT INTO Publishers
	(
		PublisherName,
		IsActive,
		CreatedBy,
		CreatedOn
	
	)
	VALUES
	(
		@PublisherName,
		@IsActive,
		@CreatedBy,
		@CreatedOn
	)
	SET @PublisherId = @@IDENTITY;
END
GO

DECLARE @PublisherId INT;
DECLARE @CurrentTime DATETIME;
SET @CurrentTime=getdate();
EXEC UspPublishersInsert @PublisherId OUTPUT,'Nirali',1, 1,@CurrentTime;

SELECT * FROM Publishers

--Suppliers Table
CREATE TABLE Suppliers(
SupplierId INT PRIMARY KEY IDENTITY(1,1),
SupplierName VARCHAR(20) NOT NULL,
Contact VARCHAR(10),
IsActive BIT,
CreatedBy INT,
CreatedOn DATETIME,
ModifiedBy INT,
ModifiedOn DATETIME
)

--Suppliers Procedure to insert record
CREATE PROCEDURE UspSuppliersInsert
@SupplierId INT OUTPUT,
@SupplierName VARCHAR(20),
@Contact VARCHAR(10),
@IsActive BIT,
@CreatedBy INT,
@CreatedOn DATETIME

AS
Begin
   INSERT INTO Suppliers
	(
		SupplierName,
		Contact,
		IsActive,
		CreatedBy,
		CreatedOn
	
	)
	VALUES
	(
		@SupplierName,
		@Contact,
		@IsActive,
		@CreatedBy,
		@CreatedOn
	)
	SET @SupplierId = @@IDENTITY;
End
Go

DECLARE @SupplierId INT;
DECLARE @CurrentTime DATETIME;
SET @CurrentTime=getdate();
EXEC UspSuppliersInsert @SupplierId OUTPUT,'Rakesh','9865784532', 1,1,@currentTime;

SELECT * FROM Suppliers;


--BookStatus Table 
CREATE TABLE BookStatus(
BookStatusId INT PRIMARY KEY IDENTITY(1,1),
BookStatus VARCHAR(10) NOT NULL
)

--BookStatus Insert Procedure
CREATE PROC UspBookStatusInsert
@BookStatusId INT OUTPUT,
@BookStatus VARCHAR(10)
AS
BEGIN
   INSERT INTO BookStatus
   (
   BookStatus
   )
   VALUES
   (
   @BookStatus
   )
   SET @BookStatusId=@@IDENTITY
END
GO

DECLARE @BookStatusId INT;
EXEC UspBookStatusInsert @BookStatusId OUTPUT,'Lost'

SELECT * FROM BookStatus;


--MemberType Table
CREATE TABLE MemberType(
MemberTypeId INT PRIMARY KEY IDENTITY(1,1),
MemberType VARCHAR(10)
)


--MemberType Insert Procedure
CREATE PROC UspMemberTypeInsert
@MemberTypeId INT OUTPUT,
@MemberType VARCHAR(10)
AS
BEGIN
   INSERT INTO MemberType
   (
   MemberType
   )
   VALUES
   (
   @MemberType
   )
   SET @MemberTypeId= @@IDENTITY
END 
GO

DECLARE @MemberTypeId INT
EXEC UspMemberTypeInsert @MemberTypeId OUTPUT, 'Teacher'

SELECT * FROM MemberType


--Departments Table
CREATE TABLE Departments(
DepartmentId INT PRIMARY KEY IDENTITY(1,1),
DepartmentName VARCHAR(20) NOT NULL
)


--Departments Insert Procedure
CREATE PROC UspDepartmentInsert
@DepartmentId INT OUTPUT,
@DepartmentName VARCHAR(20)
AS
BEGIN
   INSERT INTO Departments
   (
   DepartmentName 
   )
   VALUES
   (
   @DepartmentName
   )
   SET @DepartmentId= @@IDENTITY
END 
GO

DECLARE @DepartmentId INT
EXEC UspDepartmentInsert @DepartmentId OUTPUT, 'Automobile'
SELECT * FROM Departments


--Courses Table
CREATE TABLE Courses(
CourseId INT PRIMARY KEY IDENTITY(1,1),
CourseName VARCHAR(20) NOT NULL,
DepartmentId int FOREIGN key REFERENCES Departments(DepartmentId) 
)


--Courses Insert Procedure
CREATE PROC UspCourseInsert
@CourseId INT OUTPUT,
@CourseName VARCHAR(20),
@DepartmentId int
AS
BEGIN
   INSERT INTO Courses
   (
   CourseName,
   DepartmentId
   )
   VALUES
   (
   @CourseName,
   @DepartmentId
   )
   SET @CourseId= @@IDENTITY
END 
GO

DECLARE @CourseId INT
EXEC UspCourseInsert @CourseId OUTPUT, 'Theory of machines',3
SELECT * FROM Courses


--Books Table
CREATE TABLE Books
(
BookId INT PRIMARY KEY IDENTITY(1,1),
BookName VARCHAR (25),
PublisherId INT FOREIGN KEY REFERENCES Publishers(PublisherId),
ISBN Varchar(10),
TotalCopies INT,
CourseId INT FOREIGN KEY REFERENCES Courses(CourseId),
SupplierId INT FOREIGN KEY REFERENCES Suppliers(SupplierId),
IsActive BIT,
CreatedBy INT,
CreatedOn DATETIME,
ModifiedBy INT,
ModifiedOn DATETIME
)


--Book Insert Procedure
CREATE PROCEDURE UspBookInsert

@BookId INT OUTPUT,
@BookName VARCHAR (25),
@PublisherId INT,
@ISBN VARCHAR(10),
@TotalCopies INT,
@CourseId INT,
@SupplierId INT,
@IsActive BIT,
@CreatedBy INT,
@CreatedOn DATETIME

AS
BEGIN


	INSERT INTO bOOKS
	(
		BookName,
		PublisherId,
		ISBN,
		TotalCopies,
		CourseId,
		SupplierId,
		IsActive,
		CreatedBy,
		CreatedOn
		
	)
	VALUES
	(
		@BookName,
		@PublisherId,
		@ISBN,
		@TotalCopies,
		@CourseId,
		@SupplierId,
		@IsActive,
		@CreatedBy,
		@CreatedOn
	)

	SET @BookId = @@IDENTITY;
END

GO

DECLARE @BookId INT;
DECLARE @CurrentDate DATETIME;
SET @CurrentDate=GETDATE();
EXEC UspBookInsert @BookId OUTPUT, 'Operating System',1,'1256997845',3,1,1,1,1,@CurrentDate
SELECT * FROM Books