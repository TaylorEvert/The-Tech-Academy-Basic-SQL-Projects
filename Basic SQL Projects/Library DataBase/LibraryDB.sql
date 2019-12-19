CREATE DATABASE LibraryDB;
USE LibraryDB;

/* PROCEDURES ------------------- LIBRARY DATABASE */

	EXEC dbo.lostTribeCopies;		/* How many copies of the book titled "The Lost Tribe" are owned by the library branch whose name is "Sharpstown"? */
	EXEC dbo.lostTribeBranch1234;	/* How many copies of the book titled "The Lost Tribe" are owned by each library branch? */
	EXEC dbo.noCheckedBooks;		/* All borrowers are checking out. Retrieve the names of all borrowers who do not have any books checked out. */
	EXEC dbo.dueDateSharptown;		/* For each book that is loaned out from the "Sharpstown" branch and whose DueDate is today, retrieve the book title, the borrower's name, and the borrower's address. */
	EXEC dbo.borrowerList5;			/* Retrieve the names, addresses, and the number of books checked out for all borrowers who have more than five books checked out. */
	EXEC dbo.stephenKingCopies		/* For each book authored (or co-authored) by "Stephen King", retrieve the title and the number of copies owned by the library branch whose name is "Central". */

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
		BookID INT PRIMARY KEY NOT NULL IDENTITY(100,1),
		Title VARCHAR(60) NOT NULL,
		PublisherName VARCHAR(50) NOT NULL CONSTRAINT fk_publisher_name FOREIGN KEY REFERENCES Publisher(PublisherName) ON UPDATE CASCADE ON DELETE CASCADE
	);


	CREATE TABLE Book_Authors (
		BookID INT NOT NULL CONSTRAINT fk_book_id FOREIGN KEY REFERENCES Books(BookID) ON UPDATE CASCADE ON DELETE CASCADE,
		AuthorName VARCHAR(50) NOT NULL
	);


	CREATE TABLE Book_Copies (
		BookID INT NOT NULL CONSTRAINT fk_bookid_copies FOREIGN KEY REFERENCES Books(BookID) ON UPDATE CASCADE ON DELETE CASCADE,
		BranchID INT NOT NULL CONSTRAINT fk_branch_id FOREIGN KEY REFERENCES Library_Branch(BranchID) ON UPDATE CASCADE ON DELETE CASCADE,
		Number_of_Copies INT NOT NULL
	);


	CREATE TABLE Borrower (
		CardNo INT PRIMARY KEY NOT NULL IDENTITY(200,1),
		BorrowerName VARCHAR(50) NOT NULL,
		BorrowerAddress VARCHAR(80) NOT NULL,
		BorrowerPhone VARCHAR(50) NOT NULL
	);

	
	CREATE TABLE Book_Loans (
		BookID INT NOT NULL CONSTRAINT fk_bookid_loan FOREIGN KEY REFERENCES Books(BookID) ON UPDATE CASCADE ON DELETE CASCADE,
		BranchID INT NOT NULL CONSTRAINT fk_branchID_loan FOREIGN KEY REFERENCES Library_Branch(BranchID) ON UPDATE CASCADE ON DELETE CASCADE,
		CardNo INT NOT NULL CONSTRAINT fk_cardno_loan FOREIGN KEY REFERENCES Borrower(CardNo) ON UPDATE CASCADE ON DELETE CASCADE,
		DateOut VARCHAR(50) NOT NULL,
		DateDue VARCHAR(50) NOT NULL
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
			('105','Stephen King'),
			('106','Stephen King'),
			('107','JK Rowling'),
			('108','JK Rowling'),
			('109','Mark Twain'),
			('110','Mark Twain'),
			('111','Micheal Lewis'),
			('112','Michael Lewis'),
			('113','Veronica Roth'),
			('114','Veronica Roth'),
			('115','John Updike'),
			('116','John Updike'),
			('117','"Lev Grossman'),
			('118','Lev Grossman'),
			('119','Zadie Smith'),
			('120','Zadie Smith'),
			('121','Joyce Oats'),
			('122','Joyce Oats'),
			('123','Edward Marriott'),
			('124','Edward Marriott')
		;


	INSERT INTO Books
		(Title, PublisherName)
		VALUES
			('It','The Cut'),
			('The Shining','Boston Globe'),
			('Lethal White','Forbes'),
			('Carrer of Evil','Boston Globe'),
			('What is man?','The Cut'),
			('Roughin It','Forbes'),
			('Money Ball','The Cut'),
			('The Blind Side','Forbes'),
			('Divergent','The Cut'),
			('Insurgent','Boston Globe'),
			('Rabbit at Rest','The Cut'),
			('A&P','The Cut'),
			('Magicians Trilogy','Boston Globe'),
			('The Magician King','Forbes'),
			('White Teeth','Boston Globe'),
			('Swing Time','Boston Globe'),
			('Blonde','The Cut'),
			('The Falls','The Cut'),
			('The Lost Tribe','Boston Globe'),
			('The Plague Race','Boston Globe')
		;


		INSERT INTO  Book_Copies
			(BookID,BranchID,Number_of_Copies)
			VALUES
			('105','1',2),
			('105','2',2),
			('105','3',3),
			('105','4',3),
			('106','1',2),
			('106','2',2),
			('106','3',3),
			('106','4',3),
			('107','1',2),
			('107','2',2),
			('107','3',3),
			('107','4',3),
			('108','1',2),
			('108','2',2),
			('108','3',3),
			('108','4',3),
			('109','1',2),
			('109','2',2),
			('109','3',3),
			('109','4',3),
			('110','1',3),
			('110','2',2),
			('110','3',5),
			('110','4',2),
			('111','1',3),
			('111','2',2),
			('111','3',5),
			('111','4',2),
			('112','1',3),
			('112','2',2),
			('112','3',5),
			('112','4',2),
			('113','1',3),
			('113','2',2),
			('113','3',5),
			('113','4',2),
			('114','1',3),
			('114','2',2),
			('114','3',5),
			('114','4',2),
			('115','1',3),
			('115','2',2),
			('115','3',5),
			('115','4',2),
			('116','1',2),
			('116','2',3),
			('116','3',3),
			('116','4',2),
			('117','1',2),
			('117','2',3),
			('117','3',3),
			('117','4',2),
			('118','1',2),
			('118','2',3),
			('118','3',3),
			('118','4',2),
			('119','1',2),
			('119','2',3),
			('119','3',3),
			('119','4',2),
			('120','1',2),
			('120','2',3),
			('120','3',3),
			('120','4',2),
			('121','1',3),
			('121','2',2),
			('121','3',3),
			('121','4',2),
			('122','1',3),
			('122','2',2),
			('122','3',3),
			('122','4',2),
			('123','1',3),
			('123','2',2),
			('123','3',3),
			('123','4',2),
			('124','1',3),
			('124','2',2),
			('124','3',3),
			('124','4',2)
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
		(BookID,BranchID,CardNo,DateOut,DateDue)
		VALUES
			('105','1','200','12/19/19','1/5/20'),
			('106','1','200','12/18/19','1/4/20'),
			('111','1','200','12/5/19','12/30/19'),
			('116','2','200','11/15/19','12/5/19'),
			('105','3','201','10/15/19','11/25/19'),
			('120','3','201','9/9/19','10/10/19'),
			('117','4','201','9/9/19','10/10/19'),
			('120','1','201','8/12/19','9/12/19'),
			('124','2','201','8/12/19','9/12/19'),
			('123','2','202','8/8/19','9/12/19'),
			('120','4','202','8/10/19','9/12/19'),
			('105','2','202','7/18/19','8/19/19'),
			('112','1','202','7/16/19','8/16/19'),
			('121','4','202','8/19/19','9/19/19'),
			('122','3','202','8/19/19','9/19/19'),
			('105','1','204','12/19/19','1/5/20'),
			('106','1','204','12/18/19','1/4/20'),
			('111','1','204','12/5/19','12/30/19'),
			('116','2','204','11/15/19','12/5/19'),
			('105','3','204','10/15/19','11/25/19'),
			('120','3','204','7/9/19','10/10/19'),
			('117','4','203','6/9/19','10/10/19'),
			('120','1','203','8/12/19','9/12/19'),
			('124','2','203','8/12/19','9/12/19'),
			('123','2','203','8/8/19','9/12/19'),
			('120','4','203','8/10/19','9/12/19'),
			('105','2','203','7/18/19','8/19/19'),
			('112','1','202','7/16/19','8/16/19'),
			('121','4','202','8/19/19','9/19/19'),
			('122','3','202','8/19/19','9/19/19'),
			('105','1','206','12/19/19','1/5/20'),
			('106','1','206','12/18/19','1/4/20'),
			('111','1','206','12/5/19','12/30/19'),
			('116','2','206','11/15/19','12/5/19'),
			('105','3','207','10/15/19','11/25/19'),
			('120','3','207','9/9/19','10/10/19'),
			('117','4','207','9/9/19','10/10/19'),
			('120','1','207','8/12/19','9/12/19'),
			('124','2','207','8/12/19','9/12/19'),
			('123','2','205','8/8/19','9/12/19'),
			('120','4','205','8/10/19','9/12/19'),
			('105','2','205','7/18/19','8/19/19'),
			('112','1','205','7/16/19','8/16/19'),
			('121','4','205','8/19/19','9/19/19'),
			('122','3','204','8/19/19','9/19/19'),
			('123','1','200','4/15/19,','5/15/19'),
			('122','3','202','8/19/19','9/19/19'),
			('105','1','204','12/19/19','1/5/20'),
			('106','1','204','12/18/19','1/4/20'),
			('111','1','204','12/5/19','12/30/19'),
			('116','2','204','11/15/19','12/5/19'),
			('123','2','205','8/8/19','9/12/19'),
			('120','4','205','8/10/19','9/12/19')
		;


		/* END INSERT ----------- LIBRARY DATABASE */	