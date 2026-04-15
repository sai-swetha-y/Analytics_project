SELECT 
    o.order_id,
    o.customer_id,
    o.order_date,
    o.status,

    SUM(oi.total_price) AS total_order_value,
    COUNT(oi.order_item_id) AS total_items,

    MAX(p.amount) AS payment_amount,
    MAX(p.is_success) AS payment_success_flag

INTO mart.fact_orders
FROM staging.stg_orders o
LEFT JOIN staging.stg_order_items oi 
    ON o.order_id = oi.order_id
LEFT JOIN staging.stg_payments p 
    ON o.order_id = p.order_id
GROUP BY 
    o.order_id,
    o.customer_id,
    o.order_date,
    o.status;


SELECT 
    c.customer_id,
    c.customer_name,
    c.email,
    c.city,
    c.country,
    c.signup_date,
    c.customer_segment,

    COUNT(o.order_id) AS total_orders,
    SUM(f.total_order_value) AS lifetime_value

INTO mart.dim_customers
FROM staging.stg_customers c
LEFT JOIN staging.stg_orders o 
    ON c.customer_id = o.customer_id
LEFT JOIN mart.fact_orders f 
    ON o.order_id = f.order_id
GROUP BY 
    c.customer_id,
    c.customer_name,
    c.email,
    c.city,
    c.country,
    c.signup_date,
    c.customer_segment;



SELECT 
    p.product_id,
    p.product_name,
    p.category,
    p.price,
    p.price_bucket,

    SUM(oi.quantity) AS total_quantity_sold,
    SUM(oi.total_price) AS total_revenue

INTO mart.dim_products
FROM staging.stg_products p
LEFT JOIN staging.stg_order_items oi
    ON p.product_id = oi.product_id
GROUP BY 
    p.product_id,
    p.product_name,
    p.category,
    p.price,
    p.price_bucket;



    SELECT 
    customer_id,
    COUNT(*) AS total_events,
    SUM(is_conversion) AS total_conversions,

    CAST(SUM(is_conversion) * 1.0 / COUNT(*) AS DECIMAL(10,2)) AS conversion_rate

INTO mart.customer_behavior
FROM staging.stg_events
GROUP BY customer_id;


SELECT DISTINCT
    order_date AS date_key,
    YEAR(order_date) AS year,
    MONTH(order_date) AS month,
    DATENAME(MONTH, order_date) AS month_name,
    DATENAME(WEEKDAY, order_date) AS day_name

INTO mart.dim_date
FROM staging.stg_orders;


SELECT 
    oi.order_item_id,
    oi.order_id,
    o.customer_id,
    o.order_date,
    o.status,

    oi.product_id,
    oi.quantity,
    oi.total_price,

    p.amount AS payment_amount,
    p.is_success AS payment_success_flag

INTO mart.fact_order_items
FROM staging.stg_order_items oi
JOIN staging.stg_orders o
    ON oi.order_id = o.order_id
LEFT JOIN staging.stg_payments p
    ON oi.order_id = p.order_id;


    SELECT 
    e.event_id,
    e.customer_id,
    e.event_type,
    e.event_timestamp,

    CAST(e.event_timestamp AS DATE) AS event_date,
    DATEPART(HOUR, e.event_timestamp) AS event_hour,

    -- Derived flags
    CASE WHEN e.event_type = 'view' THEN 1 ELSE 0 END AS is_view,
    CASE WHEN e.event_type = 'click' THEN 1 ELSE 0 END AS is_click,
    CASE WHEN e.event_type = 'add_to_cart' THEN 1 ELSE 0 END AS is_add_to_cart,
    CASE WHEN e.event_type = 'purchase' THEN 1 ELSE 0 END AS is_purchase

INTO mart.fact_events
FROM staging.stg_events e;