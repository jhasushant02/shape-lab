-- ============================================================
-- Sales & Profit Analysis | MySQL (database: sales)
-- Tables: transactions, customers, products, markets, date
-- Note: currency is stored with a trailing \r in the dump, so TRIM() is used.
-- ============================================================

-- 1. Show all customer records
SELECT * FROM customers;

-- 2. Show total number of customers
SELECT COUNT(*) AS total_customers FROM customers;

-- 3. Show transactions for the Chennai market (market code Mark001)
SELECT * FROM transactions WHERE market_code = 'Mark001';

-- 4. Show distinct product codes that were sold in Chennai
SELECT DISTINCT product_code FROM transactions WHERE market_code = 'Mark001';

-- 5. Show transactions where currency is US dollars
SELECT * FROM transactions WHERE TRIM(currency) = 'USD';

-- 6. Show transactions in 2020, joined to the date table
SELECT t.*, d.*
FROM transactions t
INNER JOIN date d ON t.order_date = d.date
WHERE d.year = 2020;

-- 7. Show total revenue in 2020 (INR and USD rows, as recorded)
-- Fix: the original had `year = 2020 AND currency = 'INR' OR currency = 'USD'`.
-- Without parentheses, AND binds first, so the USD rows from every year were included.
SELECT SUM(t.sales_amount) AS revenue_2020
FROM transactions t
INNER JOIN date d ON t.order_date = d.date
WHERE d.year = 2020
  AND TRIM(t.currency) IN ('INR', 'USD');

-- 8. Show total revenue in January 2020
-- Fix: removed the duplicated `and and`.
SELECT SUM(t.sales_amount) AS revenue_jan_2020
FROM transactions t
INNER JOIN date d ON t.order_date = d.date
WHERE d.year = 2020
  AND d.month_name = 'January'
  AND TRIM(t.currency) IN ('INR', 'USD');

-- 9. Show total revenue in 2020 in Chennai
SELECT SUM(t.sales_amount) AS revenue_2020_chennai
FROM transactions t
INNER JOIN date d ON t.order_date = d.date
WHERE d.year = 2020
  AND t.market_code = 'Mark001';
