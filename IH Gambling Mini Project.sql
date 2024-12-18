/* Mini Project - IH Gambling DB Adventure
   Data was generated using Ironhack_gambling.ipynrb on JupyterLab.*/
   
/*Question 01 - Write a query that shows Title, First Name and Last Name, and Date of Birth
for each of the customers.*/

SELECT
	Title,
    FirstName,
    LastName,
    DateOfBirth
FROM 
	customer;

/*Question 02 - Query that shows the number of customers in each group (Bronze, Silver & Gold)*/
SELECT
	CustomerGroup,
    COUNT(*) AS customer_count
FROM
	customer
GROUP BY 
	CustomerGroup;

/*Question 03 - Generates a list of all customers, but with their corresponding currency code added as well*/
SELECT
    c.*,
    a.CurrencyCode
FROM
    customer AS c
INNER JOIN
	Account as a ON c.CustID = a.CustID;
    


/*Question 04 - Generates a summary report that shows, by product and by day, how much 
money has been bet on a particular product.*/
SELECT
    p.Product,
    b.BetDate,
    SUM(b.Bet_Amt) AS total_bets
FROM
    betting AS b
INNER JOIN
	Product AS p ON b.ClassID AND b.CategoryID = p.CategoryID
GROUP BY
    p.Product, b.BetDate
ORDER BY
    b.BetDate, p.Product;

/* Delete if not using these checks */    
#SHOW COLUMNS FROM betting FROM IH_Gambling;
#DESCRIBE betting;
#SELECT * FROM betting WHERE BetDate >= '2012-11-01 00:00:00';
#SELECT DISTINCT b.BetDate, b.Product
#FROM betting AS b
#WHERE b.Product = 'Sportsbook'
#ORDER BY b.BetDate;

/*Question 05 - Change the query in #4 so that it only summarizes transactions on or after
November 1st, and only for Sportsbook transactions.*/
SELECT
    p.Product,
    b.BetDate,
    SUM(b.Bet_Amt) AS total_bets
FROM
    betting AS b
INNER JOIN
	product as p ON b.ClassID = p.ClassID AND b.CategoryId = p.CATEGORYID
WHERE
    b.BetDate >= '2012-11-01' AND p.Product = 'Sportsbook'
GROUP BY
    p.Product,
    b.BetDate
ORDER BY
	b.BetDate,
    p.Product;
    
/* Question 06 - All of the products split by the currencycode and cvustomer group. 
   betting. Only transactions after Dec. 1st are included.*/
SELECT
    b.BetDate,
    b.Product,
    SUM(b.Bet_Amt) AS total_bets,
    b.AccountNo,
    a.CustId,
    a.CurrencyCode,
    c.CustomerGroup
    
FROM
    betting AS b
JOIN
    account AS a ON b.AccountNo = a.AccountNo
JOIN
    customer AS c ON a.CustId = c.CustId
GROUP BY
    b.BetDate, b.Product, b.AccountNo, a.AccountNo, a.CustId, c.CustomerGroup, a.CurrencyCode;
    
    /*Question 07 - generates a report of all players regardless of whether they have done
      anything during November. Includes title, first name, last name, and the sum of their bets.*/
SELECT 
    c.Title, 
    c.FirstName, 
    c.LastName, 
    COALESCE(SUM(b.Bet_Amt), 0) AS total_bets_november
FROM 
    customer AS c
LEFT JOIN 
    account AS a ON c.CustId = a.CustId
LEFT JOIN 
    betting AS b ON a.AccountNo = b.AccountNo AND b.BetDate BETWEEN '2012-11-01' AND '2012-11-30'
GROUP BY 
    c.Title, 
    c.FirstName, 
    c.LastName;

    
/*Question 08 - measures then number of players that play more than one product.
  Presents two queries: one with the number of products per player and another 
  listing those that play both Vegas and Sportsbook.*/

/*Counts the number of products per customer.*/
SELECT 
    c.CustId, 
    c.FirstName, 
    c.LastName, 
    COUNT(DISTINCT b.Product) AS product_count
FROM 
    Customer AS c
INNER JOIN 
    Account AS a ON c.CustId = a.CustId
INNER JOIN 
    Betting AS b ON a.AccountNo = b.AccountNo
GROUP BY 
    c.CustId, 
    c.FirstName, 
    c.LastName
HAVING 
    product_count > 1;

/*Players who play both Sportsbook and Vegas.*/
SELECT 
    c.CustId, 
    c.FirstName, 
    c.LastName
FROM 
    customer AS c
INNER JOIN 
    account AS a ON c.CustId = a.CustId
INNER JOIN 
    betting AS b ON a.AccountNo = b.AccountNo
WHERE 
    b.Product IN ('Sportsbook', 'Vegas')
GROUP BY 
    c.CustId, 
    c.FirstName, 
    c.LastName
HAVING 
    COUNT(DISTINCT b.Product) = 2;
    
    /*Question 09 - Generate a query of players who only play at
	  Sportsbook, using the bet_amt>0 as the key. Shows each player
      and the sum of their bets for both products (not sure about this last part)*/
SELECT
    c.CustID,
    c.FirstName,
    c.LastName,
    SUM(b.Bet_Amt) AS total_bets_sportsbook
FROM
    customer AS c
INNER JOIN
    account AS a ON c.CustID = a.CustID
INNER JOIN
    betting AS b ON a.AccountNo = b.AccountNo
WHERE
    b.Product = 'Sportsbook'
    AND b.Bet_Amt > 0
    AND c.CustID NOT IN (
        SELECT DISTINCT c2.CustID
        FROM customer AS c2
        INNER JOIN account AS a2 ON c2.CustID = a2.CustID
        INNER JOIN betting AS b2 ON a2.AccountNo = b2.AccountNo
        WHERE b2.Product <> 'Sportsbook'
    )
GROUP BY
    c.CustID, c.FirstName, c.LastName;

/* Question 10 - player's favorite product based on their highest bet amount.*/
SELECT 
    c.CustId, 
    c.FirstName, 
    c.LastName, 
    b.Product, 
    SUM(b.Bet_Amt) AS total_bet_amount
FROM 
    customer AS c
INNER JOIN 
    account AS a ON c.CustId = a.CustId
INNER JOIN 
    betting AS b ON a.AccountNo = b.AccountNo
GROUP BY 
    c.CustId, 
    c.FirstName, 
    c.LastName, 
    b.Product
HAVING 
    total_bet_amount = (
        SELECT MAX(SUM(b2.Bet_Amt))
        FROM Betting AS b2
        INNER JOIN Account AS a2 ON b2.AccountNo = a2.AccountNo
        WHERE a2.CustId = c.CustId
        GROUP BY b2.Product
    );
    
/* Question 11 - identifies top 5 students by gpa*/
SELECT 
    student_name, GPA
FROM 
    student
ORDER BY 
    GPA DESC;
LIMIT 5;

/* Question 12 - returns the number of students in each school.
   Schools with no students should also appear on the list.*/
SELECT 
    school_name, 
    COUNT(*) AS student_count
FROM 
    school
GROUP BY 
    school_name;   
    
/* Question 13 - identifies the top 3 students, based on gpa, per school.*/
SELECT 
    ranked_students.school_id_1, 
    ranked_students.student_name, 
    ranked_students.GPA
FROM 
    (
        SELECT
			sc.school_id_1, 
			st.student_name, 
            st.GPA, 
            RANK() OVER (PARTITION BY sc.school_id_1 ORDER BY st.GPA DESC) AS ranking
        FROM 
            student AS st
		INNER JOIN
			school AS sc ON st.city = sc.city_1
    ) AS ranked_students
WHERE 
    ranking <= 3;