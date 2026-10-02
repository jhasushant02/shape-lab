-- ============================================================
-- Pizza Sales Analysis | MySQL
-- Tables: orders, order_details, pizza_types, pizzas
-- Note: in MySQL the orders columns are named order_date / order_time
--       (the CSV headers are `date` / `time`).
-- Questions are numbered to match questions.md
-- ============================================================

-- Q1. Retrieve the total number of orders placed.
SELECT COUNT(order_id) AS total_orders
FROM orders;

-- Q2. Calculate the total revenue generated from pizza sales.
SELECT ROUND(SUM(od.quantity * pz.price), 2) AS total_revenue
FROM order_details od
JOIN pizzas pz ON pz.pizza_id = od.pizza_id;

-- Q3. Calculate the total pizza sold.
SELECT SUM(quantity) AS Total_Pizza_Sold
FROM order_details;

-- Q4. Identify the highest-priced pizza.
SELECT pzt.name, pz.price
FROM pizza_types pzt
JOIN pizzas pz ON pzt.pizza_type_id = pz.pizza_type_id
ORDER BY pz.price DESC
LIMIT 1;

-- Q5. Identify the most common pizza size ordered.
SELECT pz.size AS pizza_size,
       COUNT(pz.size)   AS order_lines,
       SUM(od.quantity) AS Total_Ordered
FROM order_details od
JOIN pizzas pz ON od.pizza_id = pz.pizza_id
GROUP BY pizza_size
ORDER BY Total_Ordered DESC
LIMIT 1;

-- Q6. Calculate the percentage sales by pizza size.
WITH cte AS (
  SELECT pz.size AS pizza_size,
         ROUND(SUM(od.quantity * pz.price), 2) AS total_price
  FROM pizza_types pzt
  JOIN pizzas pz ON pzt.pizza_type_id = pz.pizza_type_id
  JOIN order_details od ON od.pizza_id = pz.pizza_id
  GROUP BY pz.size
)
SELECT pizza_size,
       CAST(SUM(total_price) AS DECIMAL(10,2)) AS Total_Revenue,
       CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) FROM cte) AS DECIMAL(10,2)) AS PCT
FROM cte
GROUP BY pizza_size
ORDER BY pizza_size;

-- Q7. Calculate the total pizza sold by each pizza category.
SELECT pzt.category AS pizza_category,
       SUM(od.quantity) AS Total_Quantity_Sold
FROM pizza_types pzt
JOIN pizzas pz ON pzt.pizza_type_id = pz.pizza_type_id
JOIN order_details od ON pz.pizza_id = od.pizza_id
GROUP BY pizza_category
ORDER BY Total_Quantity_Sold DESC;

-- Q7 (variant). Same question, February only.
SELECT pzt.category AS pizza_category,
       SUM(od.quantity) AS Total_Quantity_Sold
FROM pizza_types pzt
JOIN pizzas pz ON pzt.pizza_type_id = pz.pizza_type_id
JOIN order_details od ON pz.pizza_id = od.pizza_id
JOIN orders o ON od.order_id = o.order_id
WHERE MONTH(o.order_date) = 2
GROUP BY pizza_category
ORDER BY Total_Quantity_Sold DESC;

-- Q8. List the top 5 most ordered pizza types along with their quantities.
SELECT pzt.name AS pizza_name, SUM(od.quantity) AS pizza_quantity
FROM pizza_types pzt
JOIN pizzas pz ON pzt.pizza_type_id = pz.pizza_type_id
JOIN order_details od ON od.pizza_id = pz.pizza_id
GROUP BY pizza_name
ORDER BY pizza_quantity DESC
LIMIT 5;

-- Q9. List the least 5 ordered pizza types along with their quantities.
SELECT pzt.name AS pizza_name, SUM(od.quantity) AS pizza_quantity
FROM pizza_types pzt
JOIN pizzas pz ON pzt.pizza_type_id = pz.pizza_type_id
JOIN order_details od ON od.pizza_id = pz.pizza_id
GROUP BY pizza_name
ORDER BY pizza_quantity ASC
LIMIT 5;

-- Q10. Total quantity of each pizza category ordered.
SELECT pzt.category, SUM(od.quantity) AS total_ordered
FROM pizza_types pzt
JOIN pizzas pz ON pzt.pizza_type_id = pz.pizza_type_id
JOIN order_details od ON od.pizza_id = pz.pizza_id
GROUP BY pzt.category
ORDER BY total_ordered DESC;

-- Q11. Percentage sales by each pizza category.
WITH cte AS (
  SELECT pzt.category AS pizza_category,
         ROUND(SUM(od.quantity * pz.price), 2) AS total_price
  FROM pizza_types pzt
  JOIN pizzas pz ON pzt.pizza_type_id = pz.pizza_type_id
  JOIN order_details od ON od.pizza_id = pz.pizza_id
  GROUP BY pzt.category
)
SELECT pizza_category,
       CAST(SUM(total_price) AS DECIMAL(10,2)) AS Total_Revenue,
       CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) FROM cte) AS DECIMAL(10,2)) AS PCT
FROM cte
GROUP BY pizza_category;

-- Q12. Daily trend of orders.
SELECT DAYNAME(o.order_date) AS Order_Day,
       COUNT(DISTINCT od.order_id) AS Total_Orders
FROM orders o
JOIN order_details od ON o.order_id = od.order_id
GROUP BY DAYNAME(o.order_date)
ORDER BY DAYNAME(o.order_date);

-- Q13. Hourly trend of orders.
SELECT HOUR(o.order_time) AS hours,
       COUNT(DISTINCT o.order_id) AS total_orders,
       SUM(od.quantity) AS total_quantity
FROM orders o
JOIN order_details od ON o.order_id = od.order_id
GROUP BY HOUR(o.order_time)
ORDER BY hours ASC;

-- Q14. Distribution of orders by hour of the day.
SELECT HOUR(order_time) AS Order_Hour,
       COUNT(order_id)  AS Orders
FROM orders
GROUP BY HOUR(order_time);

-- Q15. Category-wise distribution of pizzas (number of menu items per category).
SELECT category, COUNT(name) AS menu_items
FROM pizza_types
GROUP BY category;

-- Q16. Average number of pizzas ordered per day.
WITH cte AS (
  SELECT o.order_date AS O_Date, SUM(od.quantity) AS qty
  FROM orders o
  JOIN order_details od ON o.order_id = od.order_id
  GROUP BY O_Date
)
SELECT ROUND(AVG(qty), 0) AS avg_pizza_ordered_per_day
FROM cte;

-- Q17. Average order value.
WITH cte AS (
  SELECT ROUND(SUM(od.quantity * pz.price), 2) AS total_price,
         COUNT(DISTINCT od.order_id) AS total_orders
  FROM order_details od
  JOIN pizzas pz ON od.pizza_id = pz.pizza_id
)
SELECT total_price / total_orders AS Avg_Order_Value
FROM cte;

-- Q18. Average pizzas per order.
SELECT CAST(
         CAST(SUM(quantity) AS DECIMAL(10,2)) /
         CAST(COUNT(DISTINCT order_id) AS DECIMAL(10,2))
       AS DECIMAL(10,2)) AS Avg_Pizzas_Per_Order
FROM order_details;

-- Q19. Top 3 pizza types by revenue.
SELECT pzt.name AS P_name,
       ROUND(SUM(pz.price * od.quantity), 2) AS Revenue
FROM pizza_types pzt
JOIN pizzas pz ON pz.pizza_type_id = pzt.pizza_type_id
JOIN order_details od ON od.pizza_id = pz.pizza_id
GROUP BY P_name
ORDER BY Revenue DESC
LIMIT 3;

-- Q20. Percentage contribution of each pizza type to total revenue.
WITH revenue AS (
  SELECT pzt.name AS P_name,
         ROUND(SUM(pz.price * od.quantity), 2) AS rev
  FROM pizza_types pzt
  JOIN pizzas pz ON pz.pizza_type_id = pzt.pizza_type_id
  JOIN order_details od ON od.pizza_id = pz.pizza_id
  GROUP BY P_name
),
total_sales AS (
  SELECT ROUND(SUM(od.quantity * pz.price), 2) AS ts
  FROM order_details od
  JOIN pizzas pz ON pz.pizza_id = od.pizza_id
)
SELECT P_name,
       ROUND((rev / (SELECT ts FROM total_sales)) * 100, 2) AS percentage
FROM revenue;

-- Q21. Revenue per day and its percentage contribution to total revenue.
WITH rvpd AS (
  SELECT DATE(o.order_date) AS Ord_date,
         ROUND(SUM(od.quantity * pz.price), 2) AS revenue_per_day
  FROM orders o
  JOIN order_details od ON o.order_id = od.order_id
  JOIN pizzas pz ON od.pizza_id = pz.pizza_id
  GROUP BY Ord_date
),
total_sales AS (
  SELECT ROUND(SUM(od.quantity * pz.price), 2) AS ts
  FROM order_details od
  JOIN pizzas pz ON pz.pizza_id = od.pizza_id
)
SELECT Ord_date, revenue_per_day,
       ROUND((revenue_per_day / (SELECT ts FROM total_sales)) * 100, 2) AS percentage
FROM rvpd;

-- Q22. Cumulative revenue over time.
WITH sales AS (
  SELECT o.order_date AS Ord_date,
         ROUND(SUM(od.quantity * pz.price), 2) AS revenue_per_day
  FROM orders o
  JOIN order_details od ON o.order_id = od.order_id
  JOIN pizzas pz ON od.pizza_id = pz.pizza_id
  GROUP BY Ord_date
)
SELECT Ord_date,
       SUM(revenue_per_day) OVER (ORDER BY Ord_date) AS cum_revenue
FROM sales;

-- Q23. Top 3 pizza types by revenue within each category.
WITH cte AS (
  SELECT pzt.category AS cat, pzt.name AS pname,
         ROUND(SUM(od.quantity * pz.price), 2) AS revenue
  FROM pizza_types pzt
  JOIN pizzas pz ON pzt.pizza_type_id = pz.pizza_type_id
  JOIN order_details od ON od.pizza_id = pz.pizza_id
  GROUP BY cat, pname
),
ranking AS (
  SELECT cat, pname, revenue,
         RANK() OVER (PARTITION BY cat ORDER BY revenue DESC) AS rnk
  FROM cte
)
SELECT * FROM ranking
WHERE rnk <= 3;
