-- 02_analysis_queries.sql
-- Core business questions: customer experience, delivery performance, product/category performance

-- Q1: Average delivery time and late delivery rate (per order, not per item)
SELECT
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(AVG(delivery_days), 1) AS avg_delivery_days,
    ROUND(SUM(is_late) * 100.0 / COUNT(*), 1) AS pct_late_deliveries
FROM (SELECT DISTINCT order_id, delivery_days, is_late FROM orders_clean);

-- Q2: Does delivery speed affect review score?
SELECT
    CASE
        WHEN delivery_days <= 7 THEN '0-7 days'
        WHEN delivery_days <= 14 THEN '8-14 days'
        WHEN delivery_days <= 21 THEN '15-21 days'
        ELSE '22+ days'
    END AS delivery_bucket,
    COUNT(DISTINCT order_id) AS num_orders,
    ROUND(AVG(review_score), 2) AS avg_review_score
FROM orders_clean
GROUP BY delivery_bucket
ORDER BY delivery_bucket;

-- Q3: Late delivery impact on review score
SELECT
    is_late,
    COUNT(DISTINCT order_id) AS num_orders,
    ROUND(AVG(review_score), 2) AS avg_review_score
FROM orders_clean
GROUP BY is_late;

-- Q4: Top 10 product categories by revenue
SELECT
    COALESCE(product_category_name_english, 'unknown') AS category,
    COUNT(DISTINCT order_id) AS num_orders,
    ROUND(SUM(price), 2) AS total_revenue,
    ROUND(AVG(review_score), 2) AS avg_review_score
FROM orders_clean
GROUP BY category
ORDER BY total_revenue DESC
LIMIT 10;

-- Q5: Payment type breakdown
SELECT
    payment_type,
    COUNT(DISTINCT order_id) AS num_orders,
    ROUND(AVG(payment_installments), 1) AS avg_installments,
    ROUND(SUM(payment_value), 2) AS total_payment_value
FROM orders_clean
GROUP BY payment_type
ORDER BY total_payment_value DESC;

-- Q6: Orders and avg delivery time by state (top 10 states by order volume)
SELECT
    customer_state,
    COUNT(DISTINCT order_id) AS num_orders,
    ROUND(AVG(delivery_days), 1) AS avg_delivery_days,
    ROUND(AVG(review_score), 2) AS avg_review_score
FROM orders_clean
GROUP BY customer_state
ORDER BY num_orders DESC
LIMIT 10;

-- Q7: Review score distribution overall
SELECT
    review_score,
    COUNT(DISTINCT order_id) AS num_orders,
    ROUND(COUNT(DISTINCT order_id) * 100.0 / (SELECT COUNT(DISTINCT order_id) FROM orders_clean WHERE review_score IS NOT NULL), 1) AS pct
FROM orders_clean
WHERE review_score IS NOT NULL
GROUP BY review_score
ORDER BY review_score DESC;
