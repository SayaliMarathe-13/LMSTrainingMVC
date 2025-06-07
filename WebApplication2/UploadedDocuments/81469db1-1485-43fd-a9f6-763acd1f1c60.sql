
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
SET @CurrentTime=getdate();
EXEC PublishersInsert @PublisherId OUTPUT,'MC Graw Hill',1, 1,@CurrentTime;

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
SET @CurrentTime=getdate();
EXEC SuppliersInsert @SupplierId OUTPUT,'Pankaj','7896547821', 1,1,@currentTime;

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
SET @CurrentTime=getdate();
EXEC DepartmentsInsert @DepartmentId OUTPUT,'Automobile',1, 1,@CurrentTime;

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
SET @CurrentTime=getdate();
EXEC CoursesInsert @CourseId OUTPUT,'Elements Of Electronics',4,1,1,@CurrentTime;

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
SET @CurrentTime=getdate();
EXEC BooksInsert @BookId OUTPUT,'Theory of Machines by R.S. Khurmi',2,'1245145432',3,4,1,1,1,@CurrentTime;

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
    @BookName NVARCHAR(100) = NULL,    
    @PublisherIds NVARCHAR(MAX) = NULL,    
    @SupplierIds NVARCHAR(MAX) = NULL,    
    @CourseIds NVARCHAR(MAX) = NULL,   
    @PageNumber INT = 1,    
    @PageSize INT = 10,
    @SortColumn NVARCHAR(50),
    @SortDirection NVARCHAR(4)
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

    DECLARE @Sql NVARCHAR(MAX) = '
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
        (@BookName IS NULL OR b.BookName LIKE ''%'' + @BookName + ''%'') AND
        (
            @PublisherIds IS NULL OR EXISTS (
                SELECT 1
                FROM STRING_SPLIT(@PublisherIds, '','')
                WHERE TRY_CAST(value AS INT) = b.PublisherId
            )
        ) AND
        (
            @SupplierIds IS NULL OR EXISTS (
                SELECT 1
                FROM STRING_SPLIT(@SupplierIds, '','')
                WHERE TRY_CAST(value AS INT) = b.SupplierId
            )
        ) AND
        (
            @CourseIds IS NULL OR EXISTS (
                SELECT 1 
                FROM STRING_SPLIT(@CourseIds, '','') 
                WHERE TRY_CAST(value AS INT) = b.CourseId
            )
        )
        AND b.IsActive = 1
    ORDER BY [' + @SortColumn + '] ' + @SortDirection;
	 
	EXEC sp_executesql @Sql,  
        N'@BookName NVARCHAR(100), @PublisherIds NVARCHAR(MAX), @SupplierIds NVARCHAR(MAX), @CourseIds NVARCHAR(MAX)',  
        @BookName = @BookName, @PublisherIds = @PublisherIds, @SupplierIds = @SupplierIds, @CourseIds = @CourseIds;  
  
    SELECT @TotalRecords = COUNT(*) FROM #TempBooks;

    SELECT *, @TotalRecords AS TotalRecords
    FROM #TempBooks
    WHERE RowNum > (@PageNumber - 1) * @PageSize  
      AND RowNum <= @PageNumber * @PageSize;  

    DROP TABLE #TempBooks;
END

select * from ErrorLogs

UPDATE Suppliers
SET SupplierName = 'Pearson Books Supplier'
WHERE SupplierId = 1;

UPDATE Suppliers
SET SupplierName = 'Delhi Book Store'
WHERE SupplierId = 2;

select * from books
DBCC CHECKIDENT ('Books', NORESEED);
DBCC CHECKIDENT ('Books', RESEED, 26);

DELETE FROM Books WHERE BookId = 1026;

select * from books
sp_helptext BooksInsert

CREATE TABLE ErrorLogs (
    ErrorLogId INT IDENTITY(1,1) PRIMARY KEY,     
    SourceMessage NVARCHAR(MAX) NOT NULL,   
    StackTrace NVARCHAR(MAX) NULL,           
    CreatedBy INT NOT NULL,                  
    CreatedOn DATETIME NOT NULL DEFAULT GETDATE() 
);

CREATE PROCEDURE ErrorLogsInsert  
@ErrorLogId INT OUTPUT,    
@SourceMessage NVARCHAR(MAX),  
@StackTrace NVARCHAR(MAX),  
@CreatedBy INT
/*  
***********************************************************************************************  
     Date             Created By          Purpose of Creation  
1    05-May-2025      Sayali Marathe      Insert Error Log into ErrorLogs table  
***********************************************************************************************  
*/  
AS  
BEGIN  

    INSERT INTO ErrorLogs  
    (    
        SourceMessage,  
        StackTrace,  
        CreatedBy,  
        CreatedOn  
    )  
    VALUES  
    (   
        @SourceMessage,  
        @StackTrace,  
        @CreatedBy,  
        GETDATE()
    )  

    SET @ErrorLogId = @@IDENTITY;  
END  

update Books
set IsActive=1
where BookId=8

select * from Courses

sp_helptext BooksGetList

--MemberTypes Table
CREATE TABLE MemberTypes (
   MemberTypeId INT IDENTITY(1,1) PRIMARY KEY,
   Type VARCHAR(50)
);
EXEC sp_rename 'MemberTypes.Type', 'MemberType', 'COLUMN';

CREATE PROCEDURE MemberTypesInsert  
@MemberTypeId INT OUTPUT,  
@MemberType VARCHAR(50)  
/*  
***********************************************************************************************  
 Date         Created By       Purpose of Creation  
19 May 2025   Sayali Marathe   Insert MemberTypes  
***********************************************************************************************  
*/  
AS  
BEGIN  
    INSERT INTO MemberTypes  
    (  
        MemberType 
    )  
    VALUES  
    (  
        @MemberType
    )  

    SET @MemberTypeId = @@IDENTITY;  
END  

DECLARE @MemberTypeId INT;
EXEC MemberTypesInsert @MemberTypeId OUTPUT, 'Student';
DECLARE @MemberTypeId INT;
EXEC MemberTypesInsert @MemberTypeId OUTPUT, 'Staff';

select * from MemberTypes

--Members Table
CREATE TABLE Members (
    MemberId INT PRIMARY KEY IDENTITY(1,1),
    MemberName VARCHAR(100) NOT NULL,
    Email VARCHAR(100) NOT NULL,
    DOB DATE NOT NULL,
    Contact VARCHAR(15) NOT NULL,
    DepartmentId INT FOREIGN KEY REFERENCES Departments(DepartmentId),
    MemberTypeId INT FOREIGN KEY REFERENCES MemberTypes(MemberTypeId),
    IsActive BIT NOT NULL,
    CreatedBy INT NOT NULL,
    CreatedOn DATETIME NOT NULL,
    ModifiedBy INT NULL,
    ModifiedOn DATETIME NULL
);

CREATE PROCEDURE MembersInsert  
    @MemberId INT OUTPUT,  
    @MemberName VARCHAR(100),  
    @Email VARCHAR(100),  
    @DOB DATE,  
    @Contact VARCHAR(15),  
    @DepartmentId INT,  
    @MemberTypeId INT,  
    @IsActive BIT,  
    @CreatedBy INT  
AS  
BEGIN  
    INSERT INTO Members (  
        MemberName,  
        Email,  
        DOB,  
        Contact,  
        DepartmentId,  
        MemberTypeId,  
        IsActive,  
        CreatedBy,  
        CreatedOn  
    )  
    VALUES (  
        @MemberName,  
        @Email,  
        @DOB,  
        @Contact,  
        @DepartmentId,  
        @MemberTypeId,  
        @IsActive,  
        @CreatedBy,  
        GETDATE()          
    );  
  
    SET @MemberId = @@IDENTITY;  
END  


DECLARE @MemberId INT; 
EXEC MembersInsert @MemberId OUTPUT, 'Sayali Marathe', 'sayalimarathe13@example.com', '2003-03-13', '9876543210', 1, 1, 1, 1; 
DECLARE @MemberId INT; 
EXEC MembersInsert @MemberId OUTPUT, 'Anushka Kuchakar', 'anushka.kuchakar@example.com', '1998-07-25', '9123456789', 2, 1, 1, 1;  
DECLARE @MemberId INT; 
EXEC MembersInsert @MemberId OUTPUT, 'Bhagyashree Shewale', 'bhagyashree.shewale@example.com', '1997-11-30', '9876501234', 1, 2, 1, 1;  
DECLARE @MemberId INT;
EXEC MembersInsert @MemberId OUTPUT, 'Anuja Bhatkar', 'anuja.bhatkar@example.com', '1985-01-15', '9988776655', 1, 1, 1, 1;  
DECLARE @MemberId INT; 
EXEC MembersInsert @MemberId OUTPUT, 'Rohit Patil', 'rohit.patil@example.com', '1995-06-10', '9012345678', 1, 1, 1, 1;



CREATE PROCEDURE MembersGetList  

/*  
***********************************************************************************************  
 Date      Created By     Purpose of Creation  
1 20 May 2025  Sayali Marathe  Get List for Members  
***********************************************************************************************  */
AS  
BEGIN  
    SELECT 
        m.MemberId,
        m.MemberName,
        m.Email,
        m.DOB,
        m.Contact,
        d.DepartmentName,
        mt.MemberType
    FROM 
        Members m
    INNER JOIN Departments d ON m.DepartmentId = d.DepartmentId
    INNER JOIN MemberTypes mt ON m.MemberTypeId = mt.MemberTypeId
    WHERE 
        m.IsActive = 1
    ORDER BY 
        m.MemberName;
END


CREATE TABLE Librarians (
    LibrarianId INT PRIMARY KEY IDENTITY(1,1),
    LibrarianName NVARCHAR(100) NOT NULL,
    Email NVARCHAR(100),
    Phone NVARCHAR(20),
    IsActive BIT NOT NULL DEFAULT 1,
    CreatedBy INT,
    CreatedOn DATETIME,
    ModifiedBy INT,
    ModifiedOn DATETIME
);

CREATE PROCEDURE LibrariansInsert  
    @LibrarianId INT OUTPUT,  
    @LibrarianName VARCHAR(100),  
    @Email VARCHAR(100),  
    @Phone VARCHAR(20),  
    @IsActive BIT,  
    @CreatedBy INT  
AS  
BEGIN  
    INSERT INTO Librarians (  
        LibrarianName,  
        Email,  
        Phone,  
        IsActive,  
        CreatedBy,  
        CreatedOn  
    )  
    VALUES (  
        @LibrarianName,  
        @Email,  
        @Phone,  
        @IsActive,  
        @CreatedBy,  
        GETDATE()          
    );  
  
    SET @LibrarianId = @@IDENTITY;  
END  

DECLARE @LibrarianId INT;
EXEC LibrariansInsert @LibrarianId OUTPUT,'Amit Sharma','amit.sharma@example.com','9876543210',1,1;

DECLARE @LibrarianId INT;
EXEC LibrariansInsert @LibrarianId OUTPUT,'Neha Verma','neha.verma@example.com','9123456780',1,1;
/*  
***********************************************************************************************  
 Date      Created By     Purpose of Creation  
1 27 May 2025  Sayali Marathe  Get List for Librarians  
***********************************************************************************************  */
CREATE PROCEDURE LibrariansGetList  
AS  
BEGIN  
    SELECT 
        LibrarianId,
        LibrarianName,
        Email,
        Phone
    FROM 
        Librarians
    WHERE 
        IsActive = 1
    ORDER BY 
        LibrarianName;
END


select * from ErrorLogs