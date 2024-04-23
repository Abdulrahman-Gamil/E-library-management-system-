-- Create a database for the library
CREATE DATABASE E_Library_sys;

-- Create a Member table
CREATE TABLE Member (
    MemberID NVARCHAR(50) PRIMARY KEY,
    Name NVARCHAR(50),
    Address NVARCHAR(50),
    Membership_Status NVARCHAR(50)
);

-- Create an ISBN table
CREATE TABLE ISBN (
    ISBN NVARCHAR(50) PRIMARY KEY,
    Author NVARCHAR(50),
    Edition NVARCHAR(50)
);

-- Create a Publisher table
CREATE TABLE Publisher (
    PublisherID NVARCHAR(50) PRIMARY KEY,
    Publisher_Name NVARCHAR(50),
    Publisher_Address NVARCHAR(50)
);

-- Create a Book table
CREATE TABLE Book (
    BookID NVARCHAR(50) PRIMARY KEY,
    Book_Name NVARCHAR(50),
    Genre NVARCHAR(50),
    Category NVARCHAR(50),
    Description NVARCHAR(50),
    ISBN NVARCHAR(50) FOREIGN KEY REFERENCES ISBN(ISBN),
    PublisherID NVARCHAR(50) FOREIGN KEY REFERENCES Publisher(PublisherID)
);

-- Create a Reservation table
CREATE TABLE Reservation (
    ReservationID NVARCHAR(50) PRIMARY KEY,
    MemberID NVARCHAR(50) FOREIGN KEY REFERENCES Member(MemberID),
    BookID NVARCHAR(50) FOREIGN KEY REFERENCES Book(BookID),
    Reservation_Date DATE,
    Reservation_Status NVARCHAR(50)
);

-- Create a Copies table
CREATE TABLE Copies (
    CopiesID NVARCHAR(50) PRIMARY KEY,
    BookID NVARCHAR(50) FOREIGN KEY REFERENCES Book(BookID),
    Available NVARCHAR(50)
);

-- Create a Loan table
CREATE TABLE Loan (
    LoanID NVARCHAR(50) PRIMARY KEY,
    MemberID NVARCHAR(50) FOREIGN KEY REFERENCES Member(MemberID),
    CopiesID NVARCHAR(50) FOREIGN KEY REFERENCES Copies(CopiesID),
    Loan_Date DATE,
    Return_Date DATE,
    Fine_Amount_RM NVARCHAR(50)
);


-- Insert data into the Member table
INSERT INTO Member (MemberID, Name, Address, Membership_Status) VALUES
('D001', 'Maverick', 'Subang Jaya', 'Active'),
('D002', 'Naim', 'Petaling Jaya', 'Active'),
('D003', 'David', 'Puchong', 'Active'),
('D004', 'Belford', 'Bukit Jalil', 'Active'),
('D005', 'Neymar', 'Selangor', 'Active');

-- Insert data into the ISBN table
INSERT INTO ISBN (ISBN, Author, Edition) VALUES
('BN001', 'Diann.M, John.D, Mas.O', '1'),
('BN002', 'Kelly.G', '3'),
('BN003', 'Brian.K, Mark.P, Mian.Z', '2'),
('BN004', 'Bill.S', '4'),
('BN005', 'Brian.K', '1'),
('BN006', 'David.K', '2'),
('BN007', 'Brian.K', '6');

-- Insert data into the Publisher table
INSERT INTO Publisher (PublisherID, Publisher_Name, Publisher_Address) VALUES
('P001', 'ABC', 'Perlis'),
('P002', 'DEF', 'Perak'),
('P003', 'GHI', 'Kedah'),
('P004', 'JKL', 'Penang'),
('P005', 'XYZ', 'Johor');


INSERT INTO Reservation (ReservationID, MemberID, BookID, Reservation_Date, Reservation_Status)
VALUES
('R002', 'D001', 'B001', '9-25-2022', 'Pending'),
('R003', 'D002', 'B002', '8-31-2022', 'Available'),
('R005', 'D002', 'B006', '8-31-2022', 'Available'),
('R004', 'D003', 'B003', '4-16-2022', 'Available'),
('R006', 'D004', 'B004', '8-19-2022', 'Pending'),
('R007', 'D004', 'B007', '8-19-2022', 'Pending'),
('R001', 'D005', 'B005', '6-22-2022', 'Pending');

INSERT INTO Book (BookID, Book_Name, Genre, Category, Description, ISBN, PublisherID)
VALUES
('B002', 'Halo', 'NF', 'Green', 'A book based on freedom fighting', 'BN002', 'P002'),
('B006', 'Grand Theft Auto', 'NF', 'Yellow', 'A book which simulates real life', 'BN006', 'P002'),
('B003', 'Need For Speed 1', 'NF', 'Yellow', 'A book which simulates the life of racing', 'BN003', 'P003'),
('B005', 'Need For Speed 2', 'NF', 'Green', 'A book based on true basketball legends', 'BN005', 'P005'),
('B007', 'Need For Speed 3', 'NF', 'Green', 'A book which simulates the life of racing', 'BN007', 'P004'),
('B004', 'THE NBA Book', 'NF', 'Yellow', 'A book which simulates the life of racing', 'BN004', 'P004'),
('B001', 'Breach of Trust', 'F', 'Red', 'Book based on a video game for combat operations', 'BN001', 'P001');

INSERT INTO Copies (CopiesID, BookID, Available)
VALUES
('C002', 'B001', '4'),
('C003', 'B002', '3'),
('C006', 'B006', '2'),
('C001', 'B003', '5'),
('C005', 'B004', '7'),
('C009', 'B007', '3'),
('C008', 'B005', '4');


INSERT INTO Loan (LoanID, MemberID, CopiesID, Loan_Date, Return_Date, Fine_Amount_RM)
VALUES
('LD002', 'D001', 'C002', '9-14-2022', '9-23-2022', '10'),
('LD006', 'D005', 'C008', '6-11-2022', '6-22-2022', '20'),
('LD007', 'D004', 'C005', '8-10-2022', '8-18-2022', '5'),
('LD009', 'D004', 'C009', '8-10-2022', '8-18-2022', '5'),
('LD010', 'D002', 'C006', '8-18-2022', '8-28-2022', '15'),
('LD011', 'D002', 'C003', '8-18-2022', '8-28-2022', '15'),
('LD015', 'D003', 'C001', '4-9-2022', '4-16-2022', '0');

-- 1. Display the names and addresses of all active members.
SELECT MemberID, Name, Address
FROM Member
WHERE Membership_Status = 'Active';

-- 2. List the books that are currently available for reservation along with their authors and publishers.
SELECT B.Book_Name, I.Author, P.Publisher_Name
FROM Book B
INNER JOIN ISBN I ON B.ISBN = I.ISBN
INNER JOIN Publisher P ON B.PublisherID = P.PublisherID
LEFT JOIN Reservation R ON B.BookID = R.BookID
WHERE R.Reservation_Status = 'Available';

-- 3. Show the total number of copies available for each book.
SELECT B.Book_Name, COUNT(C.CopiesID) AS Total_Copies
FROM Book B
LEFT JOIN Copies C ON B.BookID = C.BookID
GROUP BY B.Book_Name;

-- 4. Retrieve the details of all pending reservations including the reservation date.
SELECT R.ReservationID, R.MemberID, R.BookID, R.Reservation_Date
FROM Reservation R
WHERE R.Reservation_Status = 'Pending';

-- 5. Provide a report of all loans made, showing the member names, book names, loan dates, and return dates.
SELECT M.Name AS Member_Name, B.Book_Name, L.Loan_Date, L.Return_Date
FROM Loan L
INNER JOIN Member M ON L.MemberID = M.MemberID
INNER JOIN Copies C ON L.CopiesID = C.CopiesID
INNER JOIN Book B ON C.BookID = B.BookID;


-- 6. Find out the total fine amount collected from all loans.
SELECT SUM(CAST(Fine_Amount_RM AS DECIMAL)) AS Total_Fine_Amount
FROM Loan;

-- 7. Display the genres of books along with the count of books in each genre.
SELECT Genre, COUNT(BookID) AS Count_Of_Books
FROM Book
GROUP BY Genre;

-- 8. Retrieve the authors who have written more than one book in the library.
SELECT Author
FROM ISBN
GROUP BY Author
HAVING COUNT(ISBN) > 1;

-- 9. Show the publisher names along with the count of books published by each publisher.
SELECT P.Publisher_Name, COUNT(B.BookID) AS Count_Of_Books
FROM Publisher P
LEFT JOIN Book B ON P.PublisherID = B.PublisherID
GROUP BY P.Publisher_Name;

-- 10. Get the MemberIDs of members who have made reservations but not yet borrowed any books.
SELECT DISTINCT R.MemberID
FROM Reservation R
LEFT JOIN Loan L ON R.MemberID = L.MemberID
WHERE L.MemberID IS NULL;

-- 11. Retrieve the MemberIDs and names of members who have borrowed books but not returned them yet, along with the details of the books they borrowed.
SELECT DISTINCT M.MemberID, M.Name, B.Book_Name, L.Loan_Date
FROM Member M
INNER JOIN Loan L ON M.MemberID = L.MemberID
INNER JOIN Copies C ON L.CopiesID = C.CopiesID
INNER JOIN Book B ON C.BookID = B.BookID
WHERE L.Return_Date IS NULL;

-- 12. List the MemberIDs and names of members who have borrowed books, sorted by the number of books borrowed in descending order.
SELECT M.MemberID, M.Name, COUNT(L.LoanID) AS Total_Borrowed
FROM Member M
LEFT JOIN Loan L ON M.MemberID = L.MemberID
GROUP BY M.MemberID, M.Name
ORDER BY Total_Borrowed DESC;

-- 13. Show the MemberIDs and names of members who have incurred fines greater than a specified amount.
SELECT DISTINCT M.MemberID, M.Name, L.Fine_Amount_RM
FROM Member M
INNER JOIN Loan L ON M.MemberID = L.MemberID
WHERE CAST(L.Fine_Amount_RM AS DECIMAL) > <specified_amount>;

-- 14. Display the ISBNs and names of books that have been reserved but not yet borrowed.
SELECT R.BookID, B.Book_Name, R.Reservation_Date
FROM Reservation R
LEFT JOIN Loan L ON R.BookID = L.BookID
INNER JOIN Book B ON R.BookID = B.BookID
WHERE L.BookID IS NULL;

-- 15. Provide a report of the total number of reservations made by each member.
SELECT R.MemberID, M.Name, COUNT(R.ReservationID) AS Total_Reservations
FROM Reservation R
INNER JOIN Member M ON R.MemberID = M.MemberID
GROUP BY R.MemberID, M.Name;

-- 16. Retrieve the MemberIDs and names of members who have both made reservations and borrowed books.
SELECT DISTINCT M.MemberID, M.Name
FROM Member M
INNER JOIN Reservation R ON M.MemberID = R.MemberID
INNER JOIN Loan L ON M.MemberID = L.MemberID;

-- 17. Show the MemberIDs and names of members who have never borrowed any books.
SELECT M.MemberID, M.Name
FROM Member M
LEFT JOIN Loan L ON M.MemberID = L.MemberID
WHERE L.MemberID IS NULL;

-- 18. Display the ISBNs and names of books published by a specific publisher.
SELECT B.Book_Name, I.ISBN
FROM Book B
INNER JOIN ISBN I ON B.ISBN = I.ISBN
WHERE B.PublisherID = '<publisher_id>';

-- 19. Retrieve the details of books published by publishers located in a specific city.
SELECT B.Book_Name, I.Author, P.Publisher_Name
FROM Book B
INNER JOIN ISBN I ON B.ISBN = I.ISBN
INNER JOIN Publisher P ON B.PublisherID = P.PublisherID
WHERE P.Publisher_Address = '<city>';

-- 20. Show the MemberIDs and names of members who have borrowed books published by a specific publisher.
SELECT DISTINCT M.MemberID, M.Name
FROM Member M
INNER JOIN Loan L ON M.MemberID = L.MemberID
INNER JOIN Copies C ON L.CopiesID = C.CopiesID
INNER JOIN Book B ON C.BookID = B.BookID
INNER JOIN Publisher P ON B.PublisherID = P.PublisherID
WHERE P.Publisher_Name = '<publisher_name>';
