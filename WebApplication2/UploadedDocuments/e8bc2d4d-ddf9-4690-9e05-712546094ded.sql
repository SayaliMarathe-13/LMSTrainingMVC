--Authors Table
create table Authors(
AuthorId int primary key IDENTITY(1,1),
AuthorName varchar(100) not null,
IsActive BIT,
CreatedBy INT,
CreatedOn DATETIME,
ModifiedBy INT,
ModifiedOn DATETIME
)


CREATE PROCEDURE AuthorsInsert 
@AuthorId int OUTPUT,
@AuthorName varchar(100),
@IsActive BIT,
@CreatedBy INT,
@CreatedOn DATETIME

/*
***********************************************************************************************
	Date   			Created By   	Purpose of Creation
1	27Mar2025		Sayali Marathe	Insert Authors
***********************************************************************************************
*/

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




CREATE PROCEDURE AuthorsGetDetails
@AuthorId INT
/*
***********************************************************************************************
	Date   			Created By   		Purpose of Creation
1   27Mar2025	    Sayali Marathe		Get List from Authors
***********************************************************************************************

AuthorsGetDetails 1 

*/
AS
BEGIN

	SELECT
		ISNULL(AuthorId, '') AS AuthorId,
		ISNULL(AuthorName, '') AS AuthorName,
		ISNULL(IsActive, '') AS IsActive,
		ISNULL(CreatedBy, '') AS CreatedBy,
		ISNULL(CreatedOn, '') AS CreatedOn,
		ISNULL(ModifiedBy, '') AS ModifiedBy,
		ISNULL(ModifiedOn, '') AS ModifiedOn
	FROM
		Authors
	WHERE
		AuthorId = @AuthorId


END
GO


CREATE PROCEDURE AuthorsGetList
/*
***********************************************************************************************
	Date   			Created By   		Purpose of Creation
1	27Mar2025		Sayali Marathe		Get List for Authors
***********************************************************************************************
AuthorsGetList

*/
AS
BEGIN

	SELECT 
		ISNULL(AuthorId, '') AS AuthorId,
		ISNULL(AuthorName, '') AS AuthorName,
		ISNULL(IsActive, '') AS IsActive,
		ISNULL(CreatedBy, '') AS CreatedBy,
		ISNULL(CreatedOn, '') AS CreatedOn,
		ISNULL(ModifiedBy, '') AS ModifiedBy,
		ISNULL(ModifiedOn, '') AS ModifiedOn
	FROM
		Authors
	
END

GO

/*************************************************************************************************/
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


/*
***********************************************************************************************
	Date   			Created By   	Purpose of Creation
1	27Mar2025		Sayali Marathe	Insert Publishers
***********************************************************************************************
*/
CREATE PROCEDURE PublishersInsert
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

/*
***********************************************************************************************
	Date   			Created By   		Purpose of Creation
1   27Mar2025	    Sayali Marathe		Get List from Publishers
***********************************************************************************************

PublishersGetDetails 1 

*/

CREATE PROCEDURE PublishersGetDetails
@PublisherId INT

AS
BEGIN

	SELECT
		ISNULL(PublisherId, '') AS PublisherId,
		ISNULL(PublisherName, '') AS PublisherName,
		ISNULL(IsActive, '') AS IsActive,
		ISNULL(CreatedBy, '') AS CreatedBy,
		ISNULL(CreatedOn, '') AS CreatedOn,
		ISNULL(ModifiedBy, '') AS ModifiedBy,
		ISNULL(ModifiedOn, '') AS ModifiedOn
	FROM
		Publishers
	WHERE
		PublisherId = @PublisherId


END
GO

/*
***********************************************************************************************
	Date   			Created By   		Purpose of Creation
1	27Mar2025		Sayali Marathe		Get List for Publishers
***********************************************************************************************
PublishersGetList

*/

CREATE PROCEDURE PublishersGetList

AS
BEGIN

	SELECT 
		ISNULL(PublisherId, '') AS PublisherId,
		ISNULL(PublisherName, '') AS PublisherName,
		ISNULL(IsActive, '') AS IsActive,
		ISNULL(CreatedBy, '') AS CreatedBy,
		ISNULL(CreatedOn, '') AS CreatedOn,
		ISNULL(ModifiedBy, '') AS ModifiedBy,
		ISNULL(ModifiedOn, '') AS ModifiedOn
	FROM
		Publishers
	
END

GO

/*************************************************************************************************/
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

/*
***********************************************************************************************
	Date   			Created By   	Purpose of Creation
1	27Mar2025		Sayali Marathe	Insert Suppliers
***********************************************************************************************
*/
CREATE PROCEDURE SuppliersInsert
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

/*
***********************************************************************************************
	Date   			Created By   		Purpose of Creation
1   27Mar2025	    Sayali Marathe		Get List from Suppliers
***********************************************************************************************

SuppliersGetDetails 1 

*/

CREATE PROCEDURE SuppliersGetDetails
@SupplierId INT

AS
BEGIN

	SELECT
		ISNULL(SupplierId, '') AS SupplierId,
		ISNULL(SupplierName, '') AS SupplierName,
		ISNULL(Contact, '') AS Contact,
		ISNULL(IsActive, '') AS IsActive,
		ISNULL(CreatedBy, '') AS CreatedBy,
		ISNULL(CreatedOn, '') AS CreatedOn,
		ISNULL(ModifiedBy, '') AS ModifiedBy,
		ISNULL(ModifiedOn, '') AS ModifiedOn
	FROM
		Suppliers
	WHERE
		SupplierId = @SupplierId


END
GO
/*
***********************************************************************************************
	Date   			Created By   		Purpose of Creation
1	27Mar2025		Sayali Marathe		Get List for Suppliers
***********************************************************************************************
SuppliersGetList

*/

CREATE PROCEDURE SuppliersGetList

AS
BEGIN

	SELECT 
		ISNULL(SupplierId, '') AS SupplierId,
		ISNULL(SupplierName, '') AS SupplierName,
		ISNULL(Contact, '') AS Contact,
		ISNULL(IsActive, '') AS IsActive,
		ISNULL(CreatedBy, '') AS CreatedBy,
		ISNULL(CreatedOn, '') AS CreatedOn,
		ISNULL(ModifiedBy, '') AS ModifiedBy,
		ISNULL(ModifiedOn, '') AS ModifiedOn
	FROM
		Suppliers
	
END

GO

/*************************************************************************************************/
--Departments Table
CREATE TABLE Departments(
DepartmentId INT PRIMARY KEY IDENTITY(1,1),
DepartmentName VARCHAR(20) NOT NULL,
IsActive BIT,
CreatedBy INT,
CreatedOn DATETIME,
ModifiedBy INT,
ModifiedOn DATETIME
)
/*
***********************************************************************************************
	Date   			Created By   	Purpose of Creation
1	27Mar2025		Sayali Marathe	Insert Departments
***********************************************************************************************
*/
CREATE PROCEDURE DepartmentsInsert

@DepartmentId INT OUTPUT,
@DepartmentName VARCHAR (200),
@IsActive BIT,
@CreatedBy INT,
@CreatedOn DATETIME

AS
BEGIN

	INSERT INTO Departments
	(
		DepartmentName,
		IsActive,
		CreatedBy,
		CreatedOn
		
	)
	VALUES
	(
		@DepartmentName,
		@IsActive,
		@CreatedBy,
		@CreatedOn
	)

	SET @DepartmentId = @@IDENTITY;
END

GO

/*
***********************************************************************************************
	Date   			Created By   		Purpose of Creation
1   27Mar2025	    Sayali Marathe		Get List from Departments
***********************************************************************************************

DepartmentsGetDetails 1 

*/
CREATE PROCEDURE DepartmentGetDetails
@DepartmentId INT

AS
BEGIN

	SELECT
		ISNULL(DepartmentId, '') AS DepartmentId,
		ISNULL(DepartmentName, '') AS DepartmentName,
		ISNULL(IsActive, '') AS IsActive,
		ISNULL(CreatedBy, '') AS CreatedBy,
		ISNULL(CreatedOn, '') AS CreatedOn,
		ISNULL(ModifiedBy, '') AS ModifiedBy,
		ISNULL(ModifiedOn, '') AS ModifiedOn
	FROM
		Departments
	WHERE
		DepartmentId = @DepartmentId
END
GO
/*
***********************************************************************************************
	Date   			Created By   		Purpose of Creation
1	27Mar2025		Sayali Marathe		Get List for Departments
***********************************************************************************************
DepartmentsGetList

*/

CREATE PROCEDURE DepartmentsGetList

AS
BEGIN

	SELECT 
		ISNULL(DepartmentId, '') AS DepartmentId,
		ISNULL(DepartmentName, '') AS DepartmentName,
		ISNULL(IsActive, '') AS IsActive,
		ISNULL(CreatedBy, '') AS CreatedBy,
		ISNULL(CreatedOn, '') AS CreatedOn,
		ISNULL(ModifiedBy, '') AS ModifiedBy,
		ISNULL(ModifiedOn, '') AS ModifiedOn
	FROM
		Departments
	
END

GO

/*************************************************************************************************/
--Courses Table
CREATE TABLE Courses(
CourseId INT PRIMARY KEY IDENTITY(1,1),
CourseName VARCHAR(20) NOT NULL,
DepartmentId int FOREIGN key REFERENCES Departments(DepartmentId),
IsActive BIT,
CreatedBy INT,
CreatedOn DATETIME,
ModifiedBy INT,
ModifiedOn DATETIME
)

/*
***********************************************************************************************
	Date   			Created By   	Purpose of Creation
1	27Mar2025		Sayali Marathe	Insert Courses
***********************************************************************************************
*/
CREATE PROCEDURE CoursesInsert

@CourseId INT OUTPUT,
@CourseName VARCHAR (200),
@IsActive BIT,
@CreatedBy INT,
@CreatedOn DATETIME

AS
BEGIN

	INSERT INTO Courses
	(
		CourseName,
		IsActive,
		CreatedBy,
		CreatedOn
		
	)
	VALUES
	(
		@CourseName,
		@IsActive,
		@CreatedBy,
		@CreatedOn
	)

	SET @CourseId = @@IDENTITY;
END

GO

/*
***********************************************************************************************
	Date   			Created By   		Purpose of Creation
1   27Mar2025	    Sayali Marathe		Get List from Courses
***********************************************************************************************

CoursesGetDetails 1 

*/
CREATE PROCEDURE CoursesGetDetails
@CourseId INT

AS
BEGIN

	SELECT
		ISNULL(CourseId, '') AS CourseId,
		ISNULL(CourseName, '') AS CourseName,
		ISNULL(DepartmentId, '') AS DepartmentId,
		ISNULL(IsActive, '') AS IsActive,
		ISNULL(CreatedBy, '') AS CreatedBy,
		ISNULL(CreatedOn, '') AS CreatedOn,
		ISNULL(ModifiedBy, '') AS ModifiedBy,
		ISNULL(ModifiedOn, '') AS ModifiedOn
	FROM
		Courses
	WHERE
		CourseId = @CourseId
END
GO
/*
***********************************************************************************************
	Date   			Created By   		Purpose of Creation
1	27Mar2025		Sayali Marathe		Get List for Courses
***********************************************************************************************
CoursesGetList

*/

CREATE PROCEDURE CoursesGetList

AS
BEGIN

	SELECT 
		ISNULL(CourseId, '') AS CourseId,
		ISNULL(CourseName, '') AS CourseName,
		ISNULL(DepartmentId, '') AS DepartmentId,
		ISNULL(IsActive, '') AS IsActive,
		ISNULL(CreatedBy, '') AS CreatedBy,
		ISNULL(CreatedOn, '') AS CreatedOn,
		ISNULL(ModifiedBy, '') AS ModifiedBy,
		ISNULL(ModifiedOn, '') AS ModifiedOn
	FROM
		Courses
	
END

GO

/*************************************************************************************************/
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


/*
***********************************************************************************************
	Date   			Created By   	Purpose of Creation
1	27Mar2025		Sayali Marathe	Insert Books
***********************************************************************************************
*/
CREATE PROCEDURE BooksInsert

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


	INSERT INTO Books
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


/*
***********************************************************************************************
	Date   			Created By   		Purpose of Creation
1	27Mar2025		Sayali Marathe		Update from Books
***********************************************************************************************
*/
CREATE PROCEDURE BooksUpdate

@BookId INT,
@BookName VARCHAR (200),
@PublisherId int,
@ISBN Varchar(10),
@TotalCopies varchar(200),
@CourseId int,
@SupplierId int,
@IsActive BIT,
@ModifiedBy INT,
@ModifiedOn DATETIME

AS
BEGIN


	UPDATE
		Books
	SET
		BookId = @BookId,
		BookName = @BookName,
		PublisherId = @PublisherId,
		ISBN = @ISBN,
		TotalCopies = @TotalCopies ,
		CourseId = @CourseId,
		SupplierId = @SupplierId,
		IsActive = @IsActive,
		ModifiedBy = @ModifiedBy,
		ModifiedOn = @ModifiedOn 
	WHERE
		BookId = @BookId

END

GO


/*
***********************************************************************************************
	Date   			Created By   		Purpose of Creation
1	27Mar2025		Sayali Marathe		Delete record from Books
***********************************************************************************************
BooksDelete 1

*/
CREATE PROCEDURE BooksDelete
@BookId INT

AS
BEGIN

	UPDATE Books
	SET IsActive = 0 
	WHERE
	BookId = @BookId
 
END

GO

/*
***********************************************************************************************
	Date   			Created By   		Purpose of Creation
1	28Mar2025		Sayali Marathe		Get List from Books
***********************************************************************************************

BooksGetDetails 1 

*/
CREATE PROCEDURE BooksGetDetails

@BookId INT

AS
BEGIN


	SELECT
		ISNULL(BookId, '') AS BookId,
		ISNULL(BookName, '') AS BookName,
		ISNULL(PublisherId, '') AS PublisherId,
		ISNULL(ISBN, '') AS ISBN,
		ISNULL(TotalCopies, '') AS TotalCopies,
		ISNULL(CourseId, '') AS CourseId,
		ISNULL(SupplierId, '') AS SupplierId,
		ISNULL(IsActive, '') AS IsActive,
		ISNULL(CreatedBy, '') AS CreatedBy,
		ISNULL(CreatedOn, '') AS CreatedOn,
		ISNULL(ModifiedBy, '') AS ModifiedBy,
		ISNULL(ModifiedOn, '') AS ModifiedOn
	FROM
		Books
	WHERE
		BookId = @BookId


END


GO


/*
***********************************************************************************************
	Date   			Created By   		Purpose of Creation
1	28Mar2025		Sayali Marathe	    Get List for Books
***********************************************************************************************
BooksGetList

*/

CREATE PROCEDURE BooksGetList

AS
BEGIN

	SELECT 
		ISNULL(BookId, '') AS BookId,
		ISNULL(BookName, '') AS BookName,
		ISNULL(PublisherId, '') AS PublisherId,
		ISNULL(ISBN, '') AS ISBN,
		ISNULL(TotalCopies, '') AS TotalCopies,
		ISNULL(CourseId, '') AS CourseId,
		ISNULL(SupplierId, '') AS SupplierId,
		ISNULL(IsActive, '') AS IsActive,
		ISNULL(CreatedBy, '') AS CreatedBy,
		ISNULL(CreatedOn, '') AS CreatedOn,
		ISNULL(ModifiedBy, '') AS ModifiedBy,
		ISNULL(ModifiedOn, '') AS ModifiedOn
	FROM
		Books
	
END


GO

