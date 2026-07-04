/*==============================================================
Project      : Bank Analysis SQL Project
File         : 01_Database_Setup.sql
Description  : Creates the database, tables, constraints,
               and relationships for the Bank Analysis project.
Database     : Bank_Analysis
==============================================================*/

-- =====================================================
-- DATABASE CREATION
-- =====================================================
CREATE DATABASE Bank_Analysis;

USE Bank_Analysis;

-- =====================================================
-- TABLE CREATION
-- =====================================================
CREATE TABLE customers (
    customer_id   VARCHAR(20) PRIMARY KEY,
    first_name    VARCHAR(50),
    last_name     VARCHAR(50),
    gender        VARCHAR(10),
    date_of_birth DATE,
    phone_number  VARCHAR(10),
    pan_number    VARCHAR(10),
    email         VARCHAR(100),
    city          VARCHAR(50),
    state         VARCHAR(50),
    credit_score  INT,
    created_at    DATE
);

CREATE TABLE branches (
    branch_id     VARCHAR(20) PRIMARY KEY,
    branch_name   VARCHAR(100),
    manager_name  VARCHAR(100),
    city          VARCHAR(50),
    state         VARCHAR(50)
);

CREATE TABLE merchants (
    merchant_id    VARCHAR(20) PRIMARY KEY,
    merchant_name  VARCHAR(100),
    category       VARCHAR(50),
    city           VARCHAR(50),
    state          VARCHAR(50)
);

CREATE TABLE accounts (
    account_id     VARCHAR(20) PRIMARY KEY,
    customer_id    VARCHAR(20),
    branch_id      VARCHAR(20),
    account_type   VARCHAR(30),
    balance_usd    DECIMAL(15,2),
    account_status VARCHAR(20),
    open_date      DATE
);

CREATE TABLE cards (
    card_id         VARCHAR(20) PRIMARY KEY,
    account_id      VARCHAR(20),
    card_type       VARCHAR(30),
    expiration_date DATE
);

CREATE TABLE loans (
    loan_id       VARCHAR(20) PRIMARY KEY,
    customer_id   VARCHAR(20),
    loan_type     VARCHAR(50),
    loan_amount   DECIMAL(15,2),
    interest_rate DECIMAL(5,2),
    loan_status   VARCHAR(20),
    start_date    DATE
);

CREATE TABLE transactions (
    transaction_id   VARCHAR(25) PRIMARY KEY,
    account_id       VARCHAR(20),
    merchant_id      VARCHAR(20),
    transaction_type VARCHAR(30),
    payment_mode     VARCHAR(30),
    amount_usd       DECIMAL(15,2),
    status           VARCHAR(20),
    transaction_date DATETIME
);


-- =====================================================
-- CHECK FOR ORPHAN RECORDS
-- =====================================================
--  Accounts → Customers
SELECT *
FROM accounts
WHERE customer_id NOT IN (
    SELECT customer_id FROM customers
); 

-- Cards → Accounts 
SELECT *
FROM cards
WHERE account_id NOT IN (
    SELECT account_id FROM accounts
);

-- Loans → Customers 
SELECT *
FROM loans
WHERE customer_id NOT IN (
    SELECT customer_id FROM customers
);

-- Transactions → Accounts 
SELECT *
FROM transactions
WHERE account_id NOT IN (
    SELECT account_id FROM accounts
);

-- Transactions → Merchants 
SELECT *
FROM transactions
WHERE merchant_id NOT IN (
    SELECT merchant_id FROM merchants
);

-- =====================================================
-- ADD FOREIGN KEYS
-- =====================================================
-- Accounts 
ALTER TABLE accounts
ADD CONSTRAINT fk_accounts_customer
FOREIGN KEY (customer_id)
REFERENCES customers(customer_id);

-- Branches
ALTER TABLE accounts
ADD CONSTRAINT fk_accounts_branch
FOREIGN KEY (branch_id)
REFERENCES branches(branch_id); 

-- Cards
ALTER TABLE cards
ADD CONSTRAINT fk_cards_account
FOREIGN KEY (account_id)
REFERENCES accounts(account_id);

-- Loans
ALTER TABLE loans
ADD CONSTRAINT fk_loans_customer
FOREIGN KEY (customer_id)
REFERENCES customers(customer_id);

-- Transactions → Accounts
ALTER TABLE transactions
ADD CONSTRAINT fk_transactions_account
FOREIGN KEY (account_id)
REFERENCES accounts(account_id);

-- Transactions → Merchants
ALTER TABLE transactions
ADD CONSTRAINT fk_transactions_merchant
FOREIGN KEY (merchant_id)
REFERENCES merchants(merchant_id);

-- =====================================================
-- ADD UNIQUE CONSTRAINTS
-- =====================================================
-- Customers
ALTER TABLE customers
ADD CONSTRAINT uq_pan
UNIQUE (pan_number);

ALTER TABLE customers
ADD CONSTRAINT uq_phone
UNIQUE (phone_number);

-- =====================================================
-- ADD CHECK CONSTRAINTS
-- =====================================================
-- Customers
ALTER TABLE customers
ADD CONSTRAINT chk_credit_score
CHECK (credit_score BETWEEN 300 AND 900);

ALTER TABLE customers
ADD CONSTRAINT chk_gender
CHECK (gender IN ('Male','Female','Other'));

-- Accounts
ALTER TABLE accounts
ADD CONSTRAINT chk_balance
CHECK (balance_usd >= 0);

ALTER TABLE accounts
ADD CONSTRAINT chk_account_status
CHECK (account_status IN ('Active','Inactive','Closed'));

-- Loans
ALTER TABLE loans
ADD CONSTRAINT chk_loan_amount
CHECK (loan_amount >= 0);

ALTER TABLE loans
ADD CONSTRAINT chk_interest
CHECK (interest_rate BETWEEN 1 AND 25);

ALTER TABLE loans
ADD CONSTRAINT chk_loan_status
CHECK (loan_status IN ('Approved','Pending','Closed'));

-- Transactions
ALTER TABLE transactions
ADD CONSTRAINT chk_transaction_amount
CHECK (amount_usd > 0);

ALTER TABLE transactions
ADD CONSTRAINT chk_transaction_status
CHECK (status IN ('Success','Failed','Pending'));

-- =====================================================
-- ADD DEFAULT CONSTRAINTS
-- =====================================================
-- Accounts
ALTER TABLE accounts
MODIFY account_status VARCHAR(20)
DEFAULT 'Active';

-- Loans 
ALTER TABLE loans
MODIFY loan_status VARCHAR(20)
DEFAULT 'Pending';

-- Transactions
 ALTER TABLE transactions
MODIFY status VARCHAR(20)
DEFAULT 'Pending';

-- =====================================================
-- VERIFY TABLE STRUCTURE
-- =====================================================
SHOW CREATE TABLE customers;

SHOW CREATE TABLE branches;

SHOW CREATE TABLE merchants;

SHOW CREATE TABLE accounts;

SHOW CREATE TABLE cards;

SHOW CREATE TABLE loans;

SHOW CREATE TABLE transactions;