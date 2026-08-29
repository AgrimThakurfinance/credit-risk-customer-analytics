/* =====================================================
   CREDIT RISK & CUSTOMER FINANCIAL BEHAVIOUR ANALYSIS
   =====================================================

   SECTION 1: DATASET OVERVIEW & VALIDATION

   Objective:
   Understand the size of the dataset and validate the
   uniqueness of transaction records and customers.
*/
create database Credit_Risk_Project;

use Credit_Risk_Project;

select count(*)
from customer_transactions;

select * from customer_transactions;

select count(distinct client_id)
from customer_transactions;

select gender, count(distinct client_id)
from customer_transactions
group by gender;

select gender,avg(credit_score)
from customer_transactions
group by gender;

select gender, avg(distinct credit_score)
from customer_transactions
group by gender;


SELECT 
    gender, 
    AVG(credit_score) AS avg_credit_score
FROM (
    SELECT DISTINCT 
        client_id, 
        gender, 
        credit_score
    FROM customer_transactions
) AS customer_data
GROUP BY gender;

SELECT
    client_id,
    credit_score,
    CASE
        WHEN credit_score >= 750 THEN 'High'
        WHEN credit_score >= 650 THEN 'Medium'
        ELSE 'Low'
    END AS credit_group
FROM customer_transactions
LIMIT 20;

select distinct client_id, credit_score, total_debt, yearly_income,
case 
when credit_score >= 750 then "High"
when credit_score <= 650 then "Medium"
else "low"
end as credit_group
from customer_transactions; 


select distinct client_id, credit_score, total_debt, yearly_income, total_debt/yearly_income as dti,
case 
when credit_score >= 750 then "High"
when credit_score >= 650 then "Medium"
else "low"
end as credit_group
from customer_transactions; 




Select credit_group, count(client_id)
FROM (select distinct client_id, credit_score, total_debt, yearly_income, total_debt/yearly_income as dti,
case 
when credit_score >= 750 then "High"
when credit_score >= 650 then "Medium"
else "low"
end as credit_group
from customer_transactions
) AS customer_data
GROUP BY credit_group;


Select credit_group, avg(yearly_income)
FROM (select distinct client_id, credit_score, total_debt, yearly_income, total_debt/yearly_income as dti,
case 
when credit_score >= 750 then "High"
when credit_score >= 650 then "Medium"
else "low"
end as credit_group
from customer_transactions
) AS customer_data
GROUP BY credit_group;


Select credit_group,count(client_id), avg(yearly_income), avg(total_debt), avg(dti)
FROM (select distinct client_id, credit_score, total_debt, yearly_income, total_debt/yearly_income as dti,
case 
when credit_score >= 750 then "High"
when credit_score >= 650 then "Medium"
else "low"
end as credit_group
from customer_transactions
) AS customer_data
GROUP BY credit_group;


SELECT
    c.credit_group,
    AVG(t.amount) AS avg_amount
FROM customer_transactions AS t
JOIN (SELECT DISTINCT
    client_id,
    credit_score,
    CASE
        WHEN credit_score >= 750 THEN 'High'
        WHEN credit_score >= 650 THEN 'Medium'
        ELSE 'Low'
    END AS credit_group
FROM customer_transactions) AS c
ON t.client_id = c.client_id
GROUP BY c.credit_group;


SELECT
    c.credit_group,
    COUNT(distinct t.client_id) as unique_customers, count(distinct t.transaction_id) as total_transactions, count(distinct t.transaction_id)/count(distinct t.client_id)
FROM customer_transactions AS t
JOIN (SELECT DISTINCT
    client_id,
    credit_score,
    CASE
        WHEN credit_score >= 750 THEN 'High'
        WHEN credit_score >= 650 THEN 'Medium'
        ELSE 'Low'
    END AS credit_group
FROM customer_transactions) AS c
ON t.client_id = c.client_id
GROUP BY c.credit_group;

SELECT
    COUNT(*) AS total_rows,
    COUNT(DISTINCT transaction_id) AS unique_transactions
FROM customer_transactions;


select client_id, sum(amount)
from customer_transactions
group by client_id;


SELECT
    c.client_id,
    c.yearly_income,
    s.total_spending,
    s.total_spending / c.yearly_income AS spending_income_ratio
FROM( select distinct client_id, yearly_income
from customer_transactions) AS c
JOIN (select client_id, sum(amount) as total_spending
from customer_transactions
group by client_id) AS s
ON c.client_id = s.client_id;

select c.credit_group, avg(s.spending_income_ratio) as avg_spending_income_ratio
from(SELECT
    c.client_id,
    c.yearly_income,
    s.total_spending,
    s.total_spending / c.yearly_income AS spending_income_ratio
FROM (
    SELECT DISTINCT
        client_id,
        yearly_income
    FROM customer_transactions
) AS c
JOIN (
    SELECT
        client_id,
        SUM(amount) AS total_spending
    FROM customer_transactions
    GROUP BY client_id
) AS s
on c.client_id = s.client_id) as s
join(SELECT DISTINCT
    client_id,
    credit_score,
    CASE
        WHEN credit_score >= 750 THEN 'High'
        WHEN credit_score >= 650 THEN 'Medium'
        ELSE 'Low'
    END AS credit_group
    from customer_transactions) as c
    on s.client_id = c.client_id
    group by c.credit_group;


SELECT
    c.credit_group,
    t.use_chip,
    COUNT(DISTINCT t.transaction_id) AS transactions
    from customer_transactions as t
    join( SELECT DISTINCT
    client_id,
    credit_score,
    CASE
        WHEN credit_score >= 750 THEN 'High'
        WHEN credit_score >= 650 THEN 'Medium'
        ELSE 'Low'
    END AS credit_group
    from customer_transactions) as c
    on t.client_id = c.client_id
    group by c.credit_group, t.use_chip;
    
    
    SELECT
    transaction_id,
    COUNT(*) AS row_count,
    COUNT(DISTINCT use_chip) AS different_channels
FROM customer_transactions
GROUP BY transaction_id
HAVING COUNT(DISTINCT use_chip) > 1
LIMIT 20;

SELECT
    transaction_id,
    COUNT(DISTINCT client_id) AS different_customers
FROM customer_transactions
GROUP BY transaction_id
HAVING COUNT(DISTINCT client_id) > 1
LIMIT 20;

SELECT
    transaction_id,
    client_id,
    use_chip,
    amount,
    date,
    merchant_id
FROM customer_transactions
WHERE transaction_id IN (
    SELECT transaction_id
    FROM customer_transactions
    GROUP BY transaction_id
    HAVING COUNT(DISTINCT use_chip) > 1
)
ORDER BY transaction_id
LIMIT 20;


SELECT
    c.credit_group,
    t.use_chip,
    COUNT(*) AS transaction_records
FROM customer_transactions AS t
JOIN (
    SELECT DISTINCT
        client_id,
        credit_score,
        CASE
            WHEN credit_score >= 750 THEN 'High'
            WHEN credit_score >= 650 THEN 'Medium'
            ELSE 'Low'
        END AS credit_group
    FROM customer_transactions
) AS c
ON t.client_id = c.client_id
GROUP BY
    c.credit_group,
    t.use_chip;

SELECT
    MIN(amount) AS min_amount,
    MAX(amount) AS max_amount,
    AVG(amount) AS avg_amount
FROM customer_transactions;

SELECT COUNT(*)
FROM customer_transactions
WHERE amount >= 10000;

SELECT
    COUNT(*) AS high_value_transactions,
    COUNT(*) / (SELECT COUNT(*) FROM customer_transactions) * 100 AS percentage
FROM customer_transactions
WHERE amount >= 10000;

SELECT
    c.credit_group,
    SUM(
        CASE
            WHEN t.amount >= 10000 THEN 1
            ELSE 0
        END
    ) AS high_value_transactions,
    COUNT(*) AS total_transactions,
    ROUND(
        SUM(
            CASE
                WHEN t.amount >= 10000 THEN 1
                ELSE 0
            END
        ) / COUNT(*) * 100,
        2
    ) AS high_value_percentage
FROM customer_transactions AS t
JOIN (
    SELECT DISTINCT
        client_id,
        credit_score,
        CASE
            WHEN credit_score >= 750 THEN 'High'
            WHEN credit_score >= 650 THEN 'Medium'
            ELSE 'Low'
        END AS credit_group
    FROM customer_transactions
) AS c
ON t.client_id = c.client_id
GROUP BY c.credit_group;

SELECT
    client_id,
    AVG(amount) AS avg_transaction,
    STDDEV(amount) AS transaction_stddev
FROM customer_transactions
GROUP BY client_id;

SELECT
    COUNT(*) AS customers_with_multiple_transactions
FROM (
    SELECT
        client_id,
        COUNT(*) AS transaction_count
    FROM customer_transactions
    GROUP BY client_id
    HAVING COUNT(*) > 1
) AS customer_counts;

SELECT
    c.credit_group,
    AVG(s.transaction_stddev) AS avg_transaction_stddev
FROM (
    SELECT
        client_id,
        STDDEV(amount) AS transaction_stddev
    FROM customer_transactions
    GROUP BY client_id
    HAVING COUNT(*) > 1
) AS s
JOIN (
    SELECT DISTINCT
        client_id,
        credit_score,
        CASE
            WHEN credit_score >= 750 THEN 'High'
            WHEN credit_score >= 650 THEN 'Medium'
            ELSE 'Low'
        END AS credit_group
    FROM customer_transactions
) AS c
ON s.client_id = c.client_id
GROUP BY c.credit_group;


SELECT
    client_id,
    credit_score,
    yearly_income,
    total_debt,
    total_debt / yearly_income AS dti
FROM (
    SELECT DISTINCT
        client_id,
        credit_score,
        yearly_income,
        total_debt
    FROM customer_transactions
) AS customer_data
ORDER BY dti DESC
LIMIT 10;


SELECT
    COUNT(*) AS high_dti_customers,
    ROUND(
        COUNT(*) * 100.0 / (SELECT COUNT(DISTINCT client_id)
                            FROM customer_transactions),
        2
    ) AS percentage_of_customers
FROM (
    SELECT DISTINCT
        client_id,
        total_debt / yearly_income AS dti
    FROM customer_transactions
) AS customer_data
WHERE dti >= 0.50;

SELECT
    credit_group,
    SUM(CASE WHEN dti >= 0.50 THEN 1 ELSE 0 END) AS high_dti_customers,
    COUNT(*) AS total_customers,
    ROUND(
        SUM(CASE WHEN dti >= 0.50 THEN 1 ELSE 0 END)
        / COUNT(*) * 100,
        2
    ) AS high_dti_percentage
FROM (
    SELECT DISTINCT
        client_id,
        credit_score,
        total_debt / yearly_income AS dti,
        CASE
            WHEN credit_score >= 750 THEN 'High'
            WHEN credit_score >= 650 THEN 'Medium'
            ELSE 'Low'
        END AS credit_group
    FROM customer_transactions
) AS customer_data
GROUP BY credit_group;


WITH customer_base AS (
    SELECT DISTINCT
        client_id,
        credit_score,
        yearly_income,
        total_debt,
        total_debt / yearly_income AS dti,
        CASE
            WHEN credit_score >= 750 THEN 'High'
            WHEN credit_score >= 650 THEN 'Medium'
            ELSE 'Low'
        END AS credit_group
    FROM customer_transactions
),

transaction_stats AS (
    SELECT
        client_id,
        COUNT(*) AS total_transactions,
        SUM(amount) AS total_spending,
        AVG(amount) AS avg_transaction_amount,
        STDDEV(amount) AS transaction_stddev
    FROM customer_transactions
    GROUP BY client_id
)

SELECT
    c.client_id,
    c.credit_score,
    c.credit_group,
    c.yearly_income,
    c.total_debt,
    c.dti,
    t.total_transactions,
    t.total_spending,
    t.avg_transaction_amount,
    t.transaction_stddev,
    CASE
        WHEN c.dti >= 0.50 THEN 1
        ELSE 0
    END AS high_dti_flag
FROM customer_base AS c
LEFT JOIN transaction_stats AS t
    ON c.client_id = t.client_id;
    
    
    WITH customer_base AS (
    SELECT DISTINCT
        client_id,
        credit_score,
        yearly_income,
        total_debt,
        total_debt / yearly_income AS dti
    FROM customer_transactions
)

SELECT
    risk_segment,
    COUNT(*) AS customers,
    ROUND(
        COUNT(*) * 100.0 / (SELECT COUNT(*) FROM customer_base),
        2
    ) AS percentage_of_customers
FROM (
    SELECT
        client_id,
        credit_score,
        dti,
        CASE
            WHEN credit_score < 650 AND dti >= 0.50
                THEN 'High Risk'
            WHEN credit_score < 650 OR dti >= 0.50
                THEN 'Elevated Risk'
            ELSE 'Standard Risk'
        END AS risk_segment
    FROM customer_base
) AS risk_data
GROUP BY risk_segment
ORDER BY
    CASE risk_segment
        WHEN 'High Risk' THEN 1
        WHEN 'Elevated Risk' THEN 2
        WHEN 'Standard Risk' THEN 3
    END;
    
    
    WITH customer_base AS (
    SELECT DISTINCT
        client_id,
        credit_score,
        yearly_income,
        total_debt,
        total_debt / yearly_income AS dti
    FROM customer_transactions
),

risk_data AS (
    SELECT
        client_id,
        credit_score,
        yearly_income,
        total_debt,
        dti,
        CASE
            WHEN credit_score < 650 AND dti >= 0.50
                THEN 'High Risk'
            WHEN credit_score < 650 OR dti >= 0.50
                THEN 'Elevated Risk'
            ELSE 'Standard Risk'
        END AS risk_segment
    FROM customer_base
)

SELECT
    risk_segment,
    COUNT(*) AS customers,
    ROUND(AVG(credit_score), 2) AS avg_credit_score,
    ROUND(AVG(dti) * 100, 2) AS avg_dti_percentage,
    ROUND(AVG(total_debt), 2) AS avg_debt,
    ROUND(AVG(yearly_income), 2) AS avg_income
FROM risk_data
GROUP BY risk_segment
ORDER BY
    CASE risk_segment
        WHEN 'High Risk' THEN 1
        WHEN 'Elevated Risk' THEN 2
        WHEN 'Standard Risk' THEN 3
    END;