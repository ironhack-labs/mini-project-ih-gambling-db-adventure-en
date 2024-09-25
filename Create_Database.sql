DROP DATABASE IF EXISTS Ironhack_gambling;
CREATE DATABASE Ironhack_gambling;

USE Ironhack_gambling;

CREATE TABLE Customers (
    CustId INT PRIMARY KEY,
    AccountLocation VARCHAR(10),
    Title VARCHAR(5),
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    CreateDate DATE,
    CountryCode VARCHAR(5),
    Language VARCHAR(5),
    Status CHAR(1),
    DateOfBirth DATE,
    Contact CHAR(1),
    CustomerGroup VARCHAR(20)
);

CREATE TABLE Betting (
    id INT AUTO_INCREMENT PRIMARY KEY,
    account_no VARCHAR(10),
    bet_date DATE,
    class_id VARCHAR(20),
    category_id INT,
    source CHAR(1),
    bet_count INT,
    bet_amt DECIMAL(10,2),
    win_amt DECIMAL(10,2),
    product VARCHAR(50),
    UNIQUE (account_no, id)  -- Composite unique key for (account_no, id)
);

CREATE TABLE Products (
    ClassId VARCHAR(20),
    CategoryId INT,
    Product VARCHAR(50),
    Sub_Product VARCHAR(50),
    Description VARCHAR(100),
    Bet_Or_Play INT
);

CREATE TABLE School (
    school_id INT PRIMARY KEY,
    school_name VARCHAR(100),
    city VARCHAR(50)
);

CREATE TABLE Student (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(50),
    city VARCHAR(50),
    school_id INT,
    GPA DECIMAL(3,2),
    FOREIGN KEY (school_id) REFERENCES School(school_id)
);

CREATE TABLE Test_data (
    account_no VARCHAR(10),
    id INT,  -- Include id from Betting as a foreign key
    cust_id INT,
    account_location VARCHAR(3),
    currency_code VARCHAR(3),
    daily_deposit_limit DECIMAL(10, 2),
    stake_scale INT,
    source_prod VARCHAR(2),
    FOREIGN KEY (cust_id) REFERENCES Customers(CustId),
    FOREIGN KEY (account_no, id) REFERENCES Betting(account_no, id)  -- Composite foreign key reference
);
