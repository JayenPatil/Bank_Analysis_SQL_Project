/*==============================================================
Project      : Bank Analysis SQL Project
File         : 09_Views.sql
Description  : Creates reusable SQL views for simplified
               reporting and business analysis.
Database     : Bank_Analysis
==============================================================*/

-- =====================================================
-- CUSTOMER VIEWS
-- =====================================================
-- 1. High Credit Score Customers
create view high_credit_customers as 
select customer_id, first_name, last_name, city, state, credit_score from customers
where credit_score >= 750;

-- 2. Recently Registered Customers
create view recent_customers as 
select customer_id, first_name, last_name, created_at from customers
where year(created_at) >= 2023;

-- =====================================================
-- ACCOUNT VIEWS
-- =====================================================
-- 3. Active Accounts
create view active_accounts as 
select account_id, customer_id, account_type, balance_usd from accounts
where account_status = 'Active';

-- 4. High Balance Accounts
create view high_balance_accounts as 
select account_id, customer_id, account_type, balance_usd from accounts
where balance_usd >= 100000;

-- =====================================================
-- LOAN VIEWS
-- =====================================================
-- 5. Approved Loans
create view approved_loans as 
select loan_id, customer_id, loan_type, loan_amount, interest_rate from loans
where loan_status = 'Approved';

-- 6. High Value Loans
create view high_value_loans as 
select loan_id, customer_id, loan_type, loan_amount from loans
where loan_amount >= 1000000;

-- =====================================================
-- TRANSACTION VIEWS
-- =====================================================
-- 7. Successful Transactions
create view successful_transactions as
select transaction_id, account_id, merchant_id, payment_mode, amount_usd, transaction_date from transactions
where status = 'Success';

-- 8. High Value Transactions
create view high_value_transactions as 
select transaction_id, account_id, amount_usd, payment_mode, transaction_date from transactions
where amount_usd >= 5000;

-- =====================================================
-- MERCHANT VIEWS
-- =====================================================
-- 9. Grocery Merchants
create view grocery_merchants as 
select merchant_id, merchant_name, city, state from merchants
where category = 'Grocery';

-- =====================================================
-- MULTI-TABLE VIEW
-- =====================================================
-- 10. Customer Account Summary
create view customer_account_summary as
select c.customer_id, c.first_name, c.last_name, a.account_type, a.balance_usd
from customers as c
inner join accounts as a
on c.customer_id = a.customer_id;

-- =====================================================
-- VERIFY CREATED VIEWS
-- =====================================================
show full tables
where table_type = 'view';

-- =====================================================
-- VIEW OUTPUT
-- =====================================================
select * from high_credit_customers;
select * from recent_customers;
select * from active_accounts;
select * from high_balance_accounts;
select * from approved_loans;
select * from high_value_loans;
select * from successful_transactions;
select * from high_value_transactions;
select * from grocery_merchants;
select * from customer_account_summary;