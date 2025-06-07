
CREATE TABLE BookIssue (
    BookIssueId INT PRIMARY KEY IDENTITY(1,1),
    MemberId INT NOT NULL REFERENCES Members(MemberId),
    IssueDate DATE NOT NULL,
    DueDate DATE NOT NULL,
    ReturnDate DATE,
    LibrarianId INT NOT NULL REFERENCES Librarians(LibrarianId),
    IsActive BIT NOT NULL DEFAULT 1,
    CreatedBy INT,
    CreatedOn DATETIME,
    ModifiedBy INT,
    ModifiedOn DATETIME
);

CREATE PROCEDURE BookIssueGetList
    @PageNumber INT = 1,
    @PageSize INT = 10
	/*  
***********************************************************************************************  
 Date        Created By      Purpose of Creation  
1  31May2025  Sayali Marathe  Get List from BookIssue  
***********************************************************************************************  
BookIssueGetList 1  
*/  
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @TotalRecords INT;

    CREATE TABLE #TempIssues (
        RowNum INT IDENTITY(1,1),
        BookIssueId INT,
        MemberName NVARCHAR(100),
        IssueDate DATE,
        DueDate DATE,
        ReturnDate DATE,
        LibrarianName NVARCHAR(100),
        IsActive BIT
    );

    INSERT INTO #TempIssues (BookIssueId, MemberName, IssueDate, DueDate, ReturnDate, LibrarianName, IsActive)
    SELECT 
        i.BookIssueId,
        m.MemberName,
        i.IssueDate,
        i.DueDate,
        i.ReturnDate,
        l.LibrarianName,
        i.IsActive
    FROM BookIssue i
    LEFT JOIN Members m ON i.MemberId = m.MemberId
    LEFT JOIN Librarians l ON i.LibrarianId = l.LibrarianId
    WHERE i.IsActive = 1;

    SELECT @TotalRecords = COUNT(*) FROM #TempIssues;

    SELECT *, @TotalRecords AS TotalRecords
    FROM #TempIssues
    WHERE RowNum > (@PageNumber - 1) * @PageSize
      AND RowNum <= @PageNumber * @PageSize;

    DROP TABLE #TempIssues;
END

CREATE PROCEDURE BookIssueGetDetails  
@BookIssueId INT  
/*  
***********************************************************************************************  
 Date        Created By      Purpose of Creation  
1  26May2025  Sayali Marathe  Get details from BookIssue  
***********************************************************************************************  
BookIssueGetDetails 1  
*/  
AS  
BEGIN  
    SELECT  
        ISNULL(BookIssueId, '') AS BookIssueId,  
        ISNULL(MemberId, '') AS MemberId,  
        ISNULL(IssueDate, '') AS IssueDate,  
        ISNULL(DueDate, '') AS DueDate,  
        ISNULL(ReturnDate, '') AS ReturnDate,  
        ISNULL(LibrarianId, '') AS LibrarianId,  
        ISNULL(IsActive, '') AS IsActive,  
        ISNULL(CreatedBy, '') AS CreatedBy,  
        ISNULL(CreatedOn, '') AS CreatedOn,  
        ISNULL(ModifiedBy, '') AS ModifiedBy,  
        ISNULL(ModifiedOn, '') AS ModifiedOn  
    FROM BookIssue  
    WHERE BookIssueId = @BookIssueId  
END  


CREATE TABLE BookIssueDetails (
    BookIssueDetailId INT PRIMARY KEY IDENTITY(1,1),
    BookIssueId INT NOT NULL REFERENCES BookIssue(BookIssueId),
    BookId INT NOT NULL REFERENCES Books(BookId),
    Quantity INT NOT NULL DEFAULT 1,               
    IsActive BIT NOT NULL DEFAULT 1,
    CreatedBy INT,
    CreatedOn DATETIME,
    ModifiedBy INT,
    ModifiedOn DATETIME
);
CREATE PROCEDURE BookIssueDetailsGetByIssueId
    @BookIssueId INT
		/*  
***********************************************************************************************  
 Date        Created By      Purpose of Creation  
1  31May2025  Sayali Marathe  Get List from BookIssueDetails by IssueId 
***********************************************************************************************  
BookIssueDetailsGetByIssueId 1  
*/  
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
	    bid.BookIssueDetailId,
        bid.BookIssueId,
        bid.BookId,
        b.BookName,
        b.ISBN,
        p.PublisherName,
        c.CourseName,
        bid.Quantity
    FROM BookIssueDetails bid
    INNER JOIN Books b ON b.BookId = bid.BookId
    LEFT JOIN Publishers p ON p.PublisherId = b.PublisherId
    LEFT JOIN Courses c ON c.CourseId = b.CourseId
    WHERE bid.BookIssueId = @BookIssueId AND bid.IsActive = 1;
END


CREATE TYPE BookIssueDetailsType AS TABLE  
(  
    BookIssueDetailId INT,  
    BookIssueId INT,  
    BookId INT,  
    Quantity INT,  
    CreatedBy INT,  
    ModifiedBy INT  
)


CREATE PROCEDURE BookIssueUpsert    
    @BookIssueId INT OUTPUT,    
    @MemberId INT,    
    @LibrarianId INT,    
    @IssueDate DATE,    
    @DueDate DATE,    
    @CreatedBy INT,    
    @ModifiedBy INT,    
    @BookIssueDetails BookIssueDetailsType READONLY    
AS    
BEGIN    
    SET NOCOUNT ON;    
    BEGIN TRY    
        BEGIN TRANSACTION;

        -- Step 1: Insert or Update BookIssue
        IF @BookIssueId = 0    
        BEGIN    
            INSERT INTO BookIssue (MemberId, LibrarianId, IssueDate, DueDate,    
                                   IsActive, CreatedBy, CreatedOn)    
            VALUES (@MemberId, @LibrarianId, @IssueDate, @DueDate, 1, @CreatedBy, GETDATE());    

            SET @BookIssueId = SCOPE_IDENTITY();    
        END    
        ELSE    
        BEGIN    
            UPDATE BookIssue    
            SET MemberId = @MemberId,    
                LibrarianId = @LibrarianId,    
                IssueDate = @IssueDate,    
                DueDate = @DueDate,    
                ModifiedBy = @ModifiedBy,    
                ModifiedOn = GETDATE()    
            WHERE BookIssueId = @BookIssueId;    
        END

        -- Step 2: Load existing issued books to temp
        CREATE TABLE #TempExistingDetails (
            BookId INT,
            Quantity INT
        );

        INSERT INTO #TempExistingDetails (BookId, Quantity)
        SELECT BookId, Quantity
        FROM BookIssueDetails
        WHERE BookIssueId = @BookIssueId AND IsActive = 1;

        -- Step 3: Handle Deleted Books (present in old, not in new)
       UPDATE BookIssueDetails
		SET IsActive = 0,
			ModifiedOn = GETDATE(),    
			ModifiedBy = @ModifiedBy    
		WHERE BookIssueId = @BookIssueId
		  AND IsActive = 1
		  AND BookId NOT IN (SELECT BookId FROM @BookIssueDetails);


        -- Restore TotalCopies for deleted books
        UPDATE B
        SET B.TotalCopies = B.TotalCopies + E.Quantity,
            B.ModifiedBy = @ModifiedBy,
            B.ModifiedOn = GETDATE()
        FROM Books B
        INNER JOIN #TempExistingDetails E ON B.BookId = E.BookId
        WHERE E.BookId NOT IN (SELECT BookId FROM @BookIssueDetails);

        -- Step 4: Handle Quantity Changes (present in both, but quantity changed)
        UPDATE B
        SET B.TotalCopies = B.TotalCopies + (E.Quantity - N.Quantity),
            B.ModifiedBy = @ModifiedBy,
            B.ModifiedOn = GETDATE()
        FROM Books B
        INNER JOIN #TempExistingDetails E ON B.BookId = E.BookId
        INNER JOIN @BookIssueDetails N ON E.BookId = N.BookId
        WHERE E.Quantity <> N.Quantity;

        -- Update quantity in BookIssueDetails for changed books
        UPDATE BID
        SET Quantity = N.Quantity,
            ModifiedBy = @ModifiedBy,
            ModifiedOn = GETDATE()
        FROM BookIssueDetails BID
        INNER JOIN @BookIssueDetails N ON BID.BookIssueId = @BookIssueId AND BID.BookId = N.BookId
        INNER JOIN #TempExistingDetails E ON E.BookId = N.BookId
        WHERE E.Quantity <> N.Quantity AND BID.IsActive = 1;

        -- Step 5: Insert New Books (present in new, not in existing)
        INSERT INTO BookIssueDetails (
            BookIssueId, BookId, Quantity, IsActive,
            CreatedBy, CreatedOn
        )
        SELECT @BookIssueId, N.BookId, N.Quantity, 1,
               @CreatedBy, GETDATE()
        FROM @BookIssueDetails N
        WHERE N.BookId NOT IN (SELECT BookId FROM #TempExistingDetails);

        -- Subtract from Books.TotalCopies for new inserts
        UPDATE B
        SET B.TotalCopies = B.TotalCopies - N.Quantity,
            B.ModifiedBy = @ModifiedBy,
            B.ModifiedOn = GETDATE()
        FROM Books B
        INNER JOIN @BookIssueDetails N ON B.BookId = N.BookId
        WHERE N.BookId NOT IN (SELECT BookId FROM #TempExistingDetails);

        DROP TABLE #TempExistingDetails;

        COMMIT TRANSACTION;
    END TRY    
    BEGIN CATCH    
        ROLLBACK TRANSACTION;    
        THROW;    
    END CATCH    
END

select * from BookIssue
select * from BookIssueDetails
select * from Members
select * from Books
select * from BookIssueDocuments

sp_helptext BookIssueUpsert
DBCC CHECKIDENT ('BookIssueDetails', RESEED, 0);
sp_helptext BookIssueDetailsInsert
sp_help 'BookIssueDetailsType';
sp_helptext BooksGetDetails
EXEC BookIssueDetailsGetByIssueId @BookIssueId = 20
sp_helptext BookIssueGetList


CREATE TABLE BookIssueDocuments (
    DocumentId INT IDENTITY(1,1) PRIMARY KEY,
    BookIssueId INT NOT NULL,
    FileName NVARCHAR(255) NOT NULL,
    FilePath NVARCHAR(500) NOT NULL,
    ContentType NVARCHAR(100),
    IsActive BIT DEFAULT 1,
    UploadedBy INT,
    UploadedOn DATETIME DEFAULT GETDATE(),
    ModifiedBy INT NULL,
    ModifiedOn DATETIME NULL
);

CREATE PROCEDURE BookIssueDocumentsInsert
    @BookIssueId INT,
    @FileName NVARCHAR(255),
    @FilePath NVARCHAR(500),
    @ContentType NVARCHAR(100),
    @UploadedBy INT
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO BookIssueDocuments (
        BookIssueId,
        FileName,
        FilePath,
        ContentType,
        UploadedBy,
        UploadedOn,
        IsActive
    )
    VALUES (
        @BookIssueId,
        @FileName,
        @FilePath,
        @ContentType,
        @UploadedBy,
        GETDATE(),
        1
    );
END;

CREATE PROCEDURE BookIssueDocumentsGetList
    @BookIssueId INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        DocumentId,
        BookIssueId,
        FileName,
        FilePath,
        ContentType,
        UploadedBy,
        UploadedOn
    FROM 
        BookIssueDocuments
    WHERE 
        BookIssueId = @BookIssueId AND IsActive=1
    ORDER BY 
        UploadedOn DESC;
END

CREATE PROCEDURE BookIssueDocumentsDelete
    @DocumentId INT,
    @ModifiedBy INT
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE BookIssueDocuments
    SET IsActive = 0,
        ModifiedBy = @ModifiedBy,
        ModifiedOn = GETDATE()
    WHERE DocumentId = @DocumentId;
END

CREATE PROCEDURE BookIssueDocumentsGetById
    @DocumentId INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        DocumentId,
        BookIssueId,
        FileName,
        FilePath,
        ContentType
    FROM 
        BookIssueDocuments
    WHERE 
        DocumentId = @DocumentId
      AND IsActive = 1  
END
