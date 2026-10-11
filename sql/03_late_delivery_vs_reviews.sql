query = """
SELECT CASE WHEN o.is_late = 1 THEN 'Late' ELSE 'On time' END AS delivery,
       COUNT(*)                         AS orders,
       ROUND(AVG(r.review_score), 2)    AS avg_review_score
FROM orders o
JOIN reviews r ON r.order_id = o.order_id
WHERE o.order_status = 'delivered'
  AND o.is_late IS NOT NULL
GROUP BY delivery;
"""
pd.read_sql(query, conn)