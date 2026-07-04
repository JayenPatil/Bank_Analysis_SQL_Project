-- CUSTOMER ANALYSIS
-- 1. Customers with Above Average Credit Score
select * from customers
where credit_score > (select avg(credit_score) from customers);

-- 2. Customers with Maximum Credit Score
select * from customers
where credit_score = (select max(credit_score) from customers);

-- 3. Customers Registered Before Average Registration Date
select * from customers
where created_at < (select avg(created_at) from customers);

-- ACCOUNT ANALYSIS
-- 4. Accounts Having Balance Above Average
select * from accounts 
where balance_usd > (select avg(balance_usd) from accounts);

-- 5. Accounts with Maximum Balance
select * from accounts 
where balance_usd = (select max(balance_usd) from accounts);

-- 6. Accounts Opened Before Average Open Date
select * from accounts
where open_date < (select avg(open_date) from accounts);

-- 7. Accounts Opened on the Latest Date
select * from accounts
where open_date = (select max(open_date) from accounts);

-- LOAN ANALYSIS
-- 8. Loans Above Average Amount
select * from loans
where loan_amount > (select avg(loan_amount) from loans);

-- 9. Loans with Highest Interest Rate
select * from loans
where interest_rate = (select max(interest_rate) from loans);

-- 10. Loans Started on Earliest Date
select * from loans
where start_date = (select min(start_date) from loans);

-- TRANSACTION ANALYSIS
-- 11. Transactions Above Average Amount
select * from transactions
where amount_usd > (select avg(amount_usd) from transactions);

-- 12. Largest Transaction
select * from transactions
where amount_usd = (select max(amount_usd) from transactions);

-- 13. Transactions Performed on Latest Date
select * from transactions
where date(transaction_date) = (select date(max(transaction_date)) from transactions);

-- MERCHANT ANALYSIS
-- 14. Merchants in the Same State as Mumbai Merchants
select * from merchants
where state in (select distinct state from merchants where city = "Mumbai");

-- 15. Merchant Categories Having More Than Average Merchants
select category, count(*) as total_merchants from merchants
group by category
having count(*) > 
(select avg(category_count) 
from 
(select count(*) as category_count from merchants 
group by category) 
as x);

-- BRANCHES ANALYSIS
-- 16. Branches in States Where Customers Exist
select * from branches
where state in (select distinct state from customers);

-- 17. Branches Managing Above Average Number of Accounts
select branch_id, count(*) as total_accounts from accounts
group by branch_id
having count(*) >
(select avg(branch_count)
from
(select count(*) as branch_count from accounts
group by branch_id) as x);