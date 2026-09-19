"""
E-Commerce Customer & Sales Intelligence - Python Deep-Dive
Repeat purchase analysis using the correct customer identifier
(customer_unique_id, not customer_id, which is unique per order).
"""
import sqlite3
import pandas as pd

conn = sqlite3.connect('ecommerce.db')
df = pd.read_sql('''
SELECT o.order_id, o.order_purchase_timestamp, c.customer_unique_id, r.review_score,
       CAST(julianday(o.order_delivered_customer_date) - julianday(o.order_purchase_timestamp) AS INTEGER) AS delivery_days
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
LEFT JOIN reviews r ON o.order_id = r.order_id
WHERE o.order_status = 'delivered' AND o.order_delivered_customer_date IS NOT NULL
''', conn)
conn.close()

# Repeat purchase rate
order_counts = df.groupby('customer_unique_id')['order_id'].nunique()
repeat_rate = (order_counts >= 2).sum() / len(order_counts) * 100
print(f'Repeat customer rate: {repeat_rate:.2f}%')

# Does first-order review score predict repeat purchase?
first_orders = df.sort_values('delivery_days').groupby('customer_unique_id').first()
first_orders['is_repeat'] = (order_counts >= 2).reindex(first_orders.index).values
print(first_orders.groupby('review_score')['is_repeat'].agg(['mean', 'count']))
