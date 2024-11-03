/******************* In the Library *********************/

/*******************************************************/
/* find the number of availalbe copies of Dracula      */
/*******************************************************/
SELECT * FROM books WHERE title = 'Dracula';

/* check total copies of the book */
SELECT COUNT(*) FROM books WHERE title = 'Dracula';

/* total available book */
SELECT * FROM loans;

SELECT * FROM loans WHERE BookID IN
(SELECT BookID FROM books WHERE title="Dracula")
AND ReturnedDate = '';

/********************************************************/
/* Check books for Due back                             */
/* generate a report of books due back on July 13, 2020 */
/* with patron contact information                      */
/********************************************************/
SELECT b.Title, p.FirstName, p.LastName,
p.Email, l.DueDate
FROM loans AS l
INNER JOIN patrons AS p ON l.PatronID = p.PatronID
INNER JOIN books AS b ON l.BookID = b.BookID
WHERE DueDate = '2020-07-13';

/*******************************************************/
/* Encourage Patrons to check out books                */
/* generate a report of showing 10 patrons who have
checked out the fewest books.                          */
/*******************************************************/
SELECT COUNT(loans.LoanID) as num_loans, patrons.PatronID,
patrons.FirstName, patrons.LastName, patrons.Email 
FROM 
patrons LEFT JOIN loans ON loans.PatronID = patrons.PatronID
GROUP BY patrons.PatronID
ORDER BY num_loans
LIMIT 10;

SELECT * FROM 
patrons JOIN loans ON loans.PatronID = patrons.PatronID;


/*******************************************************/
/* Find books to feature for an event                  
 create a list of books from 1890s that are
 currently available                                    */
/*******************************************************/
SELECT COUNT(*), b.BookID, b.Title, b.Author,
b.Published FROM 
loans as l RIGHT JOIN books as b 
ON l.BookID = b.BookID
WHERE b.Published BETWEEN 1890 AND 1899
AND b.BookID NOT IN
(SELECT BookID FROM loans WHERE ReturnedDate = '')
GROUP BY b.BookID
ORDER BY COUNT(*) DESC;

SELECT * FROM loans;
/*******************************************************/
/* Book Statistics 
/* create a report to show how many books were 
published each year.                                    */
/*******************************************************/
SELECT Published, COUNT(DISTINCT(Title))
FROM books
GROUP BY Published;

SELECT DISTINCT(Title), BookID FROM books;

/*************************************************************/
/* Book Statistics                                           */
/* create a report to show 5 most popular Books to check out */
/*************************************************************/
SELECT loans.BookID, books.Title, books.Author, 
COUNT(*) as num_loans 
FROM loans JOIN books ON loans.BookID = books.BookID
GROUP BY BookID
ORDER BY COUNT(*) DESC
LIMIT 5;