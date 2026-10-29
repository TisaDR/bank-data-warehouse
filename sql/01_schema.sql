CREATE SCHEMA IF NOT EXISTS warehouse;

CREATE TABLE IF NOT EXISTS warehouse.dim_branch(
    branch_key INT PRIMARY KEY,
    branch_name VARCHAR(100) NOT NULL,
    city VARCHAR(100)
    );


CREATE TABLE IF NOT EXISTS     warehouse.dim_customer(
    customer_key INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(150) UNIQUE,
    province VARCHAR(2),
    created_date DATE
);


CREATE TABLE IF NOT EXISTS warehouse.dim_account (
    account_key    INT PRIMARY KEY,
    account_number VARCHAR(20) UNIQUE NOT NULL,
    customer_key   INT REFERENCES warehouse.dim_customer(customer_key),
    branch_key     INT REFERENCES warehouse.dim_branch(branch_key),
    account_type   VARCHAR(20),
    open_date      DATE
);

CREATE TABLE IF NOT EXISTS warehouse.dim_date (
    date_key    INT PRIMARY KEY,
    full_date   DATE NOT NULL,
    year        INT,
    month       INT,
    day         INT,
    day_name    VARCHAR(10),
    is_weekend  BOOLEAN
);

CREATE TABLE IF NOT EXISTS warehouse.fact_transactions (
    transaction_key  INT PRIMARY KEY,
    account_key      INT REFERENCES warehouse.dim_account(account_key),
    date_key         INT REFERENCES warehouse.dim_date(date_key),
    branch_key       INT REFERENCES warehouse.dim_branch(branch_key),
    amount           NUMERIC(12,2) NOT NULL,
    transaction_type VARCHAR(20) NOT NULL,
    is_fraud         BOOLEAN DEFAULT FALSE
);