/*q1*/
SELECT Title, FirstName, LastName, DateOfBirth
FROM ih_gambling.customer;

/*q2*/
SELECT CustomerGroup, Count(*) AS NumberOfCustomers
FROM ih_gambling.customer
GROUP BY CustomerGroup;

/* In excel  you would use a pivot table using customergroup in a row and also in a values field that is set to count. */

/*q3*/
SELECT c.*, a.CurrencyCode
FROM ih_gambling.customer c 
JOIN account a ON c.CustID = a.CustID;

/* BONUS: How would I do this in Excel if I had a much larger data set? */

/*q4*/
SELECT b.BetDate, p.Product, SUM(b.Bet_Amt) AS TotalBetAmount
FROM ih_gambling.betting b
JOIN product p ON b.ClassID = p.ClassID AND b.CategoryID = p.CategoryID
GROUP BY b.BetDate, p.Product
ORDER BY b.BetDate

/*q5*/
SELECT b.BetDate, p.Product, SUM(b.Bet_Amt) AS TotalBetAmount
FROM ih_gambling.betting b
JOIN product p ON b.ClassID = p.ClassID AND b.CategoryID = p.CategoryID
WHERE b.BetDate >= '2012-11-01' AND p.Product = Sportsbook
GROUP BY b.BetDate, p.Product
ORDER BY b.BetDate


/*q6*/
SELECT a.CurrencyCode, c.CustomerGroup, p.Product, SUM(b.Bet_Amt) AS TotalBetAmount
FROM ih_gambling.betting b
JOIN product p ON b.ClassID = p.ClassID AND b.CategoryID = p.CategoryID
JOIN account a ON b.AccountNo = a.AccountNo
JOIN customer c ON a.CustID = c.CustID
WHERE b.BetDate > '2012-12-01'
GROUP BY a.CurrencyCode, c.CustomerGroup, p.Product
ORDER BY a.CurrencyCode, c.CustomerGroup, p.Product;

/*q7*/
SELECT c.Title, c.FirstName, c.LastName, SUM(b.Bet_Amt) AS TotalBetAmount
FROM customer c
JOIN account a ON c.CustID = a.CustID 
LEFT JOIN betting b ON a.AccountNo = b.AccountNo AND b.BetDate BETWEEN '2012-11-01' AND '2012-11-30'
GROUP BY c.CustID;

/*q8*/
SELECT b.AccountNo, COUNT(DISTINCT b.Product) AS NumProducts
FROM betting b
GROUP BY b.AccountNo;

SELECT b.AccountNo
FROM Betting b
WHERE b.Product IN ('Sportsbook', 'Vegas')
GROUP BY b.AccountNo
HAVING COUNT(DISTINCT b.Product) = 2;

/*q9*/
SELECT b.AccountNo, SUM(b.Bet_Amt) AS TotalBetAmount
FROM betting b
WHERE b.Product = 'Sportsbook' AND b.Bet_Amt > 0
GROUP BY b.AccountNo
HAVING COUNT(DISTINCT b.Product) = 1;

/*q10*/
SELECT b.AccountNo, b.Product, SUM(b.Bet_Amt) AS TotalBetAmount
FROM betting b
GROUP BY b.AccountNo, b.Product
ORDER BY b.AccountNo, TotalBetAmount DESC;

/*q11*/
SELECT student_name, GPA FROM student
ORDER BY GPA DESC
LIMIT 5;

/*q12*/
SELECT s.school_name, COUNT(st.school_id) AS NumberOfStudents
FROM school s 
LEFT JOIN student st ON s.school_id_1 = st.school_id
GROUP BY s.school_name
ORDER BY s.school_name;

/*q13*/
SELECT s.student_name, sch.school_name
FROM student s
JOIN school sch ON s.school_id = sch.school_id_1
WHERE (SELECT COUNT(*) 
        FROM student s2
        WHERE s2.school_id = s.school_id AND s2.GPA > s.GPA) <= 3
ORDER BY s.school_id, s.GPA DESC;
