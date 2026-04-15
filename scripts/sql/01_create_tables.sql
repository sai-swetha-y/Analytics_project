USE AnalyticsDB;
GO
CREATE TABLE customers (
    customer_id INT,
    name VARCHAR(100),
    email VARCHAR(100),
    city VARCHAR(50),
    country VARCHAR(50),
    signup_date DATE
);


CREATE TABLE products (
    product_id INT,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2)
);

CREATE TABLE orders (
    order_id INT,
    customer_id INT,
    order_date DATE,
    status VARCHAR(20)
);

CREATE TABLE order_items (
    order_item_id INT,
    order_id INT,
    product_id INT,
    quantity INT,
    total_price DECIMAL(10,2)
);


CREATE TABLE payments (
    payment_id INT,
    order_id INT,
    amount DECIMAL(10,2),
    payment_method VARCHAR(50),
    payment_status VARCHAR(20)
);


CREATE TABLE events (
    event_id INT,
    customer_id INT,
    event_type VARCHAR(50),
    event_timestamp DATETIME
);