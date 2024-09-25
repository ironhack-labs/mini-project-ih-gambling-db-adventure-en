USE ironhack_gambling;

-- Question 01: Using the customer table or tab, please write an SQL query that shows Title, First Name and Last Name and Date of Birth for each of the customers.
SELECT DISTINCT
Title,
FirstName,
LastName,
DateofBirth
FROM customers;


-- Question 02: Using customer table or tab, please write an SQL query that shows the number of customers in each customer group (Bronze, Silver & Gold). I can see visually that there are 4 Bronze, 3 Silver and 3 Gold but if there were a million customers how would I do this in Excel?

SELECT
CustomerGroup,
COUNT(CustId)
FROM customers
group by CustomerGroup;

-- Question 03: The CRM manager has asked me to provide a complete list of all data for those customers in the customer table but I need to add the currencycode of each player so she will be able to send the right offer in the right currency. Note that the currencycode does not exist in the customer table but in the account table. Please write the SQL that would facilitate this.
-- BONUS: How would I do this in Excel if I had a much larger data set?
SELECT 
customers.*,
currency_code
FROM customers
LEFT JOIN
test_data on customers.CustId = test_data.cust_id;


-- Question 04: Now I need to provide a product manager with a summary report that shows, by product and by day how much money has been bet on a particular product. PLEASE note that the transactions are stored in the betting table and there is a product code in that table that is required to be looked up (classid & categortyid) to determine which product family this belongs to. Please write the SQL that would provide the report.
-- BONUS: If you imagine that this was a much larger data set in Excel, how would you provide this report in Excel?

SELECT
ClassId,
CategoryId,
Products.Product,
bet_date,
sum(bet_amt)
FROM Products
INNER JOIN
Betting on Products.ClassId = Betting.class_id
GROUP BY ClassId, CategoryId,Product, bet_date
ORDER BY bet_date;


-- Question 05: You’ve just provided the report from question 4 to the product manager, now he has emailed me and wants it changed. Can you please amend the summary report so that it only summarizes transactions that occurred on or after 1st November and he only wants to see Sportsbook transactions.Again, please write the SQL below that will do this.
-- BONUS: If I were delivering this via Excel, how would I do this?

SELECT
ClassId,
CategoryId,
Products.Product,
bet_date,
sum(bet_amt)
FROM Products
INNER JOIN
Betting on Products.ClassId = Betting.class_id
WHERE bet_date >= "2012-11-01"
AND Products.Product = "Sportsbook"
GROUP BY ClassId, CategoryId,Product, bet_date
ORDER BY bet_date;


-- Question 06: As often happens, the product manager has shown his new report to his director and now he also wants different version of this report. This time, he wants the all of the products but split by the currencycode and customergroup of the customer, rather than by day and product. He would also only like transactions that occurred after 1st December. Please write the SQL code that will do this.

SELECT
p.Product,
t.currency_code,
c.CustomerGroup,
b.bet_date
FROM Products AS p
INNER JOIN
Betting AS b on p.ClassId = b.class_id
INNER JOIN
test_data AS t on b.account_no = t.account_no
INNER JOIN
Customers AS c on t.cust_id = c.CustId
WHERE bet_date >= "2012-12-01"
ORDER BY b.bet_date;

-- Question 07: Our VIP team have asked to see a report of all players regardless of whether they have done anything in the complete timeframe or not. In our example, it is possible that not all of the players have been active. Please write an SQL query that shows all players Title, First Name and Last Name and a summary of their bet amount for the complete period of November.
SELECT
c.Title,
c.FirstName,
c.LastName,
SUM(b.bet_amt) AS "Total Amount Bet in November"
FROM customers AS c
LEFT JOIN
test_data as t on c.CustId = t.cust_id
LEFT JOIN
betting as b on t.account_no = b.account_no
	AND bet_date >= "2012-11-01" and bet_date <= "2012-11-30"
GROUP BY c.Title, c.FirstName, c.LastName
ORDER BY c.FirstName, c.LastName;

-- Question 08: Our marketing and CRM teams want to measure the number of players who play more than one product. Can you please write 2 queries, one that shows the number of products per player and another that shows players who play both Sportsbook and Vegas.

	--  number of products per player
    
	SELECT
    c.Title,
	c.FirstName,
	c.LastName,
	COUNT(DISTINCT p.Product) AS "Number of Products"
	FROM Products AS p
	LEFT JOIN
	Betting AS b on p.ClassId = b.class_id
	LEFT JOIN
	test_data AS t on b.account_no = t.account_no
	LEFT JOIN
	Customers AS c on t.cust_id = c.CustId
    GROUP BY c.Title, c.FirstName, c.LastName
    ORDER BY c.Title, c.FirstName, c.LastName;

	-- players who play both Sportsbook and Vegas
	SELECT
    c.Title,
	c.FirstName,
	c.LastName,
	CASE
		WHEN COUNT(DISTINCT CASE WHEN p.Product IN ("Sportsbook", "Vegas") THEN p.Product END) = 2 THEN TRUE
        ELSE FALSE
        END AS "Plays Sportbook and Vegas"
	FROM Products AS p
	LEFT JOIN
	Betting AS b on p.ClassId = b.class_id
	LEFT JOIN
	test_data AS t on b.account_no = t.account_no
	LEFT JOIN
	Customers AS c on t.cust_id = c.CustId
    GROUP BY c.Title, c.FirstName, c.LastName
    ORDER BY c.Title, c.FirstName, c.LastName;
    
    
-- Question 09: Now our CRM team want to look at players who only play one product, please write SQL code that shows the players who only play at sportsbook, use the bet_amt > 0 as the key. Show each player and the sum of their bets for both products.
	SELECT
    c.Title,
	c.FirstName,
	c.LastName,
    SUM(bet_amt)
	FROM Products AS p
	LEFT JOIN
	Betting AS b on p.ClassId = b.class_id
	LEFT JOIN
	test_data AS t on b.account_no = t.account_no
	LEFT JOIN
	Customers AS c on t.cust_id = c.CustId
    WHERE p.Product = "Sportsbook"
    AND bet_amt > 0
    AND c.CustID NOT IN (
    SELECT c2.CustId 
        FROM Products AS p2
        LEFT JOIN Betting AS b2 ON p2.ClassId = b2.class_id
        LEFT JOIN test_data AS t2 ON b2.account_no = t2.account_no
        LEFT JOIN Customers AS c2 ON t2.cust_id = c2.CustId
        WHERE p2.Product != "Sportsbook" AND b2.bet_amt > 0
    )
    GROUP BY c.Title, c.FirstName, c.LastName
    ORDER BY c.Title, c.FirstName, c.LastName;


-- Question 10: The last question requires us to calculate and determine a player’s favorite product. This can be determined by the most money staked. Please write a query that will show each players favorite product.
SELECT
    c.Title,
    c.FirstName,
    c.LastName,
    (
        SELECT p.Product
        FROM Products AS p
        JOIN Betting AS b ON p.ClassId = b.class_id
        JOIN test_data AS t ON b.account_no = t.account_no
        WHERE t.cust_id = c.CustId
        ORDER BY b.bet_amt DESC
        LIMIT 1
    ) AS Product,
    IFNULL(MAX(b.bet_amt), 0) AS highest_stake
FROM
    Customers AS c
LEFT JOIN
    test_data AS t ON c.CustId = t.cust_id
LEFT JOIN
    Betting AS b ON t.account_no = b.account_no
GROUP BY
    c.CustId, c.Title, c.FirstName, c.LastName
ORDER BY
    c.FirstName, c.LastName;

    

-- Looking at the abstract data on the "Student_School" tab into the Excel spreadsheet, please answer the below questions:
-- Question 11: Write a query that returns the top 5 students based on GPA.
SELECT
s.student_name,
s.GPA
FROM student as s
ORDER BY GPA DESC
LIMIT 5;

-- Question 12: Write a query that returns the number of students in each school. (a school should be in the output even if it has no students!).

SELECT
sc.school_id,
sc.school_name,
COUNT(student_id)
FROM school as sc
LEFT JOIN
student AS st on sc.school_id = st.school_id
GROUP BY sc.school_id, sc.school_name
ORDER BY COUNT(student_id) DESC;

-- Question 13: Write a query that returns the top 3 GPA students' name from each university.

WITH RankedStudents AS (
    SELECT
        sc.school_id,
        sc.school_name,
        st.student_name,
        st.GPA,
        ROW_NUMBER() OVER (PARTITION BY sc.school_id ORDER BY st.GPA DESC) AS student_rank
    FROM school AS sc
    LEFT JOIN student AS st 
        ON sc.school_id = st.school_id
)
SELECT
    school_id,
    school_name,
    student_name,
    GPA
FROM RankedStudents
WHERE student_rank <= 3
ORDER BY school_id, student_rank;
