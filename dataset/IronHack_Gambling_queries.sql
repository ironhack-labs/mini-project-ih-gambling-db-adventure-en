USE IRONHACK_GAMBLING;

# Question 01: Using the customer table or tab, please write an SQL query that shows Title, First Name and Last Name and Date of Birth for each of the customers.
SELECT Customer.Title, Customer.FirstName, Customer.LastName, Customer.DateOfBirth
FROM Customer;

# Question 02: Using customer table or tab, please write an SQL query that shows the number of customers in each customer group (Bronze, Silver & Gold). I can see visually that there are 4 Bronze, 3 Silver and 3 Gold
SELECT CustomerGroup, COUNT(*) AS number_of_customers
FROM Customer
GROUP BY CustomerGroup;

# Question 03: The CRM manager has asked me to provide a complete list of all data for those customers in the customer table but I need to add the currencycode of each player so she will be able to send the right offer in the right currency. Note that the currencycode does not exist in the customer table but in the account table. Please write the SQL that would facilitate this.
# BONUS: How would I do this in Excel if I had a much larger data set?
SELECT Customer.*, Account.CurrencyCode
FROM Customer
JOIN Account ON Customer.CustId = Account.CustId;
# BONUS Answer: You can load the data into PowerQuery and then you can merge the tables as well.

# Question 04: Now I need to provide a product manager with a summary report that shows, by product and by day how much money has been bet on a particular product. PLEASE note that the transactions are stored in the betting table and there is a product code in that table that is required to be looked up (classid & categortyid) to determine which product family this belongs to. Please write the SQL that would provide the report.
# BONUS: If you imagine that this was a much larger data set in Excel, how would you provide this report in Excel?
SELECT Product, ClassId, CategoryId, BetDate, SUM(Bet_Amt) AS overall_daily_bets
FROM Betting
GROUP BY Product, ClassId, CategoryId, BetDate
ORDER BY BetDate;

# Question 05: You’ve just provided the report from question 4 to the product manager, now he has emailed me and wants it changed. Can you please amend the summary report so that it only summarizes transactions that occurred on or after 1st November and he only wants to see Sportsbook transactions.Again, please write the SQL below that will do this.
# BONUS: If I were delivering this via Excel, how would I do this?
SELECT Product, ClassId, CategoryId, BetDate, SUM(Bet_Amt) AS overall_daily_bets
FROM Betting
WHERE BetDate > '2012-11-01' AND PRODUCT = 'Sportsbook'
GROUP BY Product, ClassId, CategoryId, BetDate
ORDER BY BetDate;

# Question 06: As often happens, the product manager has shown his new report to his director and now he also wants different version of this report. This time, he wants the all of the products but split by the currencycode and customergroup of the customer, rather than by day and product. He would also only like transactions that occurred after 1st December. Please write the SQL code that will do this.
SELECT 
    Account.CurrencyCode, 
    Customer.CustomerGroup, 
    Product.product, 
    SUM(Betting.Bet_Amt) AS total_bets
FROM 
    Customer
LEFT JOIN 
    Account ON Customer.CustId = Account.CustId
LEFT JOIN 
    Betting ON Account.AccountNo = Betting.AccountNo
LEFT JOIN 
    Product ON Betting.product = Product.product
WHERE 
    Betting.BetDate > DATE('2012-12-01')
GROUP BY 
    Account.CurrencyCode, 
    Customer.CustomerGroup, 
    Product.product
ORDER BY 
    Account.CurrencyCode, 
    Customer.CustomerGroup;


# Question 07: Our VIP team have asked to see a report of all players regardless of whether they have done anything in the complete timeframe or not. In our example, it is possible that not all of the players have been active. Please write an SQL query that shows all players Title, First Name and Last Name and a summary of their bet amount for the complete period of November.
SELECT 
    Customer.Title, 
    Customer.FirstName, 
    Customer.LastName, 
    SUM(Betting.Bet_Amt) AS bets_per_player
FROM 
    Account
LEFT JOIN 
    Customer ON Account.CustId = Customer.CustId
LEFT JOIN 
    Betting ON Account.AccountNo = Betting.AccountNo
WHERE 
    Betting.BetDate >= DATE('2012-11-01') AND Betting.BetDate <= DATE('2012-11-30')
GROUP BY 
    Customer.Title, Customer.FirstName, Customer.LastName
ORDER BY 
    Customer.LastName ASC;
    
    
# Question 08: Our marketing and CRM teams want to measure the number of players who play more than one product. Can you please write 2 queries, one that shows the number of products per player and another that shows players who play both Sportsbook and Vegas.
-- Query 1:
SELECT 
    Customer.CustId, 
    Customer.FirstName, 
    Customer.LastName, 
    COUNT(DISTINCT Betting.Product) AS products_played
FROM 
    Betting
JOIN 
    Account ON Betting.AccountNo = Account.AccountNo
JOIN 
    Customer ON Account.CustId = Customer.CustId
GROUP BY 
    Customer.CustId, Customer.FirstName, Customer.LastName
HAVING 
    products_played > 1;
-- Query 2:
SELECT 
    Customer.CustId, 
    Customer.FirstName, 
    Customer.LastName
FROM 
    Betting
JOIN 
    Account ON Betting.AccountNo = Account.AccountNo
JOIN 
    Customer ON Account.CustId = Customer.CustId
WHERE 
    Betting.Product IN ('Sportsbook', 'Vegas')
GROUP BY 
    Customer.CustId, Customer.FirstName, Customer.LastName
HAVING 
    COUNT(DISTINCT Betting.Product) = 2;


# Question 09: Now our CRM team want to look at players who only play one product, please write SQL code that shows the players who only play at sportsbook, use the bet_amt > 0 as the key. Show each player and the sum of their bets for both products.
SELECT 
    Customer.FirstName, 
    Customer.LastName, 
    Product.Product, 
    COUNT(DISTINCT Product.Product)
FROM 
    Customer
JOIN 
    Account ON Account.CustId = Customer.CustId
JOIN 
    Betting ON Account.AccountNo = Betting.AccountNo
JOIN 
    Product ON Betting.Product = Product.Product
WHERE 
    Betting.Bet_Amt > 0 AND product.product = 'Sportsbook'
GROUP BY 
    Customer.FirstName, Customer.LastName, Product.Product
ORDER BY 
    Customer.LastName, Product.Product;
    
# Question 10: The last question requires us to calculate and determine a player’s favorite product. This can be determined by the most money staked. Please write a query that will show each players favorite product.
SELECT 
    Customer.FirstName, 
    Customer.LastName, 
    Product.Product,
    PlayerBets.total_bets
FROM 
    Customer
JOIN 
    Account ON Account.CustId = Customer.CustId
JOIN 
    Betting ON Account.AccountNo = Betting.AccountNo
JOIN 
    Product ON Betting.Product = Product.Product
JOIN (
    SELECT 
        Account.CustId, 
        Betting.Product, 
        SUM(Betting.Bet_Amt) AS total_bets
    FROM 
        Account
    JOIN 
        Betting ON Account.AccountNo = Betting.AccountNo
    GROUP BY 
        Account.CustId, Betting.Product
) AS PlayerBets 
ON PlayerBets.CustId = Customer.CustId AND PlayerBets.Product = Betting.Product
WHERE PlayerBets.total_bets = (
    SELECT 
        MAX(total_bets)
    FROM (
        SELECT 
            Account.CustId, 
            Betting.Product, 
            SUM(Betting.Bet_Amt) AS total_bets
        FROM 
            Account
        JOIN 
            Betting ON Account.AccountNo = Betting.AccountNo
        GROUP BY 
            Account.CustId, Betting.Product
    ) AS BetsPerPlayer
    WHERE BetsPerPlayer.CustId = PlayerBets.CustId
)
ORDER BY 
    Customer.LastName;

# Question 11: Write a query that returns the top 5 students based on GPA.
SELECT student_name
FROM student
ORDER BY GPA DESC
LIMIT 5;

# Question 12: Write a query that returns the number of students in each school. (a school should be in the output even if it has no students!).
SELECT 
    school.school_name, 
    COUNT(student.student_id) AS number_of_students
FROM 
    school
LEFT JOIN 
    student ON school.school_id = student.school_id
GROUP BY 
    school.school_name;
    
# Question 13: Write a query that returns the top 3 GPA students' name from each university.
SELECT student.student_name, school.school_name, student.GPA
FROM student
JOIN school ON student.school_id = school.school_id
WHERE (
    SELECT COUNT(*) 
    FROM student AS s2
    WHERE s2.school_id = student.school_id
    AND s2.GPA > student.GPA
) < 3
ORDER BY school.school_name, student.GPA DESC
LIMIT 3;


