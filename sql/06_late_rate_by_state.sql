query = """
SELECT c.customer_state,
       COUNT(*)                          AS orders,
       ROUND(100.0 * AVG(o.is_late), 1)  AS late_pct,
       ROUND(AVG(o.delivery_days), 1)    AS avg_delivery_days
FROM orders o
JOIN customers c ON c.customer_id = o.customer_id
WHERE o.order_status = 'delivered' AND o.is_late IS NOT NULL
GROUP BY c.customer_state
HAVING COUNT(*) >= 100
ORDER BY late_pct DESC;
"""
pd.read_sql(query, conn)