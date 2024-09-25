CREATE DATABASE IF NOT EXISTS IRONHACK_GAMBLING;

USE IRONHACK_GAMBLING;
SET GLOBAL local_infile = 1;

CREATE TABLE Account (
AccountNo VARCHAR(10) NOT NULL,
CustId VARCHAR(10) NOT NULL,
AccountLocation VARCHAR(3) NOT NULL,
CurrencyCode VARCHAR(3) NOT NULL,
DailyDepositLimit INT DEFAUlT NULL,
StakeScale INT DEFAULT NULL,
SourceProd VARCHAR(2) NOT NULL);

INSERT INTO Account (AccountNo, CustId, AccountLocation, CurrencyCode, DailyDepositLimit, StakeScale, SourceProd)
VALUES
    ('00357DG', '3531845', 'GIB', 'GBP', 0, 1, 'GM'),
    ('00497XG', '4188499', 'GIB', 'GBP', 0, 1, 'SB'),
    ('00692VS', '4709425', 'GIB', 'USD', 0, 2, 'SB'),
    ('00775SM', '2815836', 'GIB', 'USD', 0, 1, 'SB'),
    ('00C017', '8898782', 'GIB', 'GBP', 1500, 0, 'XX'),
    ('00381', '1191874', 'GIB', 'GBP', 500, 8, 'XX'),
    ('01148BP', '1569944', 'GIB', 'GBP', 0, 8, 'XX'),
    ('01152SJ', '1965214', 'GIB', 'USD', 0, 1, 'PO'),
    ('01196ZZ', '3042166', 'GIB', 'EUR', 0, 8, 'SB'),
    ('01284UW', '5694730', 'GIB', 'GBP', 0, 1, 'SB');

CREATE TABLE Customer (
    CustId INT PRIMARY KEY,
    AccountLocation VARCHAR(3),
    Title VARCHAR(10),
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    CreateDate DATE,
    CountryCode VARCHAR(2),
    Language VARCHAR(10),
    Status CHAR(1),
    DateOfBirth DATE,
    Contact CHAR(1),
    CustomerGroup VARCHAR(10)
);



INSERT INTO Customer (CustId, AccountLocation, Title, FirstName, LastName, CreateDate, CountryCode, Language, Status, DateOfBirth, Contact, CustomerGroup)
VALUES
(4188499, 'GIB', 'Mr', 'Elvis', 'Presley', '2011-11-01', 'US', 'en', 'A', '1948-10-18', 'Y', 'Bronze'),
(1191874, 'GIB', 'Mr', 'Jim', 'Morrison', '2008-09-19', 'US', 'en', 'A', '1967-07-27', 'Y', 'Gold'),
(3042166, 'GIB', 'Mr', 'Keith', 'Moon', '2011-01-11', 'UK', 'en', 'A', '1970-07-26', 'Y', 'Gold'),
(5694730, 'GIB', 'Mr', 'James', 'Hendrix', '2012-10-10', 'US', 'en', 'A', '1976-04-05', 'N', 'Bronze'),
(4704925, 'GIB', 'Mr', 'Marc', 'Bolan', '2012-03-26', 'UK', 'en', 'A', '1982-03-11', 'Y', 'Bronze'),
(1569944, 'GIB', 'Miss', 'Janice', 'Joplin', '2009-04-09', 'US', 'en', 'A', '1954-08-22', 'Y', 'Gold'),
(3531845, 'GIB', 'Mr', 'Bon', 'Scott', '2011-04-02', 'AU', 'en', 'A', '1975-10-22', 'N', 'Silver'),
(2815836, 'GIB', 'Mr', 'Buddy', 'Holly', '2010-10-17', 'US', 'en', 'A', '1964-01-13', 'Y', 'Silver'),
(889782, 'GIB', 'Mr', 'Bob', 'Marley', '2008-01-16', 'UK', 'en', 'A', '1964-04-18', 'Y', 'Silver'),
(1965214, 'GIB', 'Mr', 'Sidney', 'Vicious', '2009-12-18', 'UK', 'en', 'A', '1976-08-12', 'N', 'Bronze');

CREATE TABLE Betting (
    AccountNo VARCHAR(10),
    BetDate DATE,
    ClassId VARCHAR(20),
    CategoryId INT,
    Source VARCHAR(10),
    BetCount INT,
    Bet_Amt DECIMAL(10,2),
    Win_Amt DECIMAL(10,2),
    Product VARCHAR(20),
    Vegas DECIMAL(10,2),
    Sportsbook DECIMAL(10,2),
    Games DECIMAL(10,2),
    Casino DECIMAL(10,2),
    Poker DECIMAL(10,2),
    Bingo DECIMAL(10,2),
    Adjustments DECIMAL(10,2)
);

CREATE TABLE Betting_Stats (
    AccountNo VARCHAR(10),
    Vegas DECIMAL(10,3),
    Sportsbook DECIMAL(10,3),
    Games DECIMAL(10,3),
    Casino DECIMAL(10,3),
    Poker DECIMAL(10,3),
    Bingo DECIMAL(10,3),
    Adjustments DECIMAL(10,3)
);

INSERT INTO Betting_Stats (AccountNo, Vegas, Sportsbook, Games, Casino, Poker, Bingo, Adjustments)
VALUES ('01196ZZ', 89.861, 42.758, NULL, NULL, 1.262, NULL, NULL);

INSERT INTO Betting_Stats (AccountNo, Vegas, Sportsbook, Games, Casino, Poker, Bingo, Adjustments)
VALUES ('00357DG', 191.805, 100, 16.900, NULL, 20, 50, 295);

INSERT INTO Betting_Stats (AccountNo, Vegas, Sportsbook, Games, Casino, Poker, Bingo, Adjustments)
VALUES ('01284UW', 152.613, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO Betting_Stats (AccountNo, Vegas, Sportsbook, Games, Casino, Poker, Bingo, Adjustments)
VALUES ('01148BP', 7.030, 290.958, NULL, NULL, NULL, 500, NULL);

INSERT INTO Betting_Stats (AccountNo, Vegas, Sportsbook, Games, Casino, Poker, Bingo, Adjustments)
VALUES ('00497XG', NULL, NULL, 25.785, NULL, NULL, NULL, NULL);

INSERT INTO Betting_Stats (AccountNo, Vegas, Sportsbook, Games, Casino, Poker, Bingo, Adjustments)
VALUES ('01152SJ', NULL, NULL, NULL, 43.494, NULL, 46.893, NULL);

INSERT INTO Betting_Stats (AccountNo, Vegas, Sportsbook, Games, Casino, Poker, Bingo, Adjustments)
VALUES ('00C017', NULL, NULL, NULL, NULL, NULL, 17.465, 2.143);

INSERT INTO Betting_Stats (AccountNo, Vegas, Sportsbook, Games, Casino, Poker, Bingo, Adjustments)
VALUES ('00381', NULL, 36.855, NULL, NULL, NULL, NULL, 826);

INSERT INTO Betting_Stats (AccountNo, Vegas, Sportsbook, Games, Casino, Poker, Bingo, Adjustments)
VALUES ('00775SM', 118, 46, 141, NULL, 20, 993, NULL);

CREATE TABLE Product (
    ClassID VARCHAR(20),
    CategoryID INT,
    Product VARCHAR(50),
    Sub_Product VARCHAR(50),
    Description VARCHAR(100),
    Bet_Or_Play TINYINT
);

INSERT INTO Product (ClassID, CategoryID, Product, Sub_Product, Description, Bet_Or_Play)
VALUES ('22522_SALE', 22522, 'Vegas', 'Vegas Bonus', 'Vegas', 0);

INSERT INTO Product (ClassID, CategoryID, Product, Sub_Product, Description, Bet_Or_Play)
VALUES ('BETC_RET', 0, 'Sportsbook', 'Various', 'Bet Corrections', 0);

INSERT INTO Product (ClassID, CategoryID, Product, Sub_Product, Description, Bet_Or_Play)
VALUES ('BONS_GAM', 0, 'Games', 'Games Bonus', 'Games Bonus', 0);

INSERT INTO Product (ClassID, CategoryID, Product, Sub_Product, Description, Bet_Or_Play)
VALUES ('BONS_SPRB', 0, 'Sportsbook', 'SB Bonus', 'SB Bonus', 0);

INSERT INTO Product (ClassID, CategoryID, Product, Sub_Product, Description, Bet_Or_Play)
VALUES ('BONS_VEGA', 0, 'Vegas', 'Vegas Bonus', 'Vegas Bonus', 0);

INSERT INTO Product (ClassID, CategoryID, Product, Sub_Product, Description, Bet_Or_Play)
VALUES ('CSH_PPAL', 0, 'Adjustments', 'Banking Correction', 'PayPal', 0);

INSERT INTO Product (ClassID, CategoryID, Product, Sub_Product, Description, Bet_Or_Play)
VALUES ('GWIL_SPRT', 0, 'Sportsbook', 'Goodwill Payments', 'Goodwill Payments', 0);


INSERT INTO Product (ClassID, CategoryID, Product, Sub_Product, Description, Bet_Or_Play)
VALUES ('1', 1, 'Sportsbook', 'Football', 'UK Football', 1);

INSERT INTO Product (ClassID, CategoryID, Product, Sub_Product, Description, Bet_Or_Play)
VALUES ('2', 1, 'Sportsbook', 'Other Sports', 'Boxing', 1);

INSERT INTO Product (ClassID, CategoryID, Product, Sub_Product, Description, Bet_Or_Play)
VALUES ('15', 2, 'Sportsbook', 'Baseball', 'Baseball', 1);

INSERT INTO Product (ClassID, CategoryID, Product, Sub_Product, Description, Bet_Or_Play)
VALUES ('18', 2, 'Games', 'Reactor', 'Reactor', 1);

INSERT INTO Product (ClassID, CategoryID, Product, Sub_Product, Description, Bet_Or_Play)
VALUES ('19', 1, 'Sportsbook', 'American Football', 'American Football', 1);


INSERT INTO Product (ClassID, CategoryID, Product, Sub_Product, Description, Bet_Or_Play)
VALUES ('22508_RTNS', 22508, 'Bingo', 'Bingo VF', 'Bingo VF Returns', 1);

INSERT INTO Product (ClassID, CategoryID, Product, Sub_Product, Description, Bet_Or_Play)
VALUES ('22527_PRCH', 22527, 'Poker', 'Poker Playtech CashIn', 'Poker Playtech', 1);

INSERT INTO Product (ClassID, CategoryID, Product, Sub_Product, Description, Bet_Or_Play)
VALUES ('22528_SALE', 22528, 'Casino', 'Casino Playtech CashOut', 'Casino Playtech', 1);



CREATE TABLE school (
    school_id INT PRIMARY KEY,
    school_name VARCHAR(100),
    city VARCHAR(50)
);

CREATE TABLE student (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(50),
    city VARCHAR(50),
    school_id INT,
    GPA DECIMAL(3,1),
    FOREIGN KEY (school_id) REFERENCES school(school_id)
    );
    
INSERT INTO school (school_id, school_name, city)
VALUES (1, 'Stanford', 'Stanford'),
       (2, 'University of San Francisco', 'San Francisco'),
       (3, 'Harvard University', 'New York'),
       (4, 'MIT', 'Boston'),
       (5, 'Yale', 'New Haven'),
       (6, 'University College London', 'London'),
       (7, 'Corvinus University', 'Budapest');
       
INSERT INTO student (student_id, student_name, city, school_id, GPA)
VALUES (1001, 'Peter Brebe', 'New York', 1, 4.0),
       (1002, 'John Goorg', 'San Francisco', 2, 3.1),
       (1003, 'Brad Smith', 'New York', 3, 2.9),
       (1004, 'Fabian John', 'Boston', 5, 2.1),
       (1005, 'Brad Camer', 'Stanford', 1, 2.3),
       (1006, 'Geoff Firby', 'Boston', 5, 1.2),
       (1007, 'Johnny Blu', 'New Haven', 2, 3.8),
       (1008, 'Johse Brool', 'Miami', 2, 3.4);

