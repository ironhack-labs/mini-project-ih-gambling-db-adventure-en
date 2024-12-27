-- Use the `sqltestdata` database
USE sqltestdata;

SHOW TABLES;

SELECT * FROM account LIMIT 10;
SELECT * FROM customer LIMIT 10;
-- SELECT * FROM betting LIMIT 10;
SELECT * FROM product LIMIT 10;
SELECT * FROM student LIMIT 10;
SELECT * FROM school LIMIT 10;


-- Question 01: Using the customer table or tab, please write an SQL query that shows Title, 
-- First Name and Last Name and Date of Birth for each of the customers.

SELECT 
    Title,
    FirstName,
    LastName,
    DateOfBirth
FROM 
    Customer;

-- Question 02: Using customer table or tab, please write an SQL query that shows the number of customers in each customer group (Bronze, Silver & Gold).
-- I can see visually that there are 4 Bronze, 3 Silver and 3 Gold but if there were a million customers how would I do this in Excel?

SELECT 
    CustomerGroup,
    COUNT(*) AS CustomerCount
FROM 
    Customer
GROUP BY 
    CustomerGroup;

-- Question 03: The CRM manager has asked me to provide a complete list of all data for those customers in the customer table but 
-- I need to add the currencycode of each player so she will be able to send the right offer in the right currency. 
-- Note that the currencycode does not exist in the customer table but in the account table. Please write the SQL that would facilitate this.


SELECT 
    Customer.*,
    Account.CurrencyCode
FROM 
    Customer
INNER JOIN 
    Account
ON 
    Customer.CustId = Account.CustId;

-- Question 04: Now I need to provide a product manager with a summary report that shows, by product and by day how 
-- much money has been bet on a particular product. PLEASE note that the transactions are stored in the betting table 
-- and there is a product code in that table that is required to be looked up (classid & categortyid) to determine which 
-- product family this belongs to. Please write the SQL that would provide the report.

SELECT
    Betting.BetDate,
    Product.product AS ProductFamily,
    SUM(Betting.Bet_Amt) AS TotalBetAmount
FROM
    Betting
INNER JOIN
    Product
ON
    Betting.ClassId = Product.CLASSID AND
    Betting.CategoryId = Product.CATEGORYID
GROUP BY
    Betting.BetDate,
    Product.product
ORDER BY
    Betting.BetDate, Product.product;

-- Question 05: You’ve just provided the report from question 4 to the product manager, now he has emailed me and wants it changed. 
-- Can you please amend the summary report so that it only summarizes transactions that occurred on or after 1st November and he only 
-- wants to see Sportsbook transactions.Again, please write the SQL below that will do this.


SELECT
    Betting.BetDate,
    Product.product AS ProductFamily,
    SUM(Betting.Bet_Amt) AS TotalBetAmount
FROM
    Betting
INNER JOIN
    Product
ON
    Betting.ClassId = Product.CLASSID AND
    Betting.CategoryId = Product.CATEGORYID
WHERE
    (MONTH(Betting.BetDate) = 11 AND DAY(Betting.BetDate) >= 1)
    OR MONTH(Betting.BetDate) IN (12)
    AND Product.product = 'Sportsbook'
GROUP BY
    Betting.BetDate,
    Product.product
ORDER BY
    Betting.BetDate, Product.product;

-- Question 06: As often happens, the product manager has shown his new report to his director and now he also wants different version of this report. 
-- This time, he wants the all of the products but split by the currencycode and customergroup of the customer, rather than by day and product. 
-- He would also only like transactions that occurred after 1st December. Please write the SQL code that will do this.

SELECT
    MONTH(Betting.BetDate) AS Month,
    Account.CurrencyCode,
    Customer.CustomerGroup,
    Product.product AS ProductFamily,
    SUM(Betting.Bet_Amt) AS TotalBetAmount
FROM
    Betting
INNER JOIN
    Product
ON
    Betting.ClassId = Product.CLASSID AND
    Betting.CategoryId = Product.CATEGORYID
INNER JOIN
    Account
ON
    Betting.AccountNo = Account.AccountNo
INNER JOIN
    Customer
ON
    Account.CustId = Customer.CustId
WHERE
    MONTH(Betting.BetDate) BETWEEN 12 AND 12 -- December, irrespective of the year
GROUP BY
    MONTH(Betting.BetDate),
    Account.CurrencyCode,
    Customer.CustomerGroup,
    Product.product
ORDER BY
    MONTH(Betting.BetDate),
    Account.CurrencyCode,
    Customer.CustomerGroup,
    Product.product;

-- Question 07: Our VIP team have asked to see a report of all players regardless of whether they have done anything in the complete timeframe or not. 
-- In our example, it is possible that not all of the players have been active. Please write an SQL query that shows all players Title, First Name and
-- Last Name and a summary of their bet amount for the complete period of November.


SELECT 
    Customer.Title,
    Customer.FirstName,
    Customer.LastName,
    COALESCE(SUM(Betting.Bet_Amt), 0) AS TotalBetAmount
FROM 
    Customer
LEFT JOIN 
    Account
ON 
    Customer.CustId = Account.CustId
LEFT JOIN 
    Betting
ON 
    Account.AccountNo = Betting.AccountNo
    AND MONTH(Betting.BetDate) = 11  -- Filter for November, irrespective of year
GROUP BY 
    Customer.Title, 
    Customer.FirstName, 
    Customer.LastName
ORDER BY 
    Customer.LastName, 
    Customer.FirstName;

-- Question 08: Our marketing and CRM teams want to measure the number of players who play more than one product. 
-- Can you please write 2 queries, one that shows the number of products per player and another that shows players who play both Sportsbook and Vegas.


SELECT 
    Betting.AccountNo
FROM 
    Betting
INNER JOIN 
    Product
ON 
    Betting.ClassId = Product.CLASSID 
    AND Betting.CategoryId = Product.CATEGORYID
WHERE 
    Product.product IN ('Sportsbook', 'Vegas')
GROUP BY 
    Betting.AccountNo
HAVING 
    COUNT(DISTINCT Product.product) = 2;

-- Question 09: Now our CRM team want to look at players who only play one product, please write SQL code that shows the players who only play at sportsbook,
-- use the bet_amt > 0 as the key. Show each player and the sum of their bets for both products.

SELECT 
    Betting.AccountNo,
    SUM(CASE WHEN Product.product = 'Sportsbook' THEN Betting.Bet_Amt ELSE 0 END) AS SportsbookBetAmount
FROM 
    Betting
INNER JOIN 
    Product
ON 
    Betting.ClassId = Product.CLASSID 
    AND Betting.CategoryId = Product.CATEGORYID
WHERE 
    Betting.Bet_Amt > 0
GROUP BY 
    Betting.AccountNo
HAVING 
    COUNT(DISTINCT CASE WHEN Product.product != 'Sportsbook' THEN Product.product ELSE NULL END) = 0
    AND SUM(CASE WHEN Product.product = 'Sportsbook' THEN Betting.Bet_Amt ELSE 0 END) > 0
ORDER BY 
    SportsbookBetAmount DESC;


-- Question 10: The last question requires us to calculate and determine a player’s favorite product. 
-- This can be determined by the most money staked. Please write a query that will show each players favorite product.



SELECT 
    Betting.AccountNo,
    Product.product AS FavoriteProduct,
    SUM(Betting.Bet_Amt) AS TotalBetAmount
FROM 
    Betting
INNER JOIN 
    Product
ON 
    Betting.ClassId = Product.CLASSID 
    AND Betting.CategoryId = Product.CATEGORYID
WHERE 
    Betting.Bet_Amt > 0
GROUP BY 
    Betting.AccountNo, Product.product
HAVING 
    SUM(Betting.Bet_Amt) = (
        SELECT MAX(TotalBet) 
        FROM (
            SELECT 
                Betting.AccountNo, 
                SUM(Betting.Bet_Amt) AS TotalBet
            FROM 
                Betting
            INNER JOIN 
                Product
            ON 
                Betting.ClassId = Product.CLASSID 
                AND Betting.CategoryId = Product.CATEGORYID
            WHERE 
                Betting.Bet_Amt > 0
            GROUP BY 
                Betting.AccountNo, Product.product
        ) AS PlayerTotals
        WHERE PlayerTotals.AccountNo = Betting.AccountNo
    )
ORDER BY 
    Betting.AccountNo;

