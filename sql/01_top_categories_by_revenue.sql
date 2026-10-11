-- Top 10 product categories by revenue (delivered orders only)
SELECT p.product_category_name_english AS category,
       ROUND(SUM(i.price), 2)          AS revenue,
       COUNT(DISTINCT i.order_id)      AS orders
FROM items i
JOIN orders o   ON o.order_id = i.order_id
JOIN products p ON p.product_id = i.product_id
WHERE o.order_status = 'delivered'
GROUP BY category
ORDER BY revenue DESC
LIMIT 10;