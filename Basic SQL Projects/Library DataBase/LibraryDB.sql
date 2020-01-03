CREATE DATABASE LibraryDB;
USE LibraryDB;

/* PROCEDURES ------------------- LIBRARY DATABASE */


	CREATE PROCEDURE lostTribeCopies
	AS 
	SELECT Number_of_Copies,Title,BranchName FROM Book_Copies,Books,Library_Branch WHERE Title='The Lost Tribe' AND BranchName='Sharpstown';
	EXEC dbo.lostTribeCopies;		
	/* How many copies of the book titled "The Lost Tribe" are owned by the library branch whose name is "Sharpstown"? */

	CREATE PROCEDURE lostTribeBranch1234
	AS
	SELECT BranchName,Title,Number_of_Copies FROM Library_Branch,Books,Book_Copies WHERE Title='The Lost Tribe';
	EXEC dbo.lostTribeBranch1234;	
	/* How many copies of the book titled "The Lost Tribe" are owned by each library branch? */

	CREATE PROCEDURE noCheckedBooks
	AS 
	SELECT BorrowerName,DateDue FROM Borrower,Book_Loans WHERE DateDue='12/31/19';
	EXEC dbo.noCheckedBooks;		
	/* All borrowers are checking out. Retrieve the names of all borrowers who do not have any books checked out. */

	CREATE PROCEDURE dueDateSharpstown
	AS
	SELECT BranchName,DateDue,Title,BorrowerName,BorrowerAddress FROM Library_Branch,Book_Loans,Books,Borrower WHERE BranchName='Sharpstown' AND DateDue='12/30/19';
	EXEC dbo.dueDateSharpstown;		
	/* For each book that is loaned out from the "Sharpstown" branch and whose DueDate is today, retrieve the book title, the borrower's name, and the borrower's address. */

	CREATE PROCEDURE borrowerList5
	AS
	SELECT BorrowerName,BorrowerAddress,CardNo FROM Borrower WHERE CardNo < 206 AND CardNo > 200;
	EXEC dbo.borrowerList5;			
	/* Retrieve the names, addresses, and the number of books checked out for all borrowers who have more than five books checked out. */
	
	CREATE PROCEDURE stephenKingCopies
	AS 
	SELECT Title,Number_of_Copies,AuthorName,BranchName FROM Library_Branch,Publisher,Books,Book_Copies,Book_Authors WHERE BranchName='Central'AND AuthorName='Stephen King';
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
		BookID INT,
		AuthorName VARCHAR(50) NOT NULL,
		CONSTRAINT fk_BookID_Authors FOREIGN KEY (BookID) REFERENCES Books(BookID)
	);


	CREATE TABLE Book_Copies (
		BookID INT,
		BranchID INT,
		Number_of_Copies INT NOT NULL,
		CONSTRAINT fk_BookID_Copies FOREIGN KEY (BookID) REFERENCES Books(BookID),
		CONSTRAINT fk_BranchID_Copies FOREIGN KEY (BranchID) REFERENCES  Library_Branch(BranchID)
	);


	CREATE TABLE Borrower (
		CardNo INT PRIMARY KEY NOT NULL IDENTITY(200,1),
		BorrowerName VARCHAR(50) NOT NULL,
		BorrowerAddress VARCHAR(80) NOT NULL,
		BorrowerPhone VARCHAR(50) NOT NULL
	);

	
	CREATE TABLE Book_Loans (
		BookID INT,
		BranchID INT,
		CardNo INT,
		DateOut VARCHAR(50) NOT NULL,
		DateDue VARCHAR(50) NOT NULL,
		CONSTRAINT fk_BookID_Loans FOREIGN KEY (BookID) REFERENCES Books(BookID),
		CONSTRAINT fk_BranchID_Loans FOREIGN KEY (BranchID) REFERENCES Library_Branch(BranchID),
		CONSTRAINT fk_CardNo_Loans FOREIGN KEY (CardNo) REFERENCES Borrower(CardNo)
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
		(AuthorName)
		VALUES	
			('Stephen King'),
			('Stephen King'),
			('JK Rowling'),
			('JK Rowling'),
			('Mark Twain'),
			('Mark Twain'),
			('Micheal Lewis'),
			('Michael Lewis'),
			('Veronica Roth'),
			('Veronica Roth'),
			('John Updike'),
			('John Updike'),
			('Lev Grossman'),
			('Lev Grossman'),
			('Zadie Smith'),
			('Zadie Smith'),
			('Joyce Oats'),
			('Joyce Oats'),
			('Edward Marriott'),
			('Edward Marriott')
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
			(Number_of_Copies)
			VALUES
			(2),
			(2),
			(3),
			(3),
			(2),
			(2),
			(3),
			(3),
			(2),
			(2),
			(3),
			(3),
			(2),
			(2),
			(3),
			(3),
			(2),
			(2),
			(3),
			(3),
			(3),
			(2),
			(5),
			(2),
			(3),
			(2),
			(5),
			(2),
			(3),
			(2),
			(5),
			(2),
			(3),
			(2),
			(5),
			(2),
			(3),
			(2),
			(5),
			(2),
			(3),
			(2),
			(5),
			(2),
			(2),
			(3),
			(3),
			(2),
			(2),
			(3),
			(3),
			(2),
			(2),
			(3),
			(3),
			(2),
			(2),
			(3),
			(3),
			(2),
			(2),
			(3),
			(3),
			(2),
			(3),
			(2),
			(3),
			(2),
			(3),
			(2),
			(3),
			(2),
			(3),
			(2),
			(3),
			(2),
			(3),
			(2),
			(3),
			(2)
		;


		INSERT INTO Borrower
		(BorrowerName,BorrowerAddress,BorrowerPhone)
		VALUES
			('Jacob Hall','123 Meadow Lane','917-888-4686'),
			('Ashley Hall','123 Meadow Lane','917-555-2315'),
			('Tre Hines','565 Hickory Street','696-335-6989'),
			('Nathan Riek','298 Lover Lane','786-333-7986'),
			('Bradley','693 Rainbow Road','696-555-7687'),
			('Hailey Bone','438 Longhorn Road','787-683-3878'),
			('Jescina Elliott','512 Speargrass Drive','789-354-4387'),
			('Jason Smith','352 River Road','565-413-8886')
		;

		
		INSERT INTO Book_Loans
		(DateOut,DateDue)
		VALUES
			('12/19/19','1/5/20'),
			('12/18/19','1/4/20'),
			('12/5/19','12/30/19'),
			('11/15/19','12/5/19'),
			('10/15/19','11/25/19'),
			('9/9/19','10/10/19'),
			('9/9/19','10/10/19'),
			('8/12/19','9/12/19'),
			('8/12/19','9/12/19'),
			('8/8/19','9/12/19'),
			('8/10/19','9/12/19'),
			('7/18/19','8/19/19'),
			('7/16/19','8/16/19'),
			('8/19/19','9/19/19'),
			('8/19/19','9/19/19'),
			('12/19/19','1/5/20'),
			('12/18/19','1/4/20'),
			('12/5/19','12/30/19'),
			('11/15/19','12/5/19'),
			('10/15/19','11/25/19'),
			('7/9/19','10/10/19'),
			('6/9/19','10/10/19'),
			('8/12/19','9/12/19'),
			('8/12/19','9/12/19'),
			('8/8/19','9/12/19'),
			('8/10/19','9/12/19'),
			('7/18/19','8/19/19'),
			('7/16/19','8/16/19'),
			('8/19/19','9/19/19'),
			('8/19/19','9/19/19'),
			('12/19/19','1/5/20'),
			('12/18/19','1/4/20'),
			('12/5/19','12/30/19'),
			('11/15/19','12/5/19'),
			('10/15/19','11/25/19'),
			('9/9/19','10/10/19'),
			('1/9/19','10/10/19'),
			('8/12/19','9/12/19'),
			('8/12/19','9/12/19'),
			('8/8/19','9/12/19'),
			('8/10/19','9/12/19'),
			('7/18/19','8/19/19'),
			('7/16/19','8/16/19'),
			('8/19/19','9/19/19'),
			('8/19/19','9/19/19'),
			('4/15/19,','5/15/19'),
			('8/19/19','9/19/19'),
			('12/19/19','1/5/20'),
			('12/18/19','1/4/20'),
			('12/5/19','12/30/19'),
			('11/15/19','12/5/19'),
			('8/8/19','9/12/19'),
			('8/10/19','9/12/19')
		;


		/* END INSERT ----------- LIBRARY DATABASE */	