-- Create a new database named `sqltestdata`
CREATE DATABASE sqltestdata;

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

-- Create the `school` table
CREATE TABLE school (
    school_id INT PRIMARY KEY,         -- Primary key for the school
    school_name VARCHAR(255) NOT NULL, -- Name of the school
    school_city VARCHAR(255) NOT NULL  -- City where the school is located
);

-- Create the `student` table
CREATE TABLE student (
    student_id INT PRIMARY KEY,         -- Primary key for the student
    student_name VARCHAR(255) NOT NULL, -- Name of the student
    city VARCHAR(255) NOT NULL,         -- City of the student
    school_id INT,                      -- Foreign key referencing the school_id
    GPA FLOAT,                          -- Grade Point Average
    FOREIGN KEY (school_id) REFERENCES school(school_id) ON DELETE CASCADE
);

-- Create the `account` table
CREATE TABLE account (
    account_no INT PRIMARY KEY,        -- Account number
    cust_id INT NOT NULL,              -- Customer ID
    account_location VARCHAR(255),    -- Account location
    currency_code VARCHAR(10),        -- Currency code
    daily_deposit_limit DECIMAL(10,2),-- Daily deposit limit
    stake_scale DECIMAL(10,2),        -- Stake scale
    source_prod VARCHAR(255)          -- Source product
);

-- Create the `betting_1` table
CREATE TABLE betting_1 (
    AccountNo INT NOT NULL,               -- Account number (foreign key to account)
    BetDate DATE,                         -- Date of the bet
    ClassId INT,                          -- Class ID
    CategoryId INT,                       -- Category ID
    Source VARCHAR(255),                  -- Source of the bet
    BetCount INT,                         -- Bet count
    Bet_Amt DECIMAL(10,2),                -- Bet amount
    Win_Amt DECIMAL(10,2),                -- Win amount
    Product VARCHAR(255),                 -- Product associated with the bet
    FOREIGN KEY (AccountNo) REFERENCES account(account_no) ON DELETE CASCADE
);

-- Create the `betting_2` table
CREATE TABLE betting_2 (
    AccountNo INT NOT NULL,               -- Account number (foreign key to account)
    Bet_Amt DECIMAL(10,2),                -- Bet amount
    Product VARCHAR(255),                 -- Product associated with the bet
    FOREIGN KEY (AccountNo) REFERENCES account(account_no) ON DELETE CASCADE
);

-- Create the `betting_3` table
CREATE TABLE betting_3 (
    AccountNo INT NOT NULL,               -- Account number (foreign key to account)
    Vegas DECIMAL(10,2),                  -- Vegas-related value
    Sportsbook DECIMAL(10,2),             -- Sportsbook-related value
    Games DECIMAL(10,2),                  -- Games-related value
    Casino DECIMAL(10,2),                 -- Casino-related value
    Poker DECIMAL(10,2),                  -- Poker-related value
    Bingo DECIMAL(10,2),                  -- Bingo-related value
    N_A DECIMAL(10,2),                    -- Unspecified column
    Adjustments DECIMAL(10,2),            -- Adjustments
    FOREIGN KEY (AccountNo) REFERENCES account(account_no) ON DELETE CASCADE
);

-- Create the `customer` table
CREATE TABLE customer (
    cust_id INT PRIMARY KEY,              -- Customer ID
    account_location VARCHAR(255),       -- Account location
    title VARCHAR(50),                   -- Title (e.g., Mr., Ms.)
    first_name VARCHAR(255),             -- First name
    last_name VARCHAR(255),              -- Last name
    create_date DATE,                    -- Account creation date
    country_code VARCHAR(10),            -- Country code
    language VARCHAR(50),                -- Preferred language
    status VARCHAR(50),                  -- Customer status (e.g., active/inactive)
    date_of_birth DATE,                  -- Date of birth
    contact VARCHAR(255),                -- Contact information
    customer_group VARCHAR(255)          -- Customer group/category
);

-- Create the `product` table
CREATE TABLE product (
    class_id INT PRIMARY KEY,            -- Class ID
    category_id INT,                     -- Category ID
    product_name VARCHAR(255) NOT NULL,  -- Product name
    sub_product VARCHAR(255),            -- Sub-product name
    description TEXT,                    -- Product description
    bet_or_play VARCHAR(50)              -- Indicates if it's a bet or play type
);
