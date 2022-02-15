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

/***
We would like to identify top performing sales reps,
which are sales reps associated with more than 200 orders.
Create a table with the sales rep name, the total number of orders,
and a column with top or not depending on if they have more than 200 orders.
Place the top sales people first in your final table.

The previous didn't account for the middle,
nor the dollar amount associated with the sales. 
Management decides they want to see these characteristics represented as well.
We would like to identify top performing sales reps,
which are sales reps associated with more than 200 orders or more than 750000 in total sales.
The middle group has any rep with more than 150 orders or 500000 in sales. Create a table with the sales rep name,
the total number of orders, total sales across all orders, and a column with top, middle, or low depending on this criteria.
Place the top sales people based on dollar amount of sales first in your final table.
You might see a few upset sales people by this criteria!***/

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