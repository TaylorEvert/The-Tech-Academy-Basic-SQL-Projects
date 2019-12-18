CREATE DATABASE drill7;
USE drill7;

/* CREATE TABLES */

CREATE TABLE tbl_People (
	PeopleID INT PRIMARY KEY NOT NULL IDENTITY(1,1), 
	FirstName VARCHAR(100),
	LastName VARCHAR(100),
);

CREATE TABLE tbl_Contact (
	ContactID INT PRIMARY KEY NOT NULL IDENTITY(1,1),
	People_ID INT NOT NULL CONSTRAINT fk_people_id FOREIGN KEY REFERENCES tbl_People(PeopleID) ON UPDATE CASCADE ON DELETE CASCADE,
	PhoneNumber VARCHAR(50),
	StreetAddress VARCHAR(100),
);


/* INSERT TABLE INFO */

INSERT tbl_People (FirstName, LastName)
	VALUES 
		('Jacob','Hall'),
		('Ashley','Riek'),
		('Tre','Hines'),
		('rOOkie','wOOKie')
	;
SELECT * FROM tbl_People;

INSERT tbl_Contact (People_ID,PhoneNumber, StreetAddress)
	VALUES
		(1,'5125557979', '2121 Walnut Drive'),
		(2,'6985552323', '521 Corn Road'),
		(3,'4565349646', '123 Rainbow Lane'),
		(4,'5495657824', '9099 Coolio Way')
	;
SELECT * FROM tbl_Contact;

SELECT * FROM tbl_Contact WHERE People_ID BETWEEN 2 AND 3;