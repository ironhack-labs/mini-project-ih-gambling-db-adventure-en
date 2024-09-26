/* 01: Using the customer table or tab, please write an SQL query that shows Title, First Name and Last Name and Date of Birth for each of the customers.*/
SELECT title, fname, lname, date_of_birth
FROM customer
;

/* 02: Using customer table or tab, please write an SQL query that shows the number of customers in each customer group (Bronze, Silver & Gold).
I can see visually that there are 4 Bronze, 3 Silver and 3 Gold but if there were a million customers how would I do this in Excel?*/
SELECT customer_group, COUNT(DISTINCT cust_id)
FROM customer
GROUP BY customer_group
;

/* 03: The CRM manager has asked me to provide a complete list of all data for those customers in the customer table
but I need to add the currencycode of each player so she will be able to send the right offer in the right currency. 
Note that the currencycode does not exist in the customer table but in the account table. Please write the SQL that would facilitate this.
BONUS: How would I do this in Excel if I had a much larger data set?*/
SELECT customer.*, currency
FROM customer
INNER JOIN account
	ON customer.cust_id = account.cust_id
;

/* 04: Now I need to provide a product manager with a summary report that shows, by product and by day how much money has been bet on a particular product.
PLEASE note that the transactions are stored in the betting table and there is a product code in that table that is required to be looked up (classid & categortyid)
to determine which product family this belongs to. Please write the SQL that would provide the report.
BONUS: If you imagine that this was a much larger data set in Excel, how would you provide this report in Excel?*/
SELECT bet_date, product.product, SUM(bet_amt)
FROM betting
INNER JOIN ibetting.product
	ON betting.class_id = product.class_id
GROUP BY ibetting.product.product, bet_date
ORDER BY bet_date ASC
;

/* 05: You’ve just provided the report from question 4 to the product manager, now he has emailed me and wants it changed.
Can you please amend the summary report so that it only summarizes transactions that occurred on or after 1st November
and he only wants to see Sportsbook transactions.Again, please write the SQL below that will do this.
BONUS: If I were delivering this via Excel, how would I do this?*/
SELECT bet_date, product.product, SUM(bet_amt)
FROM betting
INNER JOIN ibetting.product
	ON betting.class_id = product.class_id
WHERE bet_date LIKE '%-11-%' OR bet_date LIKE '%-12-%' -- Also bet_date >=2012-11-01
GROUP BY product.product, bet_date
HAVING product.product = 'Sportsbook'
ORDER BY bet_date ASC
;

/* 06: As often happens, the product manager has shown his new report to his director and now he also wants different version of this report.
This time, he wants the all of the products but split by the currencycode and customergroup of the customer, rather than by day and product.
He would also only like transactions that occurred after 1st December. Please write the SQL code that will do this.*/
SELECT customer.customer_group, account.currency, product.product, bet_date, SUM(bet_amt)
FROM customer
INNER JOIN account
	ON customer.cust_id = account.cust_id
INNER JOIN betting
	ON account.account_no = betting.account_no
INNER JOIN product
ON betting.product = product.product
WHERE bet_date > "2012-12-01"
GROUP BY customer.customer_group, account.currency, product.product, bet_date
ORDER BY bet_date
;

/* 07: Our VIP team have asked to see a report of all players regardless of whether they have done anything in the complete timeframe or not.
In our example, it is possible that not all of the players have been active.
Please write an SQL query that shows all players Title, First Name and Last Name and a summary of their bet amount for the complete period of November.*/
SELECT title, fname, lname, SUM(bet_amt)
FROM customer
LEFT JOIN account
	ON customer.cust_id = account.cust_id
LEFT JOIN betting
	ON account.account_no = betting.account_no
WHERE bet_date LIKE '%-11-%' OR bet_amt = 0
GROUP BY title, fname, lname
ORDER BY SUM(bet_amt) DESC
;

/* 08: Our marketing and CRM teams want to measure the number of players who play more than one product.
Can you please write 2 queries, one that shows the number of products per player and another that shows players who play both Sportsbook and Vegas.*/
SELECT title, fname, lname, COUNT(product.product)
FROM customer
INNER JOIN account
	ON customer.cust_id = account.cust_id
INNER JOIN betting
	ON account.account_no = betting.account_no
INNER JOIN product
	ON betting.product = product.product
GROUP BY title, fname, lname
HAVING COUNT(DISTINCT betting.product) > 1
ORDER BY COUNT(product.product) DESC
;

SELECT title, fname, lname, COUNT(DISTINCT product.product)-- , GROUP_CONCAT(DISTINCT product.product)
FROM customer
INNER JOIN account
	ON customer.cust_id = account.cust_id
INNER JOIN betting
	ON account.account_no = betting.account_no
INNER JOIN product
	ON betting.product = product.product
WHERE product.product IN ("Sportsbook","Vegas")
GROUP BY title, fname, lname, customer.cust_id
HAVING COUNT(DISTINCT product.product) = 2
ORDER BY lname ASC
;

/* 09: Now our CRM team want to look at players who only play one product, please write SQL code that shows the players who only play at sportsbook, use the bet_amt > 0 as the key.
Show each player and the sum of their bets for both products.*/
SELECT title, fname, lname, SUM(bet_amt), product.product
FROM customer
INNER JOIN account
	ON customer.cust_id = account.cust_id
INNER JOIN betting
	ON account.account_no = betting.account_no
INNER JOIN product
	ON betting.product = product.product
GROUP BY title, fname, lname, product.product
HAVING SUM(bet_amt) > 0 AND COUNT(DISTINCT product.product) = 1 AND product.product = "Sportsbook"
ORDER BY lname ASC
;

/* 10: The last question requires us to calculate and determine a player’s favorite product. This can be determined by the most money staked.
Please write a query that will show each players favorite product.*/
DROP TABLE total_bets; -- Only to reset the temporary table
CREATE TEMPORARY TABLE total_bets AS
SELECT title, fname, lname, product.product, SUM(bet_amt) AS total_amount
FROM customer
INNER JOIN account
	ON customer.cust_id = account.cust_id
INNER JOIN betting
	ON account.account_no = betting.account_no
INNER JOIN product
	ON betting.product = product.product
GROUP BY title, fname, lname, product.product
ORDER BY lname
;
SELECT * FROM total_bets; -- Only to check the temporary table

DROP TABLE max_bet; -- Only to reset the temporary table
CREATE TEMPORARY TABLE max_bet AS
SELECT title, fname, lname, MAX(total_amount) AS max
FROM total_bets
GROUP BY title, fname, lname
;
SELECT * FROM max_bet; -- Only to check the temporary table

SELECT total_bets.title, total_bets.fname, total_bets.lname, total_bets.product, max_bet.max
FROM total_bets
INNER JOIN max_bet
	ON total_bets.lname = max_bet.lname
WHERE total_bets.total_amount = max_bet.max
GROUP BY total_bets.title, total_bets.fname, total_bets.lname, total_bets.product, max_bet.max
ORDER BY total_bets.lname
;

-- Question 11: Write a query that returns the top 5 students based on GPA.
SELECT student_name, GPA
FROM student
-- GROUP BY student_name, GPA
ORDER BY GPA DESC
LIMIT 5
;

-- Question 12: Write a query that returns the number of students in each school. (a school should be in the output even if it has no students!).
SELECT school_name, COUNT(student_id)
FROM school
LEFT JOIN student
	ON school.school_id = student.school_id
GROUP BY school_name
ORDER BY COUNT(student_id) DESC
;

-- Question 13: Write a query that returns the top 3 GPA students' name from each university.
SELECT student_name, school_name, GPA
FROM student
INNER JOIN school
	ON school.school_id = student.school_id
GROUP BY student_name, school_name, GPA
ORDER BY GPA DESC
LIMIT 3
;