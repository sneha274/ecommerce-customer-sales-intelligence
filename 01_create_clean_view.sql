-- 01_create_clean_view.sql
-- Purpose: Build one joined, analysis-ready view combining orders, customers,
-- order items, products, reviews, and payments.
-- We only keep 'delivered' orders since those have real delivery dates
-- and completed the full lifecycle (96,478 of 99,441 total orders).

DROP VIEW IF EXISTS orders_clean;

CREATE VIEW orders_clean AS
SELECT
    o.order_id,
    o.customer_id,
    c.customer_city,
    c.customer_state,
    o.order_purchase_timestamp,
    o.order_delivered_customer_date,
    o.order_estimated_delivery_date,
    -- Delivery time in days (purchase to actual delivery)
    CAST(julianday(o.order_delivered_customer_date) - julianday(o.order_purchase_timestamp) AS INTEGER) AS delivery_days,
    -- Was delivery late vs the estimate?
    CASE WHEN julianday(o.order_delivered_customer_date) > julianday(o.order_estimated_delivery_date)
         THEN 1 ELSE 0 END AS is_late,
    oi.product_id,
    p.product_category_name,
    ct.product_category_name_english,
    oi.price,
    oi.freight_value,
    r.review_score,
    pay.payment_type,
    pay.payment_installments,
    pay.payment_value
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
LEFT JOIN products p ON oi.product_id = p.product_id
LEFT JOIN category_translation ct ON p.product_category_name = ct.product_category_name
LEFT JOIN reviews r ON o.order_id = r.order_id
LEFT JOIN payments pay ON o.order_id = pay.order_id
WHERE o.order_status = 'delivered'
  AND o.order_delivered_customer_date IS NOT NULL;
