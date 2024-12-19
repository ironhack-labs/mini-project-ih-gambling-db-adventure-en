-- Question 1
SELECT Title, FirstName, LastName, DateOfBirth
FROM ironhack_gambling.Customer;

-- Question 2
SELECT CustomerGroup, COUNT(*) AS NumberOfCustomers
FROM ironhack_gambling.Customer
GROUP BY CustomerGroup;

-- Question 3
SELECT c.*, a.CurrencyCode  
FROM ironhack_gambling.customer c  
JOIN ironhack_gambling.account a ON c.CustID = a.CustID;
-- Bonus: Using the Function =VLOOKUP(A2, Sheet2!A:B, 2, FALSE)

-- Question 4
SELECT BetDate, ClassId, CategoryId, SUM(Bet_Amt) AS TotalBetAmount  
FROM ironhack_gambling.betting  
GROUP BY BetDate, ClassId, CategoryId  
ORDER BY BetDate, ClassId, CategoryId;
-- Bonus: Using Pivot Tables

-- Question 5
SELECT BetDate, ClassId, CategoryId, SUM(Bet_Amt) AS TotalBetAmount  
FROM ironhack_gambling.betting  
WHERE BetDate >= '2012-11-01' AND Product = 'Sportsbook'  
GROUP BY BetDate, ClassId, CategoryId  
ORDER BY BetDate, ClassId, CategoryId;
-- Bonus: Using Filters and Pivot Tables

-- Question 6
SELECT a.CurrencyCode, c.CustomerGroup, b.Product, SUM(b.Bet_Amt) AS TotalBetAmount  
FROM ironhack_gambling.betting b  
JOIN ironhack_gambling.account a ON b.AccountNo = a.AccountNo  
JOIN ironhack_gambling.customer c ON a.CustID = c.CustID  
WHERE BetDate > '2012-12-01'  
GROUP BY a.CurrencyCode, c.CustomerGroup, b.Product  
ORDER BY a.CurrencyCode, c.CustomerGroup, b.Product;

-- Question 7
SELECT c.Title, c.FirstName, c.LastName, IFNULL(SUM(b.Bet_Amt), 0) AS TotalBetAmount  
FROM ironhack_gambling.customer c  
LEFT JOIN ironhack_gambling.account a ON c.CustID = a.CustID  
LEFT JOIN ironhack_gambling.betting b ON a.AccountNo = b.AccountNo  
WHERE b.BetDate BETWEEN '2012-11-01' AND '2012-11-30' OR b.BetDate IS NULL  
GROUP BY c.CustID, c.Title, c.FirstName, c.LastName;

-- Question 8
-- 8.1
SELECT a.CustID, COUNT(b.Product) AS NumberOfProducts  
FROM ironhack_gambling.betting b  
JOIN ironhack_gambling.account a ON b.AccountNo = a.AccountNo  
GROUP BY a.CustID;
-- 8.2
SELECT a.CustID, COUNT(b.Product) AS NumberOfProducts  
FROM ironhack_gambling.betting b  
JOIN ironhack_gambling.account a ON b.AccountNo = a.AccountNo  
WHERE b.Product IN ('Sportsbook', 'Vegas')  
GROUP BY a.CustID  
HAVING NumberOfProducts = 2;

-- Question 9
SELECT a.CustID, SUM(b.Bet_Amt) AS TotalBetAmount  
FROM ironhack_gambling.betting b  
JOIN ironhack_gambling.account a ON b.AccountNo = a.AccountNo  
WHERE b.Product = 'Sportsbook'  
GROUP BY a.CustID  
HAVING SUM(b.Bet_Amt) > 0;

-- Question 10
SELECT a.CustId, b.Product 
FROM (SELECT AccountNo, Product, Max(Total_Bet_Amt) Max_Total_Bet_Amt FROM (
SELECT AccountNo, Product, SUM(Bet_Amt) as Total_Bet_Amt FROM ironhack_gambling.betting
GROUP BY AccountNo, Product) as max_total_bet_amt
GROUP BY AccountNo, Product) as b
JOIN ironhack_gambling.account a ON b.AccountNo = a.AccountNo;

-- Question 11
SELECT student_name, gpa 
FROM student 
ORDER BY gpa DESC 
LIMIT 5;

-- Question 12
SELECT s.school_name, COUNT(st.student_id) AS number_of_students
FROM school s
LEFT JOIN student st ON s.school_id_1 = st.school_id
GROUP BY s.school_id_1, s.school_name
ORDER BY number_of_students DESC;

-- Question 13
-- Use the Window Function to Create a Temporary Rank for Students
WITH RankedStudents AS (
    SELECT st.student_name, st.gpa, s.school_name,
        ROW_NUMBER() OVER (PARTITION BY s.school_name ORDER BY st.gpa DESC) AS rank
    FROM student st
    JOIN school s ON st.school_id = s.school_id_1
)
-- Select the Students with a Rank of 1,2, or 3
SELECT school_name, student_name, gpa 
FROM RankedStudents 
WHERE rank <= 3
ORDER BY school_name, rank;












