
use gambling;


-- 1  Show Title, First Name, Last Name, and Date of Birth for each customer 
SELECT Title, FirstName, LastName, DateOfBirth
FROM customer;

-- 2  Show the number of customers in each customer group (Bronze, Silver, and Gold) 
SELECT CustomerGroup, COUNT(*) AS NumberOfCustomers
FROM customer
GROUP BY CustomerGroup;

-- 3. List all data for customers, including their currency code from the account table 

SELECT c.*, a.CurrencyCode
FROM customer c
JOIN account a ON c.CustId = a.CustId;


-- 4 Summary report by product and day showing how much money has been bet

SELECT p.product, b.BetDate, SUM(b.Bet_Amt) AS total_bet_amount
FROM betting b
JOIN product p ON b.product = p.product
GROUP BY p.product, b.BetDate;
 
 
 
 -- 5 Summary of Sportsbook transactions on or after 1st November
 
 SELECT p.product_name, b.bet_date, SUM(b.bet_amount) AS total_bet_amount
FROM betting b
JOIN product p ON b.product_code = p.product_code
WHERE b.bet_date >= '2022-11-01' AND p.product_name = 'Sportsbook'
GROUP BY p.product_name, b.bet_date;

 -- 6 Summary by currency code and customer group after 1st December. // double check this 
 
 SELECT a.CurrencyCode, c.CustomerGroup, SUM(b.Bet_Amt) AS total_bet_amount
FROM betting b
JOIN account a ON b.AccountNo = a.AccountNo
JOIN customer c ON a.CustId = c.CustId
WHERE b.BetDate > '2022-12-01'
GROUP BY a.CurrencyCode, c.CustomerGroup;


-- 7 Report showing all players and their total bet amount for November

SELECT c.Title, c.FirstName, c.LastName, SUM(b.Bet_Amt) AS total_bet_amount
FROM customer c
LEFT JOIN account a ON c.CustId = a.CustId
LEFT JOIN betting b ON a.AccountNo = b.AccountNo AND b.BetDate BETWEEN '2022-11-01' AND '2022-11-30'
GROUP BY c.Title, c.FirstName, c.LastName;

-- 8 Number of products per player and players who play both Sportsbook and Vegas

-- 1. Number of products per player:

SELECT b.AccountNo, COUNT(DISTINCT b.Product) AS product_count
FROM betting b
GROUP BY b.AccountNo;


-- 2. Players who play both Sportsbook and Vegas: 
SELECT b.AccountNo
FROM betting b
WHERE b.Sportsbook > 0 AND b.Vegas > 0
GROUP BY b.AccountNo;


-- 9 Players who only play at Sportsbook (bet_amt > 0) 

SELECT b.AccountNo, SUM(b.Bet_Amt) AS total_bet_amount
FROM betting b
WHERE b.Product = 'Sportsbook' AND b.Bet_Amt > 0
GROUP BY b.AccountNo;


-- 10 Each player's favorite product (based on most money staked) 

SELECT 
    subquery.AccountNo,
    CASE
        WHEN subquery.Sportsbook = subquery.max_bet_amount THEN 'Sportsbook'
        WHEN subquery.Vegas = subquery.max_bet_amount THEN 'Vegas'
        WHEN subquery.Games = subquery.max_bet_amount THEN 'Games'
        WHEN subquery.Casino = subquery.max_bet_amount THEN 'Casino'
        WHEN subquery.Poker = subquery.max_bet_amount THEN 'Poker'
        WHEN subquery.Bingo = subquery.max_bet_amount THEN 'Bingo'
        ELSE 'Other'
    END AS favorite_product,
    subquery.max_bet_amount
FROM (
    SELECT 
        b.AccountNo,
        b.Sportsbook,
        b.Vegas,
        b.Games,
        b.Casino,
        b.Poker,
        b.Bingo,
        GREATEST(b.Sportsbook, b.Vegas, b.Games, b.Casino, b.Poker, b.Bingo) AS max_bet_amount
    FROM betting b
) AS subquery;



-- 11 Top 5 students based on GPA 

SELECT student_id, student_name, GPA
FROM student
ORDER BY GPA DESC
LIMIT 5;



-- 12 Number of students in each school (even if the school has no students). // double check 

SELECT s.school_name, COUNT(st.student_id) AS student_count
FROM school s
LEFT JOIN student st ON s.school_id = st.school_id
GROUP BY s.school_id, s.school_name;



 -- 13 Top 3 GPA students from each university // double check 
 
 SELECT school.school_name,
       student.student_name,
       student.GPA
FROM school
JOIN student ON school.school_id = student.school_id
ORDER BY school.school_name, student.GPA DESC
LIMIT 3;



 
 