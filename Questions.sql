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
    title,
    first_name,
    last_name,
    date_of_birth
FROM 
    Customer;
    
    

-- Question 02: Using customer table or tab, please write an SQL query that shows the number of customers in each customer group (Bronze, Silver & Gold).
-- I can see visually that there are 4 Bronze, 3 Silver and 3 Gold but if there were a million customers how would I do this in Excel?

SELECT 
    customer_group,
    COUNT(*) AS customer_count
FROM 
    customer
GROUP BY 
    customer_group;

-- Question 03: The CRM manager has asked me to provide a complete list of all data for those customers in the customer table but 
-- I need to add the currencycode of each player so she will be able to send the right offer in the right currency. 
-- Note that the currencycode does not exist in the customer table but in the account table. Please write the SQL that would facilitate this.

SELECT 
    c.*,
    a.currency_code
FROM 
    customer c
LEFT JOIN 
    account a
ON 
    c.cust_id = a.cust_id;


-- Question 04: Now I need to provide a product manager with a summary report that shows, by product and by day how 
-- much money has been bet on a particular product. PLEASE note that the transactions are stored in the betting table 
-- and there is a product code in that table that is required to be looked up (classid & categortyid) to determine which 
-- product family this belongs to. Please write the SQL that would provide the report.

SELECT 
    p.product_name,
    b.BetDate,
    SUM(b.Bet_Amt) AS total_bet_amount
FROM 
    betting_1 b
JOIN 
    product p
ON 
    b.ClassId = p.class_id AND b.CategoryId = p.category_id
GROUP BY 
    p.product_name, b.BetDate
ORDER BY 
    p.product_name, b.BetDate;


-- Question 05: You’ve just provided the report from question 4 to the product manager, now he has emailed me and wants it changed. 
-- Can you please amend the summary report so that it only summarizes transactions that occurred on or after 1st November and he only 
-- wants to see Sportsbook transactions.Again, please write the SQL below that will do this.

SELECT 
    p.product_name,
    b.BetDate,
    SUM(b.Bet_Amt) AS total_bet_amount
FROM 
    betting_1 b
JOIN 
    product p
ON 
    b.ClassId = p.class_id AND b.CategoryId = p.category_id
WHERE 
    (MONTH(b.BetDate) = 11 AND DAY(b.BetDate) >= 1) AND p.product_name = 'Sportsbook'
GROUP BY 
    p.product_name, b.BetDate
ORDER BY 
    p.product_name, b.BetDate;


-- Question 06: As often happens, the product manager has shown his new report to his director and now he also wants different version of this report. 
-- This time, he wants the all of the products but split by the currencycode and customergroup of the customer, rather than by day and product. 
-- He would also only like transactions that occurred after 1st December. Please write the SQL code that will do this.

SELECT 
    a.currency_code,
    c.customer_group,
    p.product_name,
    SUM(b.Bet_Amt) AS total_bet_amount
FROM 
    betting_1 b
JOIN 
    account a
ON 
    b.AccountNo = a.AccountNo
JOIN 
    customer c
ON 
    a.cust_id = c.cust_id
JOIN 
    product p
ON 
    b.ClassId = p.class_id AND b.CategoryId = p.category_id
WHERE 
    MONTH(b.BetDate) = 12 AND DAY(b.BetDate) > 1
GROUP BY 
    a.currency_code, c.customer_group, p.product_name
ORDER BY 
    a.currency_code, c.customer_group, p.product_name;


-- Question 07: Our VIP team have asked to see a report of all players regardless of whether they have done anything in the complete timeframe or not. 
-- In our example, it is possible that not all of the players have been active. Please write an SQL query that shows all players Title, First Name and
-- Last Name and a summary of their bet amount for the complete period of November.

SELECT 
    c.title,
    c.first_name,
    c.last_name,
    COALESCE(SUM(b.Bet_Amt), 0) AS total_bet_amount
FROM 
    customer c
LEFT JOIN 
    account a
ON 
    c.cust_id = a.cust_id
LEFT JOIN 
    betting_1 b
ON 
    a.AccountNo = b.AccountNo AND MONTH(b.BetDate) = 11
GROUP BY 
    c.title, c.first_name, c.last_name
ORDER BY 
    c.last_name, c.first_name;


-- Question 08: Our marketing and CRM teams want to measure the number of players who play more than one product. 
-- Can you please write 2 queries, one that shows the number of products per player and another that shows players who play both Sportsbook and Vegas.

-- Number of Products Per Player
SELECT 
    c.first_name,
    c.last_name,
    b.AccountNo,
    COUNT(DISTINCT b.Product) AS num_products
FROM 
    betting_1 b
JOIN 
    account a
ON 
    b.AccountNo = a.AccountNo
JOIN 
    customer c
ON 
    a.cust_id = c.cust_id
GROUP BY 
    c.first_name, c.last_name, b.AccountNo
ORDER BY 
    num_products DESC;


--  Query 2: Players Who Play Both Sportsbook and Vegas
SELECT 
    c.first_name,
    c.last_name,
    b.AccountNo
FROM 
    betting_1 b
JOIN 
    account a
ON 
    b.AccountNo = a.AccountNo
JOIN 
    customer c
ON 
    a.cust_id = c.cust_id
WHERE 
    b.Product IN ('Sportsbook', 'Vegas')
GROUP BY 
    c.first_name, c.last_name, b.AccountNo
HAVING 
    COUNT(DISTINCT b.Product) = 2;



-- Question 09: Now our CRM team want to look at players who only play one product, please write SQL code that shows the players who only play at sportsbook,
-- use the bet_amt > 0 as the key. Show each player and the sum of their bets for both products.

SELECT 
    c.first_name,
    c.last_name,
    SUM(b3.Sportsbook) AS sportsbook_bet_total
FROM 
    betting_3 b3
JOIN 
    account a
ON 
    b3.AccountNo = a.AccountNo
JOIN 
    customer c
ON 
    a.cust_id = c.cust_id
WHERE 
    b3.Sportsbook > 0 
    AND COALESCE(b3.Vegas, 0) = 0
    AND COALESCE(b3.Games, 0) = 0
    AND COALESCE(b3.Casino, 0) = 0
    AND COALESCE(b3.Poker, 0) = 0
    AND COALESCE(b3.Bingo, 0) = 0
    AND COALESCE(b3.N_A, 0) = 0
    AND COALESCE(b3.Adjustments, 0) = 0
GROUP BY 
    c.first_name, c.last_name
ORDER BY 
    sportsbook_bet_total DESC;

-- Question 10: The last question requires us to calculate and determine a player’s favorite product. 
-- This can be determined by the most money staked. Please write a query that will show each players favorite product.

WITH PlayerProductTotals AS (
    SELECT 
        c.first_name,
        c.last_name,
        b.AccountNo,
        b.Product,
        SUM(b.Bet_Amt) AS total_staked
    FROM 
        betting_1 b
    JOIN 
        account a
    ON 
        b.AccountNo = a.AccountNo
    JOIN 
        customer c
    ON 
        a.cust_id = c.cust_id
    GROUP BY 
        c.first_name, c.last_name, b.AccountNo, b.Product
),
PlayerFavoriteProduct AS (
    SELECT 
        first_name,
        last_name,
        AccountNo,
        Product AS favorite_product,
        total_staked
    FROM 
        PlayerProductTotals
    WHERE 
        (AccountNo, total_staked) IN (
            SELECT 
                AccountNo, MAX(total_staked)
            FROM 
                PlayerProductTotals
            GROUP BY 
                AccountNo
        )
)
SELECT 
    first_name,
    last_name,
    AccountNo,
    favorite_product,
    total_staked
FROM 
    PlayerFavoriteProduct
ORDER BY 
    last_name, first_name;
    



