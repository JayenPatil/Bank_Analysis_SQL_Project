/*==============================================================
Project      : Bank Analysis SQL Project
File         : 02_Data_Exploration.sql
Description  : Explores database structure, data distribution,
               and summary statistics.
Database     : Bank_Analysis
==============================================================*/

-- Show Current Database
SELECT DATABASE() as current_database;

 -- Show All Tables
 SHOW TABLES;

-- Table Structure
DESCRIBE customers;
DESCRIBE accounts;
DESCRIBE branches;
DESCRIBE cards;
DESCRIBE loans;
DESCRIBE merchants;
DESCRIBE transactions;

-- Number of Columns in Each Table
SELECT count(*) as customer_columns
FROM Information_Schema.Columns
WHERE table_schema='bank_analysis'
and table_name='customers';

SELECT count(*) as account_columns
FROM Information_Schema.Columns
WHERE table_schema='bank_analysis'
and table_name='accounts'; 

SELECT count(*) as branch_columns
FROM Information_Schema.Columns
WHERE table_schema='bank_analysis'
and table_name='branches';

SELECT count(*) as card_columns
FROM Information_Schema.Columns
WHERE table_schema='bank_analysis'
and table_name='cards';

SELECT count(*) as loan_columns
FROM Information_Schema.Columns
WHERE table_schema='bank_analysis'
and table_name='loans';

SELECT count(*) as merchant_columns
FROM Information_Schema.Columns
WHERE table_schema='bank_analysis'
and table_name='merchants';

SELECT count(*) as transaction_columns
FROM Information_Schema.Columns
WHERE table_schema='bank_analysis'
and table_name='transactions';

-- View Sample Data
SELECT * FROM customers limit 10;
SELECT * FROM accounts limit 10;
SELECT * FROM branches limit 10;
SELECT * FROM cards limit 10;
SELECT * FROM loans limit 10;
SELECT * FROM merchants limit 10;
SELECT * FROM transactions limit 10;

-- Check Number of Records 
SELECT count(*) as total_customers FROM customers;
SELECT count(*) as total_accounts FROM accounts;
SELECT count(*) as total_branches FROM branches;
SELECT count(*) as total_cards FROM cards;
SELECT count(*) as total_loans FROM loans;
SELECT count(*) as total_merchants FROM merchants;
SELECT count(*) as total_transactions FROM transactions;

-- Check Distinct Values
SELECT distinct account_type FROM accounts;
SELECT distinct card_type FROM cards;
SELECT distinct loan_type FROM loans;
SELECT distinct payment_mode FROM transactions;
SELECT distinct status FROM transactions;
SELECT distinct account_status FROM accounts;

-- Account Type Distribution
SELECT account_type, count(*) as total_accounts
FROM accounts
GROUP BY account_type;

-- Card Type Distribution
SELECT card_type, count(*) as total_cards 
FROM cards
GROUP BY card_type;

-- Loan Type Dsitribution
SELECT loan_type, count(*) as total_loan
FROM loans
GROUP BY loan_type;

-- Transaction Status Distribution
SELECT status, count(*) as total_transactions
FROM transactions
GROUP BY status;

-- Payment Mode Distribution
SELECT payment_mode, count(*) as total_transactions
FROM transactions
GROUP BY payment_mode;

-- Count Distinct Cities & State
SELECT count(distinct city) as total_cities FROM customers; 
SELECT count(distinct state) as total_states FROM customers;

-- Check Minimum & Maximum values
SELECT min(credit_score) as min_credit_score,
max(credit_score) as max_credit_score
FROM customers;

SELECT min(balance_usd) as min_balance,
max(balance_usd) as max_balance
FROM accounts;

SELECT min(loan_amount) as min_loan,
max(loan_amount) as max_loan
FROM loans;

SELECT min(amount_usd) as min_transaction,
max(amount_usd) as max_transaction
FROM transactions;

-- Check Average Values
SELECT avg(balance_usd) as avg_balance FROM accounts;
SELECT avg(loan_amount) as avg_loan FROM loans;
SELECT avg(amount_usd) as avg_transaction FROM transactions;
SELECT avg(credit_score) as avg_credit_score FROM customers;

-- Date Range
SELECT
min(transaction_date) as min_transaction_date,
max(transaction_date) as max_transaction_date
FROM transactions;

SELECT
min(open_date) as min_open_date,
max(open_date) as max_open_date
FROM accounts;

-- Date Distribution
SELECT year(open_date) as open_year,
count(*) as total_accounts
FROM accounts
GROUP BY year(open_date)
order by year(open_date);

SELECT year(transaction_date) as transaction_year,
count(*) as total_transactions
FROM transactions
GROUP BY year(transaction_date)
order by year(transaction_date);

-- Table Size
SELECT table_name,
table_rows
FROM information_schema.tables
WHERE table_schema='bank_analysis';  

-- DATABASE Summary
SELECT
(SELECT count(*) FROM customers) as customers,
(SELECT count(*) FROM accounts) as accounts,
(SELECT count(*) FROM branches) as branches,
(SELECT count(*) FROM cards) as cards,
(SELECT count(*) FROM loans) as loans,
(SELECT count(*) FROM merchants) as merchants,
(SELECT count(*) FROM transactions) as transactions;