query = """
SELECT strftime('%Y-%m', o.order_purchase_timestamp) AS month,
       ROUND(SUM(i.price), 2)     AS revenue,
       COUNT(DISTINCT o.order_id) AS orders
FROM orders o
JOIN items i ON i.order_id = o.order_id
WHERE o.order_status = 'delivered'
GROUP BY month
ORDER BY month;
"""
pd.read_sql(query, conn)