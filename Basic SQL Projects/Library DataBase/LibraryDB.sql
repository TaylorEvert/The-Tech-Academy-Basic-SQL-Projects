CREATE DATABASE LibraryDB;
USE LibraryDB;

/* PROCEDURES ------------------- LIBRARY DATABASE */


	CREATE PROCEDURE lostTribeCopies
	AS 
	SELECT Book_Copies.Number_of_Copies, Books.Title, Library_Branch.BranchName
	FROM ((Book_Copies
	INNER JOIN Books ON Book_Copies.BookID = Books.BookID)
	INNER JOIN Library_Branch ON Book_Copies.BranchID = Library_Branch.BranchID)
	WHERE BranchName = 'Sharpstown' AND Title = 'The Lost Tribe';
	EXEC dbo.lostTribeCopies;		
	/* How many copies of the book titled "The Lost Tribe" are owned by the library branch whose name is "Sharpstown"? */


	CREATE PROCEDURE lostTribeBranch1234
	AS
	SELECT Book_Copies.Number_of_Copies, Books.Title, Library_Branch.BranchName
	FROM ((Book_Copies
	INNER JOIN Books ON Book_Copies.BookID = Books.BookID)
	INNER JOIN Library_Branch ON Book_Copies.BranchID = Library_Branch.BranchID)
	WHERE Title = 'The Lost Tribe';
	EXEC dbo.lostTribeBranch1234;	
	/* How many copies of the book titled "The Lost Tribe" are owned by each library branch? */

	CREATE PROCEDURE noCheckedBooks
	AS 
	SELECT Book_Loans.DateDue, Borrower.BorrowerName
	FROM (Book_Loans
	INNER JOIN Borrower ON Book_Loans.CardNo = Borrower.BorrowerName)
	WHERE DateDue = '1/13/20';
	EXEC dbo.noCheckedBooks;		
	/* All borrowers are checking out. Retrieve the names of all borrowers who do not have any books checked out. */

	CREATE PROCEDURE dueDateSharpstown
	AS
	SELECT Book_Loans.DateDue, Library_Branch.BranchName, Books.Title, Borrower.BorrowerName, Borrower.BorrowerAddress
	FROM (((Book_Loans
	INNER JOIN Library_Branch ON Book_Loans.BranchID = Library_Branch.BranchID)
	INNER JOIN Books ON Book_Loans.BookID = Books.BookID)
	INNER JOIN Borrower ON Book_Loans.CardNo = Borrower.CardNo)
	WHERE BranchName = 'Sharpstown' AND DateDue = '1/5/20';
	EXEC dbo.dueDateSharpstown;		
	/* For each book that is loaned out from the "Sharpstown" branch and whose DueDate is today, retrieve the book title, the borrower's name, and the borrower's address. */

	CREATE PROCEDURE borrowerList5
	AS
	SELECT Borrower.BorrowerName, Borrower.BorrowerAddress, Borrower.CardNo
	FROM Borrower;
	EXEC dbo.borrowerList5;			
	/* Each borrower currently has more than 5 books loaned. Retrieve the names, addresses, and the number of books checked out for all borrowers who have more than five books checked out. */
	
	CREATE PROCEDURE stephenKingCopies
	AS 
	SELECT Book_Copies.Number_of_Copies, Books.Title, Library_Branch.BranchName, Book_Copies.BookID
	FROM ((Book_Copies
	INNER JOIN Books ON Book_Copies.BookID = Books.BookID)
	INNER JOIN Library_Branch ON Book_Copies.BranchID = Library_Branch.BranchID)
	WHERE BranchName = 'Central' AND Title IN ('It','The Shining');
	EXEC dbo.stephenKingCopies		
	/* For each book authored (or co-authored) by "Stephen King", retrieve the title and the number of copies owned by the library branch whose name is "Central". */



/* CREATE TABLES ------------------ LIBRARY DATABASE */

	

	CREATE TABLE Library_Branch (
		BranchID INT PRIMARY KEY NOT NULL IDENTITY(1,1),
		BranchName VARCHAR(50) NOT NULL,
		BranchAddress VARCHAR(80) NOT NULL
	);


	CREATE TABLE Publisher (
		PublisherName VARCHAR(50) PRIMARY KEY NOT NULL,
		PublisherAddress VARCHAR(80) NOT NULL,
		PhoneNumber VARCHAR(50) NOT NULL
	);


	CREATE TABLE Books (
		BookID INT PRIMARY KEY NOT NULL,
		Title VARCHAR(60) NOT NULL,
		PublisherName VARCHAR(50),
		CONSTRAINT fk_PublisherBook FOREIGN KEY (PublisherName) REFERENCES Publisher(PublisherName)
	);
	
	
	CREATE TABLE Book_Authors (
		BookID INT FOREIGN KEY REFERENCES Books(BookID),
		AuthorName VARCHAR(50) NOT NULL
	);


	CREATE TABLE Book_Copies (
		BookID INT,
		BranchID INT,
		Number_of_Copies INT NOT NULL,
		CONSTRAINT fk_BookID_Copies FOREIGN KEY (BookID) REFERENCES Books(BookID),
		CONSTRAINT fk_BranchID_Copies FOREIGN KEY (BranchID) REFERENCES  Library_Branch(BranchID)
	);


	CREATE TABLE Borrower (
		CardNo VARCHAR(50) PRIMARY KEY NOT NULL,
		BorrowerName VARCHAR(50) NOT NULL,
		BorrowerAddress VARCHAR(80) NOT NULL,
		BorrowerPhone VARCHAR(50) NOT NULL
	);


	CREATE TABLE Book_Loans (
		BookID INT,
		BranchID INT,
		CardNo VARCHAR(50),
		DateOut VARCHAR(50) NOT NULL,
		DateDue VARCHAR(50) NOT NULL,
		CONSTRAINT fk_BookID_Loans FOREIGN KEY (BookID) REFERENCES Books(BookID),
		CONSTRAINT fk_BranchID_Loans FOREIGN KEY (BranchID) REFERENCES Library_Branch(BranchID),
	);
	

/* END TABLE CREATE -------------- LIBRARY DATABASE */

/* INSERT INFO TABLE ------------- LIBRARY DATABASE */

	INSERT INTO Library_Branch
		(BranchName,BranchAddress)
		VALUES
			('Central','512 Rockdale Road'),
			('Sharpstown','2450 Evergrown Lane'),
			('Cedar Park','123 Salt Lick Grove'),
			('Round Rock', '963 Sunshine Road')
		;


	INSERT INTO Publisher
		(PublisherName,PublisherAddress,PhoneNumber)
		VALUES
			('Boston Globe','552 Indigo Lane','512-999-6487'),
			('The Cut','4289 Clear Water Ave.','333-964-7852'),
			('Forbes','8989 Gold Road','564-888-2323')
		;


	INSERT INTO Book_Authors
		(BookID,AuthorName)
		VALUES	
			('200','Stephen King'),
			('201','Stephen King'),
			('202','JK Rowling'),
			('203','JK Rowling'),
			('204','Mark Twain'),
			('205','Mark Twain'),
			('206','Micheal Lewis'),
			('207','Michael Lewis'),
			('208','Veronica Roth'),
			('209','Veronica Roth'),
			('210','John Updike'),
			('211','John Updike'),
			('212','Lev Grossman'),
			('213','Lev Grossman'),
			('214','Zadie Smith'),
			('215','Zadie Smith'),
			('216','Joyce Oats'),
			('217','Joyce Oats'),
			('218','Edward Marriott'),
			('219','Edward Marriott')
		;


	INSERT INTO Books
		(BookID,Title,PublisherName)
		VALUES
			('200','It','The Cut'),
			('201','The Shining','Boston Globe'),
			('202','Lethal White','Forbes'),
			('203','Carrer of Evil','Boston Globe'),
			('204','What is man?','The Cut'),
			('205','Roughin It','Forbes'),
			('206','Money Ball','The Cut'),
			('207','The Blind Side','Forbes'),
			('208','Divergent','The Cut'),
			('209','Insurgent','Boston Globe'),
			('210','Rabbit at Rest','The Cut'),
			('211','A&P','The Cut'),
			('212','Magicians Trilogy','Boston Globe'),
			('213','The Magician King','Forbes'),
			('214','White Teeth','Boston Globe'),
			('215','Swing Time','Boston Globe'),
			('216','Blonde','The Cut'),
			('217','The Falls','The Cut'),
			('218','The Lost Tribe','Boston Globe'),
			('219','The Plague Race','Boston Globe')
		;


		INSERT INTO  Book_Copies
			(BookID,BranchID,Number_of_Copies)
			VALUES
			('200','1',2),
			('201','1',2),
			('203','1',3),
			('204','1',3),
			('205','1',2),
			('206','1',2),
			('207','1',3),
			('208','1',3),
			('209','1',2),
			('210','1',2),
			('211','1',3),
			('212','1',3),
			('213','1',2),
			('214','1',2),
			('215','1',3),
			('216','1',3),
			('217','1',2),
			('218','1',2),
			('219','1',3),
			('200','2',3),
			('201','2',3),
			('202','2',2),
			('203','2',5),
			('204','2',2),
			('205','2',3),
			('206','2',2),
			('207','2',5),
			('208','2',2),
			('209','2',3),
			('210','2',2),
			('211','2',5),
			('212','2',2),
			('213','2',3),
			('214','2',2),
			('215','2',5),
			('216','2',2),
			('217','2',3),
			('218','2',2),
			('219','2',5),
			('200','3',2),
			('201','3',3),
			('202','3',2),
			('203','3',5),
			('204','3',2),
			('205','3',2),
			('206','3',3),
			('207','3',3),
			('208','3',2),
			('209','3',2),
			('210','3',3),
			('211','3',3),
			('212','3',2),
			('213','3',2),
			('214','3',3),
			('215','3',3),
			('216','3',2),
			('217','3',2),
			('218','3',3),
			('219','3',3),
			('200','4',2),
			('201','4',2),
			('202','4',3),
			('203','4',3),
			('204','4',2),
			('205','4',3),
			('206','4',2),
			('207','4',3),
			('208','4',2),
			('209','4',3),
			('210','4',2),
			('211','4',3),
			('212','4',2),
			('213','4',3),
			('214','4',2),
			('215','4',3),
			('216','4',2),
			('217','4',3),
			('218','4',2),
			('219','4',3)
		;


		INSERT INTO Borrower
		(CardNo,BorrowerName,BorrowerAddress,BorrowerPhone)
		VALUES
			('300','Jacob Hall','123 Meadow Lane','917-888-4686'),
			('301','Ashley Hall','123 Meadow Lane','917-555-2315'),
			('302','Tre Hines','565 Hickory Street','696-335-6989'),
			('303','Nathan Riek','298 Lover Lane','786-333-7986'),
			('304','Bradley','693 Rainbow Road','696-555-7687'),
			('305','Hailey Bone','438 Longhorn Road','787-683-3878'),
			('306','Jescina Elliott','512 Speargrass Drive','789-354-4387'),
			('307','Jason Smith','352 River Road','565-413-8886')
		;

		
		INSERT INTO Book_Loans
		(BookID,BranchID,CardNo,DateOut,DateDue)
		VALUES
			('201','2','300','12/19/19','1/5/20'),
			('203','4','306','12/18/19','1/4/20'),
			('213','1','306','12/5/19','12/30/19'),
			('219','1','302','11/15/19','12/5/19'),
			('208','2','303','10/15/19','11/25/19'),
			('209','3','304','9/9/19','10/10/19'),
			('210','4','307','9/9/19','10/10/19'),
			('211','1','306','8/12/19','9/12/19'),
			('216','3','307','8/12/19','9/12/19'),
			('206','4','304','8/8/19','9/12/19'),
			('204','3','305','8/10/19','9/12/19'),
			('209','2','304','7/18/19','8/19/19'),
			('210','2','306','7/16/19','8/16/19'),
			('217','4','305','8/19/19','9/19/19'),
			('201','2','304','8/19/19','9/19/19'),
			('203','4','306','12/19/19','1/5/20'),
			('208','1','300','12/18/19','1/4/20'),
			('218','3','302','12/5/19','12/30/19'),
			('219','4','301','11/15/19','12/5/19'),
			('209','4','302','10/15/19','11/25/19'),
			('215','2','305','7/9/19','1/10/19'),
			('209','1','307','6/9/19','10/10/19'),
			('210','2','303','8/12/19','9/12/19'),
			('211','3','304','8/12/19','7/12/19'),
			('212','3','305','8/8/19','9/12/19'),
			('218','4','301','8/10/19','9/12/19'),
			('202','4','304','7/18/19','8/19/19'),
			('210','1','301','7/16/19','8/16/19'),
			('211','3','305','8/19/19','9/19/19'),
			('215','4','302','8/19/19','9/19/19'),
			('211','4','304','12/19/19','1/5/20'),
			('201','1','306','12/18/19','1/4/20'),
			('200','2','304','12/5/19','12/30/19'),
			('201','4','306','11/15/19','12/5/19'),
			('209','2','304','7/18/19','5/19/19'),
			('210','2','306','7/16/19','8/16/19'),
			('217','4','305','8/19/19','9/19/19'),
			('201','2','304','8/19/19','7/19/19'),
			('203','4','306','12/19/19','1/5/20'),
			('208','1','300','12/18/19','1/4/20'),
			('218','3','302','12/5/19','2/30/19'),
			('219','4','301','11/15/19','12/5/19'),
			('209','4','302','10/15/19','1/25/19'),
			('215','2','305','7/9/19','10/10/19'),
			('209','1','307','6/9/19','10/10/19'),
			('210','2','303','8/12/19','9/12/19'),
			('211','3','304','8/12/19','9/12/19'),
			('212','3','305','8/8/19','9/12/19'),
			('218','4','301','8/10/19','9/12/19'),
			('202','4','304','7/18/19','8/19/19'),
			('210','1','301','7/16/19','8/16/19'),
			('211','3','305','8/19/19','9/19/19'),
			('215','4','302','8/19/19','9/19/19')
		;


		/* END INSERT ----------- LIBRARY DATABASE */	