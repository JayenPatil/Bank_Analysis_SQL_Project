-- CUSTOMER ↔ ACCOUNT
-- 1. Customer with Account Details
select c.customer_id, c.first_name, c.last_name, a.account_id, a.account_type, a.balance_usd
from customers as c
inner join accounts as a
on c.customer_id = a.customer_id;

-- 2. Customers Without Any Account
select c.customer_id, c.first_name, c.last_name
from customers as c
left join accounts as a
on c.customer_id = a.customer_id
where a.account_id is null;

-- 3. Number of Accounts per Customer
select c.customer_id, c.first_name, count(a.account_id) as total_accounts
from customers as c
left join accounts as a
on c.customer_id = a.customer_id
group by c.customer_id, c.first_name
order by total_accounts desc;

-- ACCOUNT ↔ BRANCH
-- 4. Account with Branch Name
select a.account_id, a.account_type, b.branch_name, b.city
from accounts as a
inner join branches as b
on a.branch_id = b.branch_id;

-- 5. Branch Having Maximum Accounts
select b.branch_name, count(a.account_id) as total_accounts
from branches as b
inner join accounts as a
on b.branch_id = a.branch_id
group by b.branch_name
order by total_accounts desc;

-- 6. Total Balance Managed by Each Branch
select b.branch_name, round(sum(a.balance_usd),2) as total_balance
from branches as b
inner join accounts as a 
on b.branch_id = a.branch_id
group by b.branch_name
order by total_balance desc;

-- ACCOUNT ↔ CARD 
-- 7. Account with Card Details
select a.account_id, a.account_type, c.card_type, c.expiration_date
from accounts as a
inner join cards as c
on a.account_id = c.account_id;

-- 8. Accounts Without Cards
select a.account_id, a.account_type
from accounts as a
left join cards as c
on a.account_id = c.account_id
where c.card_id is null;

-- 9. Card Count by Account Type
select a.account_type, count(c.card_id) as total_cards
from accounts as a
inner join cards as c
on a.account_id = c.account_id
group by a.account_type
order by total_cards desc;

-- CUSTOMER ↔ LOAN
--  10. Customer Loan Details
select c.customer_id, c.first_name, l.loan_type, l.loan_amount
from customers as c
inner join loans as l
on c.customer_id = l.customer_id;

-- 11. Customers Without Loans
select c.customer_id, c.first_name
from customers as c
left join loans as l
on c.customer_id = l.customer_id
where l.loan_id is null;

-- 12. Loan Amount by Customer State
select c.state, round(sum(l.loan_amount),2) as total_loan
from customers as c
inner join loans as l
on c.customer_id = l.customer_id
group by state
order by total_loan desc;

-- TRANSACTION ↔ ACCOUNT
-- 13. Transaction with Account Type
select t.transaction_id, a.account_type, t.amount_usd, t.payment_mode
from transactions as t
inner join accounts as a
on t.account_id = a.account_id;

-- 14. Total Transactions by Account Type
select a.account_type, count(t.transaction_id) as total_transactions
from accounts as a
inner join transactions as t
on a.account_id = t.account_id
group by a.account_type
order by total_transactions desc;

-- 15. Total Transaction Value by Account Type
select a.account_type, round(sum(t.amount_usd),2) as total_amount
from accounts as a
inner join transactions as t
on a.account_id = t.account_id 
group by a.account_type
order by total_amount desc;

-- TRANSACTION ↔ MERCHANT
-- 16. Transaction with Merchant Details
select t.transaction_id, m.merchant_name, m.category, t.amount_usd
from transactions as t
inner join merchants as m
on t.merchant_id = m.merchant_id;

-- 17. Merchant Category Generating Highest Transaction Value
select m.category, round(sum(t.amount_usd),2) as total_amount
from merchants as m 
inner join transactions as t
on m.merchant_id = t.merchant_id
group by m.category
order by total_amount desc;

-- 18. Top 10 Merchants by Transaction Value
select m.merchant_name,round(sum(t.amount_usd),2) as total_amount
from merchants as m
inner join transactions as t
on m.merchant_id = t.merchant_id
group by m.merchant_name
order by total_amount desc
limit 10;

-- THREE TABLE JOINS
-- 19. Customer → Account → Branch
select c.first_name, a.account_type, b.branch_name
from customers as c
inner join accounts as a
on c.customer_id = a.customer_id
inner join branches b
on a.branch_id = b.branch_id;

-- 20. Customer → Account → Transaction
select c.first_name, a.account_type, t.amount_usd, t.transaction_date
from customers as c
inner join accounts as a
on c.customer_id = a.customer_id
inner join transactions as t
on a.account_id = t.account_id;