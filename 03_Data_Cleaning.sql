-- Check For Null Values
-- Customers
select * from customers
where customer_id is null
or first_name is null
or last_name is null
or gender is null
or date_of_birth is null
or phone_number is null
or email is null
or city is null
or state is null
or credit_score is null
or created_at is null;
 
-- Accounts
select * from accounts
where account_id is null
or customer_id is null
or branch_id is null
or account_type is null
or balance_usd is null
or account_status is null
or open_date is null; 

-- Branches
select * from branches
where branch_id is null
or branch_name is null
or manager_name is null
or city is null
or state is null;

-- Cards
select * from cards
where card_id is null
or account_id is null
or card_type is null
or expiration_date is null;

-- Loans
select * from loans
where loan_id is null
or customer_id is null
or loan_type is null
or loan_amount is null
or interest_rate is null
or loan_status is null
or start_date is null;

-- Merchants
select * from merchants
where merchant_id is null
or merchant_name is null
or category is null
or city is null
or state is null;

-- Transactions
select * from transactions
where transaction_id is null
or account_id is null
or merchant_id is null
or transaction_type is null
or payment_mode is null
or amount_usd is null
or status is null
or transaction_date is null;

-- Check For Duplicate Records
-- Duplicate Customer IDs
select customer_id, count(*)
from customers
group by customer_id
Having Count(*) > 1;

-- Duplicate PAN Numbers
select pan_number, count(*)
from customers
group by pan_number
Having Count(*) > 1;

-- Duplicate Phone Number
select phone_number, count(*)
from customers
group by phone_number
Having Count(*) > 1;

-- Duplicate Email
select email, count(*)
from customers
group by email
Having Count(*) > 1;    