/* Question 01: Using the customer table or tab, please write an SQL query that shows Title, 
First Name and Last Name and Date of Birth for each of the customers. */

SELECT title, first_name, last_name, date_of_birth
FROM ironhackgamble.customer ic;


/* Question 02: Using customer table or tab, please write an SQL query that shows the number of customers in each customer group 
(Bronze, Silver & Gold). I can see visually that there are 4 Bronze, 3 Silver and 3 Gold but if there were a million customers 
how would I do this in Excel? */

SELECT customer_group, COUNT(customer_group)
FROM ironhackgamble.customer
GROUP BY customer_group;


/* Question 03: The CRM manager has asked me to provide a complete list of all data for those customers in the customer table 
but I need to add the currencycode of each player so she will be able to send the right offer in the right currency. 
Note that the currencycode does not exist in the customer table but in the account table. 
Please write the SQL that would facilitate this.
BONUS: How would I do this in Excel if I had a much larger data set? */

SELECT 
    ic.*, 
    a.currency_code
FROM ironhackgamble.customer ic
JOIN ironhackgamble.account a ON ic.cust_id = a.customer_id;


/* Question 04: Now I need to provide a product manager with a summary report that shows, 
by product and by day how much money has been bet on a particular product. 
PLEASE note that the transactions are stored in the betting table and there is a product code 
in that table that is required to be looked up (classid & categortyid) to determine which product family this belongs to. 
Please write the SQL that would provide the report.
BONUS: If you imagine that this was a much larger data set in Excel, how would you provide this report in Excel? */

SELECT 
    p.product,
    DATE(b.bet_date) AS bet_date,
    SUM(b.bet_amount) AS total_bet_amount
FROM ironhackgamble.betting b
JOIN ironhackgamble.product p ON b.product = p.product
GROUP BY p.product, DATE(b.bet_date)
ORDER BY bet_date, p.product;


/* Question 05: You’ve just provided the report from question 4 to the product manager, now he has emailed me and wants it changed. 
Can you please amend the summary report so that it only summarizes transactions that occurred on or after 1st November 
and he only wants to see Sportsbook transactions.
Again, please write the SQL below that will do this.
BONUS: If I were delivering this via Excel, how would I do this? */

SELECT 
    p.product,
    DATE(b.bet_date) AS bet_date, 
    SUM(b.bet_amount) AS total_bet_amount
FROM ironhackgamble.betting b
JOIN ironhackgamble.product p ON b.product = p.product
WHERE b.bet_date >= '2012-11-01' AND p.product = 'Sportsbook'
GROUP BY p.product, DATE(b.bet_date)
ORDER BY bet_date, p.product;


/* Question 06: As often happens, the product manager has shown his new report to his director 
and now he also wants different version of this report. 
This time, he wants the all of the products but split by the currencycode and customergroup of the customer, 
rather than by day and product. He would also only like transactions that occurred after 1st December. 
Please write the SQL code that will do this. */

SELECT 
    p.product,
    a.currency_code,
    c.customer_group,
    SUM(b.bet_amount) AS total_bet_amount
FROM ironhackgamble.betting b
JOIN ironhackgamble.product p ON b.product = p.product
JOIN ironhackgamble.account a ON b.account_num = a.account_num
JOIN ironhackgamble.customer c ON a.customer_id = c.cust_id
WHERE b.bet_date >= '2012-12-01'
GROUP BY p.product, a.currency_code, c.customer_group
ORDER BY p.product, a.currency_code, c.customer_group;


/* Question 07: Our VIP team have asked to see a report of all players regardless of whether they have done anything in the complete timeframe or not. 
In our example, it is possible that not all of the players have been active. 
Please write an SQL query that shows all players Title, First Name and Last Name and a summary of their bet amount for the complete period of November. */

SELECT 
    c.title, 
    c.first_name, 
    c.last_name, 
    COALESCE(SUM(b.bet_amount), 0) AS total_bet_amount
FROM ironhackgamble.customer c
LEFT JOIN ironhackgamble.account a ON c.cust_id = a.customer_id
LEFT JOIN ironhackgamble.betting b ON b.account_num = a.account_num
WHERE b.bet_date >= '2012-11-01' AND b.bet_date < '2012-12-01' OR b.account_num IS NULL
GROUP BY c.title, c.first_name, c.last_name
ORDER BY c.last_name, c.first_name;


/* Question 08: Our marketing and CRM teams want to measure the number of players who play more than one product. 
Can you please write 2 queries, one that shows the number of products per player 
and another that shows players who play both Sportsbook and Vegas. */

SELECT 
    c.cust_id, 
    c.first_name, 
    c.last_name, 
    COUNT(DISTINCT b.product) AS num_products_played
FROM ironhackgamble.customer c
JOIN ironhackgamble.account a ON c.cust_id = a.customer_id
JOIN ironhackgamble.betting b ON b.account_num = a.account_num
GROUP BY c.cust_id, c.first_name, c.last_name
HAVING COUNT(DISTINCT b.product) > 1
ORDER BY num_products_played DESC;

SELECT 
    c.cust_id, 
    c.first_name, 
    c.last_name
FROM ironhackgamble.customer c
JOIN ironhackgamble.account a ON c.cust_id = a.customer_id
JOIN ironhackgamble.betting b ON b.account_num = a.account_num
WHERE b.product IN ('Sportsbook', 'Vegas')
GROUP BY c.cust_id, c.first_name, c.last_name
HAVING COUNT(DISTINCT b.product) = 2
ORDER BY c.last_name, c.first_name;


/* Question 09: Now our CRM team want to look at players who only play one product, 
please write SQL code that shows the players who only play at sportsbook, use the bet_amt > 0 as the key. 
Show each player and the sum of their bets for both products. */

SELECT 
    c.title, 
    c.first_name, 
    c.last_name, 
    SUM(b.bet_amount) AS total_bet_amount
FROM ironhackgamble.customer c
JOIN ironhackgamble.account a ON c.cust_id = a.customer_id
JOIN ironhackgamble.betting b ON b.account_num = a.account_num
WHERE b.product = 'Sportsbook' AND b.bet_amount > 0
GROUP BY c.cust_id, c.title, c.first_name, c.last_name
HAVING COUNT(DISTINCT b.product) = 1
ORDER BY total_bet_amount DESC;


/* Question 10: The last question requires us to calculate and determine a player’s favorite product. 
This can be determined by the most money staked. Please write a query that will show each players favorite product. */

SELECT 
    c.cust_id,
    c.title, 
    c.first_name, 
    c.last_name, 
    b.product AS favorite_product, 
    SUM(b.bet_amount) AS total_bet_amount
FROM ironhackgamble.customer c
JOIN ironhackgamble.account a ON c.cust_id = a.customer_id
JOIN ironhackgamble.betting b ON b.account_num = a.account_num
WHERE b.product = (
        SELECT b2.product
        FROM ironhackgamble.betting b2
        JOIN ironhackgamble.account a2 ON b2.account_num = a2.account_num
        WHERE a2.customer_id = c.cust_id
        GROUP BY b2.product
        ORDER BY SUM(b2.bet_amount) DESC
        LIMIT 1
    )
GROUP BY c.cust_id, c.title, c.first_name, c.last_name, b.product
ORDER BY c.cust_id, total_bet_amount DESC;




/* Looking at the abstract data on the "Student_School" tab into the Excel spreadsheet, please answer the below questions:
Question 11: Write a query that returns the top 5 students based on GPA. */

SELECT student_name, GPA
FROM ironhackgamble.student
ORDER BY GPA DESC
LIMIT 5;

/* Question 12: Write a query that returns the number of students in each school. 
(a school should be in the output even if it has no students!). */

SELECT 
    s.school_name, 
    COALESCE(COUNT(st.student_id), 0) AS num_students
FROM ironhackgamble.school s
JOIN ironhackgamble.student st ON s.school_id = st.school_id
GROUP BY s.school_name;

/* Question 13: Write a query that returns the top 3 GPA students' name from each university. */

SELECT 
    student_name,
    school_name,
    GPA
FROM (
    SELECT 
        st.student_name,
        sc.school_name,
        st.GPA,
        ROW_NUMBER() OVER (PARTITION BY st.school_id ORDER BY st.GPA DESC) AS row_num
    FROM ironhackgamble.student st
    JOIN ironhackgamble.school sc ON st.school_id = sc.school_id
) AS ranked_students
WHERE row_num <= 3
ORDER BY school_name, row_num;





