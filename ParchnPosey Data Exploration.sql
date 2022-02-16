SELECT o.id,
a.name,
o.account_id,
SUM(o.total),
SUM(o.total_amt_usd):: money Total_Amt
FROM orders o
JOIN accounts a
ON o.account_id = a.id
WHERE a.name LIKE ('Walmart')
GROUP BY o.id,a.name,o.account_id
ORDER BY 3 DESC
LIMIT 10

---How many sales reps have worked on more than 1 account?
SELECT
s.name "Rep_Name",
COUNT(a.name) No_Of_Accounts
FROM sales_reps s
JOIN accounts a
ON s.id = a.sales_rep_id
HAVING COUNT(a.name) > 1
GROUP BY s.name

---Date FUNCTIONS
SELECT
DATE_PART('dow',occurred_at) day_of_week,
DATE_PART('day',occurred_at) day_num,
DATE_PART('month',occurred_at) month_num,
DATE_PART('year',occurred_at) year_num,
DATE_TRUNC('day',occurred_at) day_text,
DATE_TRUNC('month',occurred_at) month_text,
DATE_TRUNC('year',occurred_at) year_text
FROM orders


WITH t1 AS (SELECT
            o.id,
            o.account_id,
            a.name account_name,
            DATE_PART('year',o.occurred_at) year_num,
            SUM(o.gloss_amt_usd) gloss_total
            FROM orders o
            JOIN accounts a
            ON a.id = o.account_id
            GROUP BY 1,2,3,4)
SELECT t1.account_name, t1.year_num
FROM t1
HAVING MAX(t1.gloss_total) AND t1.account_name = 'Walmart'


/***Aggregate Functions & CASE statements***/

SELECT
o.id Order_id,
a.name Account_name,
o.standard_amt_usd std_amt,
o.standard_qty std_qty,
CASE
    WHEN o.standard_amt_usd = 0 OR o.standard_amt_usd ISNULL THEN 0
    WHEN o.standard_qty = 0 OR o.standard_qty ISNULL THEN 0
    ELSE ROUND((o.standard_amt_usd/o.standard_qty),1)
    END AS unit_price
FROM orders o
JOIN accounts a
ON o.account_id = a.id
WHERE a.name IN ('Walmart','Apple','Verizon')
GROUP BY 2,1,3,4
ORDER BY 1

/***Aggregate Functions & CASE statements***/

SELECT
s.name Rep_Name,
COUNT(*) order_count,
SUM(total_amt_usd)::money Total_Sales,
CASE
    WHEN COUNT(*) > 200 OR SUM(total_amt_usd) > 75000 THEN 'Top Percentile'
    WHEN COUNT(*) > 150 OR SUM(total_amt_usd) > 50000 THEN 'Middle Percentile'
    ELSE 'Bottom Percentile'
    END AS "Rank"
FROM orders o
JOIN accounts a
ON o.account_id = a.id
JOIN sales_reps s
ON a.sales_rep_id = s.id
GROUP BY 1
ORDER BY 3 DESC


SELECT  sales_channel,
        ROUND(AVG(event_count),2) avg_traffic
FROM
    (SELECT
    DATE_TRUNC('day',occurred_at) event_day,
    channel sales_channel,
    COUNT(*) event_count
    FROM web_events
    GROUP BY 1,2
    ) s1
GROUP BY 1
ORDER BY 2 DESC

SELECT
account_name,
SUM(total_amt),
COUNT(order_id),
CASE
    WHEN total_amt > 5000 THEN 'Over $5,000'
    WHEN total_amt < 5000 AND total_amt >= 4000 THEN '$4,000 - $5,000'
    ELSE 'Less than $4,000'
    END AS amt_group
FROM
    (
    SELECT
    o.id order_id,
    a.name account_name,
    o.occurred_at order_date,
    SUM(o.total_amt_usd) total_amt
    FROM orders o
    JOIN accounts a
    ON o.account_id = a.id
    WHERE a.name IN ('Walmart','Apple')
    GROUP BY 1,2,3
    ) sub
GROUP BY 1,4


SELECT
AVG(standard_qty) standard_avg,
AVG(gloss_qty) gloss_avg,
AVG(poster_qty) poster_avg,
SUM(total_amt_usd)
FROM orders
WHERE DATE_TRUNC('month',occurred_at) =
    (
    SELECT
    DATE_TRUNC('month',MIN(occurred_at))
    FROM orders
    )





/***Practising Subqueries***/
SELECT
sub3.rep_name, sub3.region_name, sub3.total_amt
FROM
    (SELECT
    region_name,
    MAX(total_amt) total_amt
    FROM
        (SELECT
        s.name rep_name,
        r.name region_name,
        SUM(total_amt_usd) total_amt
        FROM orders o
        JOIN accounts a
        ON o.account_id = a.id
        JOIN sales_reps s
        ON a.sales_rep_id = s.id
        JOIN region r
        ON s.region_id = r.id
        GROUP BY 1,2) sub1
    GROUP BY 1) sub2
JOIN (  SELECT
        s.name rep_name,
        r.name region_name,
        SUM(total_amt_usd) total_amt
        FROM orders o
        JOIN accounts a
        ON o.account_id = a.id
        JOIN sales_reps s
        ON a.sales_rep_id = s.id
        JOIN region r
        ON s.region_id = r.id
        GROUP BY 1,2) sub3
ON sub3.region_name = sub2.region_name AND sub3.total_amt = sub2.total_amt


/***Practising Subqueries***/
SELECT 
r.name region_name,
COUNT(*) order_count
FROM orders o
JOIN accounts a
ON o.account_id = a.id
JOIN sales_reps s
ON a.sales_rep_id = s.id
JOIN region r
ON s.region_id = r.id
HAVING SUM(o.total_amt_usd) =
    (SELECT MAX(total_amt)
    FROM    (SELECT
            r.name region_name,
            SUM(total_amt_usd) total_amt
            FROM orders o
            JOIN accounts a
            ON o.account_id = a.id
            JOIN sales_reps s
            ON a.sales_rep_id = s.id
            JOIN region r
            ON s.region_id = r.id
            GROUP BY 1) sub1)
GROUP BY 1


/***Practising Subqueries***/
SELECT
o.account_id account_no,
a.name account_name,
SUM(o.total) total_orders
FROM orders o
JOIN accounts a
ON o.account_id = a.id
HAVING SUM(o.total) > total_std
    (SELECT
    total_std
    FROM
    (   SELECT
        o.account_id account_no,
        a.name account_name,
        SUM(standard_qty) total_std
        FROM orders o
        JOIN accounts a
        ON o.account_id = a.id
        GROUP BY 1,2
        ORDER BY 3 DESC
        LIMIT 1
    ) sub
)
GROUP BY 1,2

/***Practising CTEs***/
WITH t1 AS (
    SELECT
    s.name rep_name,
    r.name region_name,
    SUM(total_amt_usd) total_amt
    FROM orders o
    JOIN accounts a
    ON o.account_id = a.id
    JOIN sales_reps s
    ON a.sales_rep_id = s.id
    JOIN region r
    ON s.region_id = r.id
    GROUP BY 1,2
),

t2 AS (
    SELECT
    region_name,
    MAX(total_amt) total_amt
    FROM t1
    GROUP BY 1
)

SELECT
t1.rep_name,
t1.region_name,
t2.total_amt
FROM t1
JOIN t2
ON t2.region_name = t1.region_name AND t1.total_amt = t2.total_amt


/***Practtising Data Cleaning***/

SELECT * FROM accounts

SELECT
RIGHT(name,1) site_extension,
COUNT(RIGHT(name,1)) extension_count,
PG_TYPEOF(RIGHT(name,1)) type_test
FROM accounts
GROUP BY 1
ORDER BY 1

SELECT
CASE
    WHEN LEFT(name,1) IN ('0','1','2','3','4','5','6','7','8','9') THEN 'Numeric'
    ELSE 'Alphabetic'
    END AS name_group,
COUNT(name) name_count,
ROUND(COUNT(name)/351,3) ratio
FROM accounts
GROUP BY 1
ORDER BY 2 DESC