SELECT 
    customer_id,
    UPPER(LTRIM(RTRIM(name))) AS customer_name,
    LOWER(email) AS email,
    city,
    country,
    CAST(signup_date AS DATE) AS signup_date,
    
    -- Derived columns
    DATEDIFF(DAY, signup_date, GETDATE()) AS customer_age_days,
    
    CASE 
        WHEN DATEDIFF(DAY, signup_date, GETDATE()) < 30 THEN 'NEW'
        WHEN DATEDIFF(DAY, signup_date, GETDATE()) < 180 THEN 'ACTIVE'
        ELSE 'OLD'
    END AS customer_segment

INTO staging.stg_customers
FROM customers;



SELECT 
    product_id,
    UPPER(product_name) AS product_name,
    category,
    price,

    -- Derived
    CASE 
        WHEN price < 50 THEN 'LOW'
        WHEN price < 200 THEN 'MEDIUM'
        ELSE 'HIGH'
    END AS price_bucket

INTO staging.stg_products
FROM products
WHERE price > 0;


SELECT 
    order_id,
    customer_id,
    CAST(order_date AS DATE) AS order_date,
    
    CASE 
        WHEN status IN ('Completed','Cancelled','Returned') THEN status
        ELSE 'UNKNOWN'
    END AS status,

    -- Derived
    YEAR(order_date) AS order_year,
    MONTH(order_date) AS order_month,
    DATENAME(WEEKDAY, order_date) AS order_day_name

INTO staging.stg_orders
FROM orders;


SELECT 
    order_item_id,
    order_id,
    product_id,
    quantity,
    total_price,

    -- Derived
    CASE 
        WHEN quantity = 1 THEN 'SINGLE'
        ELSE 'BULK'
    END AS order_type,

    total_price / NULLIF(quantity,0) AS unit_price

INTO staging.stg_order_items
FROM order_items
WHERE quantity > 0;


SELECT 
    payment_id,
    order_id,
    amount,
    payment_method,
    payment_status,

    -- Derived
    CASE 
        WHEN payment_status = 'Success' THEN 1
        ELSE 0
    END AS is_success

INTO staging.stg_payments
FROM payments;


SELECT 
    event_id,
    customer_id,
    event_type,
    event_timestamp,

    -- Derived
    CAST(event_timestamp AS DATE) AS event_date,
    DATEPART(HOUR, event_timestamp) AS event_hour,

    CASE 
        WHEN event_type = 'purchase' THEN 1
        ELSE 0
    END AS is_conversion

INTO staging.stg_events
FROM events;


