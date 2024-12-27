-- Create a new database named `sqltestdata`
CREATE DATABASE IF NOT EXISTS sqltestdata;

-- Use the `sqltestdata` database
USE sqltestdata;

/*
-- Drop existing tables if they exist
DROP TABLE IF EXISTS student;
DROP TABLE IF EXISTS school;
DROP TABLE IF EXISTS account;
DROP TABLE IF EXISTS betting;
DROP TABLE IF EXISTS betting_1;
DROP TABLE IF EXISTS betting_2;
DROP TABLE IF EXISTS betting_3;
DROP TABLE IF EXISTS customer;
DROP TABLE IF EXISTS product;
DROP TABLE IF EXISTS student_school;
*/

-- Create the `customer` table
CREATE TABLE customer (
    cust_id INT PRIMARY KEY,
    account_location VARCHAR(255),
    title VARCHAR(50),
    first_name VARCHAR(255),
    last_name VARCHAR(255),
    create_date DATE,
    country_code VARCHAR(10),
    language VARCHAR(50),
    status VARCHAR(50),
    date_of_birth DATE,
    contact VARCHAR(255),
    customer_group VARCHAR(255)
);


-- Create the `account` table
CREATE TABLE account (
    AccountNo INT PRIMARY KEY,
    cust_id INT NOT NULL,
    account_location VARCHAR(255),
    currency_code VARCHAR(10),
    daily_deposit_limit DECIMAL(10,2),
    stake_scale DECIMAL(10,2),
    source_prod VARCHAR(255),
    FOREIGN KEY (cust_id) REFERENCES customer(cust_id)
);

-- Create the `betting_1` table
CREATE TABLE betting_1 (
    AccountNo INT NOT NULL,
    BetDate DATE,
    ClassId INT,
    CategoryId INT,
    Source VARCHAR(255),
    BetCount INT,
    Bet_Amt DECIMAL(10,2),
    Win_Amt DECIMAL(10,2),
    Product VARCHAR(255),
    FOREIGN KEY (AccountNo) REFERENCES account(AccountNo) ON DELETE CASCADE
);

-- Create the `betting_2` table
CREATE TABLE betting_2 (
    AccountNo INT NOT NULL,
    Bet_Amt DECIMAL(10,2),
    Product VARCHAR(255),
    FOREIGN KEY (AccountNo) REFERENCES account(AccountNo) ON DELETE CASCADE
);

-- Create the `betting_3` table
CREATE TABLE betting_3 (
    AccountNo INT NOT NULL,
    Vegas DECIMAL(10,2),
    Sportsbook DECIMAL(10,2),
    Games DECIMAL(10,2),
    Casino DECIMAL(10,2),
    Poker DECIMAL(10,2),
    Bingo DECIMAL(10,2),
    N_A DECIMAL(10,2),
    Adjustments DECIMAL(10,2),
    FOREIGN KEY (AccountNo) REFERENCES account(AccountNo) ON DELETE CASCADE
);

-- Create the `product` table
CREATE TABLE product (
    class_id INT PRIMARY KEY,
    category_id INT,
    product_name VARCHAR(255) NOT NULL,
    sub_product VARCHAR(255),
    description TEXT,
    bet_or_play VARCHAR(50)
);
-- Create the `school` table
CREATE TABLE school (
    school_id INT PRIMARY KEY,         
    school_name VARCHAR(255) NOT NULL,
    school_city VARCHAR(255) NOT NULL
);

-- Create the `student` table
CREATE TABLE student (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(255) NOT NULL,
    city VARCHAR(255) NOT NULL,
    school_id INT,
    GPA FLOAT,
    FOREIGN KEY (school_id) REFERENCES school(school_id) ON DELETE CASCADE
);







