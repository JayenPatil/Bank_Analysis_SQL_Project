-- CUSTOMER ANALYSIS
-- Customers with Average Credit Score Greater Than 700
select state, round(avg(credit_score),2) as avg_credit_score from customers
group by state
having avg(credit_score) > 700
order by avg_credit_score desc;

-- States Having More Than 500 Customers
select state, count(*) as total_customers from customers
group by state
having count(*) > 500
order by total_customers desc;

-- Customer Registration by Month
select month(created_at) as registration_month,count(*) as total_customers from customers
group by month(created_at)
order by registration_month;

-- Credit Score Categories
select 
case 
   when credit_score >= 750 then 'Excellent'
   when credit_score >= 650 then 'Good'
   else 'Poor'
end as credit_category,
count(*) as total_customers from customers
group by credit_category;

-- ACCOUNT ANALYSIS
-- Account Types Having Average Balance Greater Than 50000
select account_type, round(avg(balance_usd),2) as avg_balance from accounts
group by account_type
having avg(balance_usd) > 5000
order by avg_balance desc;

-- Account Status Wise Total Balance
select account_status,round(sum(balance_usd),2) as total_balance from accounts
group by account_status
order by total_balance desc;

-- Balance Categories
select
case
    when balance_usd >= 100000 then 'High Balance'
    when balance_usd >= 50000 then 'Medium Balance'
    else 'Low Balance'
end as balance_category, count(*) as total_accounts from accounts
group by balance_category;

-- Accounts Opened by Month
select month(open_date) as opening_month, count(*) as total_accounts from accounts
group by month(open_date)
order by opening_month;

-- LOAN ANALYSIS
-- Loan Types with Average Loan Greater Than 500000
select loan_type, round(avg(loan_amount),2) as avg_loan from loans
group by loan_type
having avg(loan_amount) > 50000
order by avg_loan desc;

-- Loan Status Wise Total Loan Amount
select loan_status, round(sum(loan_amount),2) as total_loan from loans
group by loan_status
order by total_loan desc;

-- Loan Categories
select
case
    when loan_amount >= 1000000 then 'High Loan'
    when loan_amount >= 500000 then 'Medium Loan'
    else 'Low Loan'
end as loan_category, count(*) as total_loans from loans
group by loan_category;

-- Average Interest Rate by Loan Type
select loan_type, round(avg(interest_rate),2) as avg_interest_rate from loans
group by loan_type
order by avg_interest_rate desc;

-- Interest Rate Categories
select
case
    when interest_rate >= 15 then 'High Interest'
    when interest_rate >= 10 then 'Medium Interest'
    else 'Low Interest'
end as interest_category, count(*) as total_loans from loans
group by interest_category;

-- Cards Expiring by Year
select year(expiration_date) as expiry_year, count(*) as total_cards from cards
group by year(expiration_date)
order by expiry_year;

-- MERCHANT ANALYSIS
-- Merchant Categories Having More Than 50 Merchants
select category, count(*) as total_merchants from merchants
group by category
having count(*) > 50
order by total_merchants desc;

-- TRANSACTION ANALYSIS
-- Payment Mode Wise Total Transaction Amount
select payment_mode, round(sum(amount_usd),2) as total_amount from transactions
group by payment_mode
order by total_amount desc;

-- Transaction Type Wise Average Amount
select transaction_type, round(avg(amount_usd),2) as avg_amount from transactions
group by transaction_type
order by avg_amount desc;

-- Transaction Status Wise Total Amount
select status, round(sum(amount_usd),2) as total_amount from transactions 
group by status
order by total_amount desc;

-- Transactions by Month
select month(transaction_date) as transaction_month,
count(*) as total_transactions from transactions
group by month(transaction_date)
order by transaction_month;

-- Transaction Amount Categories
select
case
    when amount_usd >= 5000 then 'High Value'
    when amount_usd >= 1000 then 'Medium Value'
    else 'Low Value'
end as transaction_category, count(*) as total_transactions from transactions
group by transaction_category;

-- YEARLY BUSINESS ANALYSIS
-- Total Loan Amount by Year
select year(start_date) as loan_year, round(sum(loan_amount),2) as total_loan from loans
group by year(start_date)
order by loan_year;

-- Total Account Balance by Opening Year
select year(open_date) as opening_year, round(sum(balance_usd),2) as total_balance from accounts
group by year(open_date)
order by opening_year desc;

-- Total Transaction Amount by Year
select year(transaction_date) as transaction_year, round(sum(amount_usd),2) as total_transaction_amount from transactions
group by year(transaction_date)
order by transaction_year;