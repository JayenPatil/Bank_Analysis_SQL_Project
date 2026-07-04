/*==============================================================
Project      : Bank Analysis SQL Project
File         : 04_Basic_Business_Analysis.sql
Description  : Performs basic business analysis using
               aggregate functions and grouping to
               generate key business insights.
Database     : Bank_Analysis
==============================================================*/

-- =====================================================
-- CUSTOMER ANALYSIS
-- =====================================================
-- Total Customers
select count(*) as total_customers from customers;

-- Customer by Gender
select gender, count(*) as total_customers
from customers
group by gender
order by total_customers desc;

-- Customers by State
select state, count(*) as total_customers
from customers
group by state
order by total_customers desc;

-- Customers by City
select city, count(*) as total_customers
from customers
group by city
order by total_customers desc;

-- Average Credit Score
select round(avg(credit_score),2) as average_credit_score from customers;

-- Highest Credit Score
select max(credit_score) as highest_credit_score from customers;

-- Lowest Credit Score
select min(credit_score) as lowest_credit_score from customers;

-- Customers Registered by Year
select year(created_at) as registration_year,
count(*) as total_customers from customers
group by year(created_at)
order by registration_year;

-- =====================================================
-- ACCOUNT ANALYSIS
-- =====================================================
-- Total Accounts
select count(*) as total_accounts from accounts;

-- Accounts by Type
select account_type, count(*) as total_accounts
from accounts
group by account_type
order by total_accounts desc;

-- Accounts by Status
select account_status, count(*) as total_accounts
from accounts
group by account_status
order by total_accounts desc;

-- Total Account Balance
select round(sum(balance_usd),2) as total_bank_balance from accounts;

-- Average Account Balance
select round(avg(balance_usd),2) as average_balance from accounts;

-- Highest Account Balance
select max(balance_usd) as highest_balance from accounts;

-- Lowest Account Balance
select min(balance_usd) as lowest_balance from accounts;

-- =====================================================
-- LOAN ANALYSIS
-- =====================================================
-- Total Loans
select count(*) as total_loans from loans;

-- Loans by Type
select loan_type, count(*) as total_loans from loans
group by loan_type
order by total_loans desc;

-- Loan Status Distribution
select loan_status, count(*) as total_loans from loans
group by loan_status
order by total_loans desc;

-- Total Loan Amount
select round(sum(loan_amount),2) as total_loan_amount from loans;

-- Average Loan Amount
select round(avg(loan_amount),2) as average_loan_amount from loans;

-- Highest Loan Amount
select max(loan_amount) as highest_loan_amount from loans;

-- Lowest Loan Amount
select min(loan_amount) as lowest_loan_amount from loans;
 
-- Average Interest Rate
select round(avg(interest_rate),2) as average_interest_rate from loans;
 
-- =====================================================
-- CARD ANALYSIS
-- =====================================================
-- Total Cards
select count(*) as total_cards from cards;
 
-- Cards by Type
select card_type, count(*) as total_cards from cards
group by card_type
order by total_cards desc;
 
-- =====================================================
-- MERCHANT ANALYSIS
-- =====================================================
-- Total Merchants
select count(*) as total_merchants from merchants;
 
-- Merchants by Category
select category, count(*) as total_merchants from merchants
group by category
order by total_merchants desc;
 
-- Merchants by State
select state, count(*) as total_merchants from merchants
group by state
order by total_merchants desc;
 
-- =====================================================
-- TRANSACTION ANALYSIS
-- =====================================================
-- Total Transactions
select count(*) as total_transactions from transactions;
 
-- Transaction Status Distribution
select status, count(*) as total_transactions from transactions
group by status 
order by total_transactions desc;
 
-- Payment Mode Distribution
select payment_mode, count(*) as total_transactions from transactions
group by payment_mode
order by total_transactions desc;
 
-- Transaction Type Distribution
select transaction_type, count(*) as total_transactions from transactions
group by transaction_type
order by total_transactions desc;
 
-- Total Transaction Amount
select round(sum(amount_usd),2) as total_transaction_amount from transactions;
 
-- Average Transaction Amount
select round(avg(amount_usd),2) as average_transaction_amount from transactions;

-- Highest Transaction Amount
select max(amount_usd) as highest_transaction from transactions;

-- Lowest Transaction Amount
select min(amount_usd) as lowest_transaction from transactions;

-- =====================================================
-- YEARLY ANALYSIS
-- =====================================================
-- Accounts Opened Per Year
select year(open_date) as year, count(*) as total_accounts from accounts
group by year(open_date)
order by year;

-- Loans Issued Per Year
select year(start_date) as year, count(*) as total_loans from loans
group by year(start_date)
order by year;

-- Transactions Per Year
select year(transaction_date) as year, count(*) as total_transactions from transactions
group by year(transaction_date)
order by year;