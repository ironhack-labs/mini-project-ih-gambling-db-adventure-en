CREATE TABLE Account (
  account_num VARCHAR(7) PRIMARY KEY,
  customer_id INT,
  account_location CHAR(3),
  currency_code CHAR(3),
  daily_deposit_limit DECIMAL(10, 2),
  stake_scale DECIMAL(5, 2),
  source_prod VARCHAR(2)
);

CREATE TABLE Betting (
  account_num VARCHAR(7),
  bet_date TIMESTAMP,
  class_id VARCHAR(20),
  category_id INT,
  source CHAR(1),
  bet_count INT,
  bet_amount DECIMAL(10, 2),
  win_amount DECIMAL(10, 2),
  product VARCHAR(20),
  FOREIGN KEY (account_num) REFERENCES Account(account_num)
);


CREATE TABLE Customer (
  cust_id INT PRIMARY KEY,
  account_location CHAR(3),
  title VARCHAR(10),
  first_name VARCHAR(50),
  last_name VARCHAR(50),
  create_date DATE,
  country_code CHAR(2),
  language CHAR(2),
  status CHAR(1),
  date_of_birth DATE,
  contact CHAR(1),
  customer_group VARCHAR(20)
);

CREATE TABLE Product (
  CLASSID VARCHAR(20),
  CATEGORYID INT,
  product VARCHAR(50),
  sub_product VARCHAR(50),
  description VARCHAR(100),
  bet_or_play INT
);