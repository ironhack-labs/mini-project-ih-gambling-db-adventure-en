![logo_ironhack_blue 7](https://user-images.githubusercontent.com/23629340/40541063-a07a0a8a-601a-11e8-91b5-2f13e4e6b441.png)

# Mini Project | The Ironhack Gambling Database Adventure

## Introduction

Welcome to the Ironhack Gambling Database Adventure! This challenge is inspired by a real-life job interview scenario from Ironhack Gambling. It's designed to test your SQL skills in a fun and engaging way. Imagine you're applying for a data analyst role at Ironhack Gambling, and you've been given this challenge to showcase your expertise.

## Scenario

You have been given access to four critical database tables of the Ironhack Gambling Data Warehouse: `Betting`, `Product`, `Customer`, and `Account`. These tables are central to 75% of all queries at IronHack Gambling. For this challenge, a snapshot of data involving 10 players and their transactions is provided. Your task is to demonstrate your SQL prowess by retrieving and manipulating this data to provide valuable insights.

## Challenge Format

- The challenge starts with simple queries and gradually increases in complexity.
- For each question, write your SQL query to find the answer.
- Although the original data is in Excel, focus only on writing SQL queries as if the data were in a SQL database. Whether you test it in MySQL or not is up to you.

## Questions

- **Question 01**:  Using the customer table or tab, please write an SQL query that shows Title, First Name and Last Name and Date of Birth for each of the customers.
- **Question 02**:  Using customer table or tab, please write an SQL query that shows the number of customers in each customer group (Bronze, Silver & Gold). I can see visually that there are 4 Bronze, 3 Silver and 3 Gold but if there were a million customers how would I do this in Excel?
- **Question 03**: The CRM manager has asked me to provide a complete list of all data for those customers in the customer table but I need to add the currencycode of each player so she will be able to send the right offer in the right currency. Note that the currencycode does not exist in the customer table but in the account table. Please write the SQL that would facilitate this. 
  - *BONUS:* How would I do this in Excel if I had a much larger data set?
- **Question 04**: Now I need to provide a product manager with a summary report that shows, by product and by day how much money has been bet on a particular product. PLEASE note that the transactions are stored in the betting table and there is a product code in that table  that is required to be looked up (classid & categortyid) to determine which product family this belongs to. Please write the SQL that would provide the report. 
  - *BONUS:* If you imagine that this was a much larger data set in Excel, how would you provide this report in Excel?
- **Question 05**: You’ve just provided the report from question 4 to the product manager, now he has emailed me and wants it changed. Can you please amend the summary report so that it only summarizes transactions that occurred on or after 1st November and he only wants to see Sportsbook transactions.Again, please write the SQL below that will do this. 
  - *BONUS:* If I were delivering this via Excel, how would I do this?
- **Question 06**: As often happens, the product manager has shown his new report to his director and now he also wants different version of this report. This time, he wants the all of the products but split by the currencycode and customergroup of the customer, rather than by day and product. He would also only like transactions that occurred after 1st December. Please write the SQL code that will do this.
- **Question 07**: Our VIP team have asked to see a report of all players regardless of whether they have done anything in the complete timeframe or not. In our example, it is possible that not all of the players have been active. Please write an SQL query that shows all players Title, First Name and Last Name and a summary of their bet amount for the complete period of November.
- **Question 08**: Our marketing and CRM teams want to measure the number of players who play more than one product. Can you please write 2 queries, one that shows the number of products per player and another that shows players who play both Sportsbook and Vegas.
- **Question 09**: Now our CRM team want to look at players who only play one product, please write SQL code that shows the players who only play at sportsbook, use the bet_amt > 0 as the key. Show each player and the sum of their bets for both products. 
- **Question 10**: The last question requires us to calculate and determine a player’s favorite product. This can be determined by the most money staked. Please write a query that will show each players favorite product.

Looking at the abstract data on the "Student_School" tab into the Excel spreadsheet, please answer the below questions:

- **Question 11**: Write a query that returns the top 5 students based on GPA.
- **Question 12**: Write a query that returns the number of students in each school. (a school should be in the output even if it has no students!).
- **Question 13**: Write a query that returns the top 3 GPA students' name from each university.

## Tips to Participate

- Write or type your SQL answers for each question in a document.
- Feel free to use a separate editor to draft your queries before pasting them here.
- Ensure your queries are well-formatted and easy to understand.

## Submission

- Once you have completed the challenge, submit your answers.
- Showcase your SQL skills and data manipulation expertise.

## Good luck!

Embark on this SQL adventure, and show us the full extent of your data analysis capabilities!
