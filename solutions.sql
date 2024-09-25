USE gambling;

/* Question 01: Using the customer table or tab, please write an SQL query that shows Title, First Name 
and Last Name and Date of Birth for each of the customers. */
SELECT Title, FirstName, LastName, DateOfBirth
From customer
;

/* Question 02: Using customer table or tab, please write an SQL query that shows the number of customers 
in each customer group (Bronze, Silver & Gold). I can see visually that there are 4 Bronze, 3 Silver 
and 3 Gold but if there were a million customers how would I do this in Excel? */
SELECT CustomerGroup, COUNT(*)
From customer
GROUP BY CustomerGroup
;


/* Question 03: The CRM manager has asked me to provide a complete list of all data for those customers 
in the customer table but I need to add the currencycode of each player so she will be able to send 
the right offer in the right currency. Note that the currencycode does not exist in the customer table0
but in the account table. Please write the SQL that would facilitate this */
SELECT customer.*, account.CurrencyCode
From customer
INNER JOIN account
ON customer.CustId = account.CustId
;


/* Question 04: Now I need to provide a product manager with a summary report that shows, by product 
and by day how much money has been bet on a particular product. PLEASE note that the transactions 
are stored in the betting table and there is a product code in that table that is required to be 
looked up (classid & categortyid) to determine which product family this belongs to. Please write 
the SQL that would provide the report. */
SELECT product.CATEGORYID, product.Product, DATE(betting.BetDate), SUM(betting.Bet_Amt)
FROM product
INNER JOIN betting
ON product.CLASSID = betting.ClassId
GROUP BY product.CATEGORYID, product.product, DATE(betting.BetDate)
ORDER BY product.product, DATE(betting.BetDate)
;


/* Question 05: You’ve just provided the report from question 4 to the product manager, now he has 
emailed me and wants it changed. Can you please amend the summary report so that it only summarizes 
transactions that occurred on or after 1st November and he only wants to see Sportsbook transactions.
Again, please write the SQL below that will do this. */
SELECT product.CATEGORYID, product.product, DATE(betting.BetDate), SUM(betting.Bet_Amt)
FROM product
INNER JOIN betting
ON product.CLASSID = betting.ClassId
WHERE product.product = 'Sportsbook' AND DATE(betting.BetDate) >= '2012-11-01'
GROUP BY product.CATEGORYID, product.product, DATE(betting.BetDate)
ORDER BY DATE(betting.BetDate)
;


/* Question 06: As often happens, the product manager has shown his new report to his director and now 
he also wants different version of this report. This time, he wants the all of the products but split 
by the currencycode and customergroup of the customer, rather than by day and product. He would also 
only like transactions that occurred after 1st December. Please write the SQL code that will do this. */
SELECT 
	betting.Product AS Product,
	customer.CustomerGroup AS 'Customer Group', 
	account.CurrencyCode AS 'Currency Code', 
	SUM(betting.Bet_Amt) AS Amount
FROM betting
INNER JOIN account
ON betting.AccountNo = account.AccountNo
INNER JOIN customer
ON account.CustId = customer.CustId
WHERE BetDate > '2012-12-01'
GROUP BY Product, account.CurrencyCode, customer.CustomerGroup
ORDER BY Product, 'Customer Group', 'Currency Code'
;


/*Question 07: Our VIP team have asked to see a report of all players regardless of whether they have 
done anything in the complete timeframe or not. In our example, it is possible that not all of the 
players have been active. Please write an SQL query that shows all players Title, First Name and 
Last Name and a summary of their bet amount for the complete period of November.*/
SELECT Title, FirstName, LastName, SUM(Bet_Amt) 
FROM customer
INNER JOIN account
	ON customer.CustId = account.CustId
INNER JOIN betting
	ON account.AccountNo = betting.AccountNo
WHERE BetDate BETWEEN '2012-11-01' AND '2012-11-30'
GROUP BY Title, FirstName, LastName
ORDER BY SUM(Bet_Amt) DESC
;


/*Question 08: Our marketing and CRM teams want to measure the number of players who play more than 
one product. Can you please write 2 queries, one that shows the number of products per player and 
another that shows players who play both Sportsbook and Vegas.*/
SELECT FirstName, LastName, COUNT(DISTINCT product.Product) AS Product 
FROM customer
INNER JOIN account
	ON customer.CustId = account.CustId
INNER JOIN betting
	ON account.AccountNo = betting.AccountNo
INNER JOIN product -- No NA 
	ON betting.Product = product.product
GROUP BY FirstName, LastName
HAVING Product > 1
ORDER BY Product DESC
;

SELECT FirstName, LastName, COUNT(DISTINCT product.product), GROUP_CONCAT(DISTINCT betting.product)
FROM customer
INNER JOIN account
	ON customer.CustId = account.CustId
INNER JOIN betting
	ON account.AccountNo = betting.AccountNo
INNER JOIN product -- No NA 
	ON betting.Product = product.product
WHERE betting.Product IN ('Vegas', 'Sportsbook')
GROUP BY FirstName, LastName
HAVING COUNT(DISTINCT betting.product) = 2
ORDER BY FirstName
;


/*Question 09: Now our CRM team want to look at players who only play one product, please write SQL code 
that shows the players who only play at sportsbook, use the bet_amt > 0 as the key. Show each player 
and the sum of their bets for both products.*/
SELECT FirstName, LastName, COUNT(DISTINCT product.Product) AS ProductNo, GROUP_CONCAT(DISTINCT betting.product) AS Product, SUM(Bet_Amt)
FROM customer
INNER JOIN account
ON customer.CustId = account.CustId
INNER JOIN betting
ON account.AccountNo = betting.AccountNo
INNER JOIN product -- No NA 
ON betting.Product = product.product
GROUP BY FirstName, LastName
HAVING ProductNo = 1 AND Product = 'Sportsbook'
ORDER BY SUM(Bet_Amt) DESC
;


/* Question 10: The last question requires us to calculate and determine a player’s favorite product. 
This can be determined by the most money staked. Please write a query that will show each players 
favorite product.*/
SELECT FirstName, LastName, Product, TotalBet
FROM (
	SELECT FirstName, LastName, product.product, SUM(betting.Bet_Amt) AS TotalBet, MAX(SUM(betting.Bet_Amt)) OVER (PARTITION BY customer.CustId) AS MaxBet
	FROM customer
	INNER JOIN account
		ON customer.CustId = account.CustId
	INNER JOIN betting
		ON account.AccountNo = betting.AccountNo
	INNER JOIN product
		ON betting.Product = product.product
	GROUP BY FirstName, LastName, Product, customer.CustId
) AS PlayerBets
WHERE TotalBet = MaxBet
ORDER BY FirstName, TotalBet DESC;


-- Question 11: Write a query that returns the top 5 students based on GPA.
SELECT Column_2 AS Name, Column_5 AS GPA
FROM student_school
ORDER BY GPA DESC
LIMIT 6;


-- Question 12: Write a query that returns the number of students in each school. (a school should be in the output even if it has no students!).
SELECT Column_9, COUNT(Table_student)
FROM student_school
GROUP BY Column_9
;

