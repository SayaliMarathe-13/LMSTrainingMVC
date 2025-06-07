
--Publishers Table
CREATE TABLE Publishers(
PublisherId INT PRIMARY KEY IDENTITY(1,1),
PublisherName VARCHAR(100) NOT NULL,
IsActive BIT,
CreatedBy INT,
CreatedOn DATETIME,
ModifiedBy INT,
ModifiedOn DATETIME
)

CREATE PROCEDURE PublishersInsert
@PublisherId INT OUTPUT,
@PublisherName VARCHAR(100),
@IsActive BIT,
@CreatedBy INT,
@CreatedOn DATETIME

/*
***********************************************************************************************
	Date   			Created By   	Purpose of Creation
1	27Mar2025		Sayali Marathe	Insert Publishers
***********************************************************************************************
*/
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
SET @CurrentTime = GETDATE();
EXEC PublishersInsert @PublisherId OUTPUT, 'McGraw Hill', 1, 1, @CurrentTime;
EXEC PublishersInsert @PublisherId OUTPUT, 'Pearson Education', 1, 1, @CurrentTime;
EXEC PublishersInsert @PublisherId OUTPUT, 'Oxford University Press', 1, 1, @CurrentTime;

SELECT * from Publishers

CREATE PROCEDURE PublishersGetDetails
@PublisherId INT
/*
***********************************************************************************************
	Date   			Created By   		Purpose of Creation
1   27Mar2025	    Sayali Marathe		Get List from Publishers
***********************************************************************************************

PublishersGetDetails 1 

*/
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

EXEC PublishersGetDetails @PublisherId = 1;


CREATE PROCEDURE PublishersGetList
/*
***********************************************************************************************
	Date   			Created By   		Purpose of Creation
1	27Mar2025		Sayali Marathe		Get List for Publishers
***********************************************************************************************
PublishersGetList

*/
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
	WHERE IsActive=1
	ORDER BY PublisherName 

	
END

GO

EXEC PublishersGetList;

--Suppliers Table
CREATE TABLE Suppliers(
SupplierId INT PRIMARY KEY IDENTITY(1,1),
SupplierName VARCHAR(100) NOT NULL,
Contact VARCHAR(10),
IsActive BIT,
CreatedBy INT,
CreatedOn DATETIME,
ModifiedBy INT,
ModifiedOn DATETIME
)


CREATE PROCEDURE SuppliersInsert
@SupplierId INT OUTPUT,
@SupplierName VARCHAR(100),
@Contact VARCHAR(10),
@IsActive BIT,
@CreatedBy INT,
@CreatedOn DATETIME
/*
***********************************************************************************************
	Date   			Created By   	Purpose of Creation
1	27Mar2025		Sayali Marathe	Insert Suppliers
***********************************************************************************************
*/
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
SET @CurrentTime = GETDATE();
EXEC SuppliersInsert @SupplierId OUTPUT, 'Pankaj', '9876543210', 1, 1, @CurrentTime;
EXEC SuppliersInsert @SupplierId OUTPUT, 'Rakesh', '9123456780', 1, 1, @CurrentTime;
EXEC SuppliersInsert @SupplierId OUTPUT, 'India Books Co.', '9988776655', 1, 1, @CurrentTime;

SELECT * FROM Suppliers;

CREATE PROCEDURE SuppliersGetDetails
@SupplierId INT
/*
***********************************************************************************************
	Date   			Created By   		Purpose of Creation
1   27Mar2025	    Sayali Marathe		Get List from Suppliers
***********************************************************************************************

SuppliersGetDetails 1 

*/

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

EXEC SuppliersGetDetails @SupplierId = 1;


CREATE PROCEDURE SuppliersGetList
/*
***********************************************************************************************
	Date   			Created By   		Purpose of Creation
1	27Mar2025		Sayali Marathe		Get List for Suppliers
***********************************************************************************************
SuppliersGetList

*/
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
	WHERE IsActive=1
	ORDER BY SupplierName 
	
END

GO

EXEC SuppliersGetList
/*************************************************************************************************/
--Departments Table
CREATE TABLE Departments(
DepartmentId INT PRIMARY KEY IDENTITY(1,1),
DepartmentName VARCHAR(50) NOT NULL,
IsActive BIT,
CreatedBy INT,
CreatedOn DATETIME,
ModifiedBy INT,
ModifiedOn DATETIME
)


CREATE PROCEDURE DepartmentsInsert

@DepartmentId INT OUTPUT,
@DepartmentName VARCHAR (50),
@IsActive BIT,
@CreatedBy INT,
@CreatedOn DATETIME
/*
***********************************************************************************************
	Date   			Created By   	Purpose of Creation
1	27Mar2025		Sayali Marathe	Insert Departments
***********************************************************************************************
*/
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

DECLARE @DepartmentId INT;
DECLARE @CurrentTime DATETIME;
SET @CurrentTime = GETDATE();
EXEC DepartmentsInsert @DepartmentId OUTPUT, 'Computer Science', 1, 1, @CurrentTime;
EXEC DepartmentsInsert @DepartmentId OUTPUT, 'Electrical Engineering', 1, 1, @CurrentTime;
EXEC DepartmentsInsert @DepartmentId OUTPUT, 'Mechanical Engineering', 1, 1, @CurrentTime;
EXEC DepartmentsInsert @DepartmentId OUTPUT, 'Civil Engineering', 1, 1, @CurrentTime;
EXEC DepartmentsInsert @DepartmentId OUTPUT, 'Information Technology', 1, 1, @CurrentTime;

select * from Departments

CREATE PROCEDURE DepartmentsGetDetails
@DepartmentId INT
/*
***********************************************************************************************
	Date   			Created By   		Purpose of Creation
1   27Mar2025	    Sayali Marathe		Get List from Departments
***********************************************************************************************

DepartmentsGetDetails 1 

*/
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

EXEC DepartmentsGetDetails @DepartmentId = 1;

CREATE PROCEDURE DepartmentsGetList
/*
***********************************************************************************************
	Date   			Created By   		Purpose of Creation
1	27Mar2025		Sayali Marathe		Get List for Departments
***********************************************************************************************
DepartmentsGetList

*/
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
	WHERE IsActive=1
	ORDER BY DepartmentName 
END

GO

EXEC DepartmentsGetList

/*************************************************************************************************/
--Courses Table
CREATE TABLE Courses(
CourseId INT PRIMARY KEY IDENTITY(1,1),
CourseName VARCHAR(50) NOT NULL,
DepartmentId int FOREIGN key REFERENCES Departments(DepartmentId),
IsActive BIT,
CreatedBy INT,
CreatedOn DATETIME,
ModifiedBy INT,
ModifiedOn DATETIME
)


CREATE PROCEDURE CoursesInsert

@CourseId INT OUTPUT,
@CourseName VARCHAR (50),
@DepartmentId INT,
@IsActive BIT,
@CreatedBy INT,
@CreatedOn DATETIME
/*
***********************************************************************************************
	Date   			Created By   	Purpose of Creation
1	27Mar2025		Sayali Marathe	Insert Courses
***********************************************************************************************
*/
AS
BEGIN

	INSERT INTO Courses
	(
		CourseName,
		DepartmentId,
		IsActive,
		CreatedBy,
		CreatedOn
		
	)
	VALUES
	(
		@CourseName,
		@DepartmentId,
		@IsActive,
		@CreatedBy,
		@CreatedOn
	)

	SET @CourseId = @@IDENTITY;
END

GO

DECLARE @CourseId INT;
DECLARE @CurrentTime DATETIME;
SET @CurrentTime = GETDATE();
EXEC CoursesInsert @CourseId OUTPUT, 'Data Structures', 1, 1, 1, @CurrentTime;
EXEC CoursesInsert @CourseId OUTPUT, 'Operating Systems', 1, 1, 1, @CurrentTime;
EXEC CoursesInsert @CourseId OUTPUT, 'Circuit Theory', 2, 1, 1, @CurrentTime;
EXEC CoursesInsert @CourseId OUTPUT, 'Power Systems', 2, 1, 1, @CurrentTime;
EXEC CoursesInsert @CourseId OUTPUT, 'Thermodynamics', 3, 1, 1, @CurrentTime;
EXEC CoursesInsert @CourseId OUTPUT, 'Machine Design', 3, 1, 1, @CurrentTime;
EXEC CoursesInsert @CourseId OUTPUT, 'Structural Analysis', 4, 1, 1, @CurrentTime;
EXEC CoursesInsert @CourseId OUTPUT, 'Concrete Technology', 4, 1, 1, @CurrentTime;
EXEC CoursesInsert @CourseId OUTPUT, 'Web Development', 5, 1, 1, @CurrentTime;
EXEC CoursesInsert @CourseId OUTPUT, 'Cyber Security', 5, 1, 1, @CurrentTime;

select * from Courses

CREATE PROCEDURE CoursesGetDetails
@CourseId INT
/*
***********************************************************************************************
	Date   			Created By   		Purpose of Creation
1   27Mar2025	    Sayali Marathe		Get List from Courses
***********************************************************************************************

CoursesGetDetails 1 

*/
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

EXEC CoursesGetDetails @CourseId = 1;


CREATE PROCEDURE CoursesGetList
/*
***********************************************************************************************
	Date   			Created By   		Purpose of Creation
1	27Mar2025		Sayali Marathe		Get List for Courses
***********************************************************************************************
CoursesGetList

*/
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

	WHERE IsActive=1
	ORDER BY CourseName 
END

GO

EXEC CoursesGetList

/*************************************************************************************************/
--Books Table
CREATE TABLE Books
(
BookId INT PRIMARY KEY IDENTITY(1,1),
BookName VARCHAR (50),
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


CREATE PROCEDURE BooksInsert

@BookId INT OUTPUT,
@BookName VARCHAR (50),
@PublisherId INT,
@ISBN VARCHAR(10),
@TotalCopies INT,
@CourseId INT,
@SupplierId INT,
@IsActive BIT,
@CreatedBy INT,
@CreatedOn DATETIME
/*
***********************************************************************************************
	Date   			Created By   	Purpose of Creation
1	27Mar2025		Sayali Marathe	Insert Books
***********************************************************************************************
*/
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
DECLARE @BookId INT;
DECLARE @CurrentTime DATETIME;
SET @CurrentTime = GETDATE();
EXEC BooksInsert @BookId OUTPUT, 'Data Structures in C', 1, '4579657842', 10, 1, 1, 1, 1, @CurrentTime;
EXEC BooksInsert @BookId OUTPUT, 'Data Structures and Algorithms', 2, '4579657843', 8, 1, 2, 1, 1, @CurrentTime;
EXEC BooksInsert @BookId OUTPUT, 'Modern Operating Systems', 2, '4579657844', 9, 2, 3, 1, 1, @CurrentTime;
EXEC BooksInsert @BookId OUTPUT, 'Operating System Concepts', 3, '4579657845', 7, 2, 1, 1, 1, @CurrentTime;
EXEC BooksInsert @BookId OUTPUT, 'Fundamentals of Circuit Theory', 1, '4579657846', 5, 3, 2, 1, 1, @CurrentTime;
EXEC BooksInsert @BookId OUTPUT, 'Power System Analysis', 2, '4579657847', 6, 4, 3, 1, 1, @CurrentTime;
EXEC BooksInsert @BookId OUTPUT, 'Engineering Thermodynamics', 3, '4579657848', 12, 5, 1, 1, 1, @CurrentTime;
EXEC BooksInsert @BookId OUTPUT, 'Basic Thermodynamics', 1, '4579657849', 10, 5, 2, 1, 1, @CurrentTime;
EXEC BooksInsert @BookId OUTPUT, 'Machine Design Theory', 2, '4579657850', 11, 6, 3, 1, 1, @CurrentTime;
EXEC BooksInsert @BookId OUTPUT, 'Structural Analysis Vol 1', 3, '4579657851', 4, 7, 1, 1, 1, @CurrentTime;
EXEC BooksInsert @BookId OUTPUT, 'Structural Engineering Basics', 1, '4579657852', 6, 7, 2, 1, 1, @CurrentTime;
EXEC BooksInsert @BookId OUTPUT, 'Concrete Technology', 2, '4579657853', 6, 8, 3, 1, 1, @CurrentTime;
EXEC BooksInsert @BookId OUTPUT, 'Full Stack Web Dev', 3, '4579657854', 10, 9, 1, 1, 1, @CurrentTime;
EXEC BooksInsert @BookId OUTPUT, 'Frontend Web Development', 1, '4579657855', 9, 9, 2, 1, 1, @CurrentTime;
EXEC BooksInsert @BookId OUTPUT, 'Cyber Security Essentials', 2, '4579657856', 8, 10, 3, 1, 1, @CurrentTime;

select * from Books
select * from courses
CREATE PROCEDURE BooksUpdate

@BookId INT,
@BookName VARCHAR (50),
@PublisherId int,
@ISBN Varchar(10),
@TotalCopies int,
@CourseId int,
@SupplierId int,
@IsActive BIT,
@ModifiedBy INT,
@ModifiedOn DATETIME
/*
***********************************************************************************************
	Date   			Created By   		Purpose of Creation
1	27Mar2025		Sayali Marathe		Update from Books
***********************************************************************************************
*/
AS
BEGIN


	UPDATE
		Books
	SET
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

DECLARE @CurrentTime DATETIME;
SET @CurrentTime = GETDATE();
EXEC BooksUpdate 4,'Introduction to the Theory of Computation', 1, '5478145432',10,3,2,1,1,@CurrentTime  --Total Copies Changed
    
Select * from Books

CREATE PROCEDURE BooksDelete
@BookId INT,
@ModifiedBy INT,
@ModifiedOn DATETIME
/*
***********************************************************************************************
	Date   			Created By   		Purpose of Creation
1	27Mar2025		Sayali Marathe		Delete record from Books
***********************************************************************************************
BooksDelete 1

*/
AS
BEGIN

	UPDATE Books
	SET IsActive = 0,
	ModifiedBy = @ModifiedBy,
    ModifiedOn = @ModifiedOn
	WHERE
	BookId = @BookId
END

GO

DECLARE @CurrentTime DATETIME;
SET @CurrentTime = GETDATE();
EXEC BooksDelete 3,1,@CurrentTime  -- Soft Deleted Record of BookId=3
  
Select * from Books

CREATE PROCEDURE BooksGetDetails

@BookId INT
/*
***********************************************************************************************
	Date   			Created By   		Purpose of Creation
1	28Mar2025		Sayali Marathe		Get List from Books
***********************************************************************************************

BooksGetDetails 1 

*/
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

EXEC BooksGetDetails @BookId= 1;

drop procedure BooksGetList

CREATE PROCEDURE BooksGetList
    @SearchBookName NVARCHAR(100) = NULL,
    @PublisherId INT = NULL,
    @SupplierId INT = NULL,
    @CourseId INT = NULL,
    @PageNumber INT = 1,
    @PageSize INT = 10
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @TotalRecords INT;

    CREATE TABLE #TempBooks
    (
        RowNum INT IDENTITY(1,1),
        BookId INT,
        BookName NVARCHAR(100),
        PublisherName NVARCHAR(100),
        ISBN NVARCHAR(20),
        TotalCopies INT,
        CourseName NVARCHAR(100),
        SupplierName NVARCHAR(100),
        IsActive BIT
    );

    INSERT INTO #TempBooks (BookId, BookName, PublisherName, ISBN, TotalCopies, CourseName, SupplierName, IsActive)
    SELECT 
        b.BookId,
        b.BookName,
        p.PublisherName,
        b.ISBN,
        b.TotalCopies,
        c.CourseName,
        s.SupplierName,
        b.IsActive
    FROM Books b
    LEFT JOIN Publishers p ON b.PublisherId = p.PublisherId
    LEFT JOIN Suppliers s ON b.SupplierId = s.SupplierId
    LEFT JOIN Courses c ON b.CourseId = c.CourseId
    WHERE 
        (@SearchBookName IS NULL OR b.BookName LIKE '%' + @SearchBookName + '%') AND
        (@PublisherId IS NULL OR b.PublisherId = @PublisherId) AND
        (@SupplierId IS NULL OR b.SupplierId = @SupplierId) AND
        (@CourseId IS NULL OR b.CourseId = @CourseId);

    SELECT @TotalRecords = COUNT(*) FROM #TempBooks;

    SELECT 
        BookId,
        BookName,
        PublisherName,
        ISBN,
        TotalCopies,
        CourseName,
        SupplierName,
        IsActive,
        @TotalRecords AS TotalRecords
    FROM #TempBooks
    WHERE RowNum > (@PageNumber - 1) * @PageSize
      AND RowNum <= @PageNumber * @PageSize;

    DROP TABLE #TempBooks;
END

sp_helptext BooksGetList