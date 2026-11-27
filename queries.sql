-- 01: Top 10 product categories by revenue 
SELECT t.string_field_1 AS category, ROUND(SUM(oi.price), 2) AS revenue
FROM ecommerce_raw.order_items AS oi
JOIN ecommerce_raw.products AS p ON oi.product_id = p.product_id
JOIN ecommerce_raw.product_category_name_translation AS t ON p.product_category_name = t.string_field_0
GROUP BY t.string_field_1
ORDER BY revenue DESC
LIMIT 10

--02: Monthly revenue and orders (delivered only)
SELECT FORMAT_DATE('%Y-%m', DATE(o.order_purchase_timestamp)) AS month,
  COUNT(DISTINCT o.order_id) AS orders,
  ROUND(SUM(oi.price), 2) AS revenue
FROM ecommerce_raw.orders AS o
JOIN ecommerce_raw.order_items AS oi ON o.order_id = oi.order_id
WHERE o.order_status = 'delivered'
GROUP BY month
ORDER BY month

--03: Month-over-month revenue growth (from jan 2017)
WITH monthly AS (
  SELECT FORMAT_DATE('%Y-%m', DATE(o.order_purchase_timestamp)) AS month,
   ROUND(SUM(oi.price), 2) AS revenue
  FROM ecommerce_raw.orders AS o
  JOIN ecommerce_raw.order_items AS oi ON o.order_id = oi.order_id
  WHERE o.order_status = 'delivered' AND o.order_purchase_timestamp >= '2017-01-01'
  GROUP BY month
)
SELECT month, revenue,
 LAG(revenue) OVER (ORDER BY month) AS prev_revenue,
 ROUND((revenue - LAG(revenue) OVER (ORDER BY month)) / LAG(revenue)  OVER (ORDER BY month) * 100,1) AS growth_pct
FROM monthly
ORDER BY month 

 
