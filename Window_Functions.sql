/*==============================================================
Project      : Bank Analysis SQL Project
File         : 08_Window_Functions.sql
Description  : Demonstrates SQL window functions such as
               ROW_NUMBER(), RANK(), and DENSE_RANK()
               for analytical reporting.
Database     : Bank_Analysis
==============================================================*/

-- =====================================================
-- CUSTOMER ANALYSIS
-- =====================================================
-- 1. Row Number by Credit Score
select customer_id, first_name, credit_score,
row_number() over(order by credit_score desc) as row_num
from customers;

-- 2. Rank Customers by Credit Score
select customer_id, first_name, credit_score,
rank() over(order by credit_score desc) as customer_rank
from customers;

-- 3. Dense Rank Customers by Credit Score
select customer_id, first_name, credit_score,
dense_rank() over(order by credit_score desc) as customer_rank
from customers;

-- 4. Rank States by Average Credit Score
select state, round(avg(credit_score),2) as average_credit_score,
rank() over(order by avg(credit_score) desc) as state_rank
from customers
group by state;

-- =====================================================
-- ACCOUNT ANALYSIS
-- =====================================================
-- 5. Rank Accounts by Balance
select account_id, account_type, balance_usd,
rank() over(order by balance_usd desc) as balance_rank
from accounts;

-- 6. Dense Rank Account Types by Average Balance
select account_type, round(avg(balance_usd),2) as average_balance,
dense_rank() over(order by avg(balance_usd) desc) as balance_rank
from accounts
group by account_type;

-- 7. Row Number by Account Opening Date
select account_id, account_type, open_date,
row_number() over(order by open_date) as row_num
from accounts;

-- =====================================================
-- LOAN ANALYSIS
-- =====================================================
-- 8. Rank Loans by Amount
select loan_id, loan_type, loan_amount,
rank() over(order by loan_amount desc) as loan_rank
from loans;

-- 9. Dense Rank Loan Types by Average Interest Rate
select loan_type, round(avg(interest_rate),2) as avg_interest_rate,
dense_rank() over(order by avg(interest_rate) desc) as interest_rank
from loans
group by loan_type;

-- 10. Row Number by Loan Start Date
select loan_id, loan_type, start_date,
row_number() over(order by start_date) as row_num
from loans;

-- =====================================================
-- TRANSACTION ANALYSIS
-- =====================================================
-- 11. Rank Transactions by Amount
select transaction_id, amount_usd,
rank() over(order by amount_usd desc) as transaction_rank
from transactions;

-- 12. Dense Rank Payment Modes by Total Transaction Amount
select payment_mode, round(sum(amount_usd),2) as total_amount,
dense_rank() over(order by sum(amount_usd) desc) as payment_rank
from transactions
group by payment_mode;

-- 13. Row Number by Transaction Date
select transaction_id, transaction_date, amount_usd,
row_number() over(order by transaction_date) as row_num
from transactions;

-- =====================================================
-- MERCHANT ANALYSIS
-- =====================================================
-- 14. Rank Merchant Categories by Merchant Count
select category, count(*) as total_merchants,
rank() over(order by count(*) desc) as category_rank
from merchants
group by category;

-- =====================================================
-- BRANCH ANALYSIS
-- =====================================================
-- 15. Dense Rank States by Number of Branches
select state, count(*) as total_branches,
dense_rank() over(order by count(*) desc) as state_rank
from branches
group by state;
