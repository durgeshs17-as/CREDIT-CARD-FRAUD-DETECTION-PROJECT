
                         -- CREDIT CARD FRAUD DETECTION PROJECT----

1. Basic Concept  
---SELECT 
---WHERE 
--ORDER BY 
--Aggregate Functions 
--GROUP BY 
--HAVING 
--NULL Handling 
--Subqueries 
2. Advance Concepts 
-- Window Functions 
-- Stored Procedures 
-- Constraints 


-- CREATE DATABASE--

CREATE DATABASE fraud_detection_project; 


USE fraud_detection_project; 

-- CREATE TABLE--

create table credit_card_fraud (
    transaction_id INT,
    amount DECIMAL(10,2),
    transaction_hour INT,
    merchant_category VARCHAR(50),
    foreign_transaction INT,
    location_mismatch INT,
    device_trust_score INT,
    velocity_last_24h INT,
    cardholder_age INT,
    is_fraud INT);
    
    
                                       -- BASIC CONCEPTS--

-- 1. SELECT--

-- Display all records--
select * from credit_card_fraud;


-- 2. WHERE--
-- Display all fraudulent transactions---
select * from credit_card_fraud
Where is_fraud = 1;

-- Display all Travel transactions---
select * from credit_card_fraud
where merchant_category = 'Travel';

-- Display all foreign transactions---
select * from credit_card_fraud
where foreign_transaction = 1;

-- Display all location mismatch transactions--
select * from credit_card_fraud
where location_mismatch = 1;

-- 3. ORDER BY---
-- Electronics transactions sorted by amount ascending---

select * from credit_card_fraud
where merchant_category = 'Electronics'
order by amount asc;

-- Travel transactions sorted by amount ascending---
select * from credit_card_fraud
where merchant_category = 'Travel'
order by amount asc;

-- Grocery transactions sorted by amount ascending--
select * from credit_card_fraud
where merchant_category = 'Grocery'
order by amount asc;

-- Fraud transactions sorted by amount descending---

select * from credit_card_fraud
where is_fraud = 1
order by amount DESC;


-- 4. AGGREGATE FUNCTIONS--

-- COUNT--

-- Total transactions--
select COUNT(*) AS total_transactions
from credit_card_fraud;

-- Total fraud transactions--

select COUNT(*) AS fraud_transactions
from credit_card_fraud
where is_fraud = 1;

-- SUM--
-- Total transaction amount
select SUM(amount) AS total_amount
from credit_card_fraud;

-- Total fraud amount
select SUM(amount) AS fraud_amount
from credit_card_fraud
where is_fraud = 1;

-- AVG---
-- Average transaction amount
select avg(amount) AS average_amount
from credit_card_fraud;

-- Average device trust score--
select avg(device_trust_score) AS avg_device_score
from credit_card_fraud;

-- MAX
-- Highest transaction amount-- 

select MAX(amount) AS highest_transaction
from credit_card_fraud;

-- MIN
-- Lowest transaction amount

select MIN(amount) AS lowest_transaction
from credit_card_fraud;

-- 5. GROUP BY
-- Average amount by merchant category
select merchant_category,avg(amount) AS average_amount
from credit_card_fraud
group by merchant_category;

-- Fraud count by merchant category
select merchant_category,
COUNT(*) AS fraud_count
from credit_card_fraud
where is_fraud = 1
group by  merchant_category;

-- Average amount by fraud status

select is_fraud,
avg(amount) AS avg_amount
from credit_card_fraud
group by is_fraud;

-- 6. HAVING---

-- Categories having more than 100 transactions
select merchant_category,
COUNT(*) AS total_transactions
from credit_card_fraud
group by merchant_category
having COUNT(*) > 100;

-- Categories with average amount greater than 500----
select merchant_category,
avg(amount) AS average_amount
from credit_card_fraud
group by  merchant_category
having avg(amount) > 500;


-- 7. NULL HANDLING

-- Merchant category is NULL---
select * from credit_card_fraud
where merchant_category is null;

-- Device trust score is NULL---
select * from  credit_card_fraud
where device_trust_score is null;

-- 8. SUBQUERIES----

-- Transactions above average amount--
select * from credit_card_fraud
where amount >(select avg(amount)
from credit_card_fraud);

-- Fraud transactions above average fraud amount--

select * from credit_card_fraud
where amount >(select avg(amount)from credit_card_fraud
where is_fraud = 1);

-- ADVANCED CONCEPTS

-- 9. WINDOW FUNCTIONS---
-- RANK---
select transaction_id,amount,
rank() over(order by amount desc) AS ranking
FROM credit_card_fraud;

-- DENSE RANK
select transaction_id,amount,
dense_rank() over(Order by amount desc) AS dense_ranking
from credit_card_fraud;

-- ROW NUMBER
select transaction_id,amount,
row_number() over(order by  amount desc) AS row_num
from credit_card_fraud;

-- 10. STORED PROCEDURES
DELIMITER //
create procedure show_transactions()
begin
select * from credit_card_fraud;
end //
DELIMITER ;

CALL show_transactions();

-- High Amount Transactions---
DELIMITER //
create procedure high_transaction()
begin
select * from credit_card_fraud
where amount > 1000;
end //

DELIMITER ;
call high_transaction();

-- Fraud Transactions
DELIMITER //
create procedure fraud_transactions()
begin
select *
from credit_card_fraud
where is_fraud = 1;
end //

DELIMITER ;

call fraud_transactions();

-- 11. CONSTRAINTS

-- PRIMARY KEY
create table fraud_transaction_demo 
(transaction_id int primary key,
amount decimal(10,2),
is_fraud int);

describe fraud_transaction_demo;

-- NOT NULL
create table fraud_transaction_notnull (
transaction_id int primary key,
amount decimal(10,2) not null,
merchant_category varchar(50) not null);

describe fraud_transaction_notnull;

-- UNIQUE
create table fraud_transaction_unique (
    transaction_id int primary key,
    transaction_reference varchar(50) unique,
    amount decimal(10,2)
);

describe fraud_transaction_unique;



