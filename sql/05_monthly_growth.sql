query = """
WITH monthly AS (
    SELECT strftime('%Y-%m', o.order_purchase_timestamp) AS month,
           SUM(i.price) AS revenue
    FROM orders o
    JOIN items i ON i.order_id = o.order_id
    WHERE o.order_status = 'delivered'
    GROUP BY month
)
SELECT month,
       ROUND(revenue, 2) AS revenue,
       ROUND(100.0 * (revenue - LAG(revenue) OVER (ORDER BY month))
             / LAG(revenue) OVER (ORDER BY month), 1) AS mom_growth_pct
FROM monthly
WHERE month BETWEEN '2017-01' AND '2018-08'
ORDER BY month;
"""
pd.read_sql(query, conn)