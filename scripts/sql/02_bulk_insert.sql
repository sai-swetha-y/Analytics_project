BULK INSERT customers
FROM 'C:\Users\sweth\Documents\analytics_project\customers.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n'
);


BULK INSERT products
FROM 'C:\Users\sweth\Documents\analytics_project\products.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n'
);


BULK INSERT orders
FROM 'C:\Users\sweth\Documents\analytics_project\orders.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n'
);


BULK INSERT order_items
FROM 'C:\Users\sweth\Documents\analytics_project\order_items.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n'
);


BULK INSERT payments
FROM 'C:\Users\sweth\Documents\analytics_project\payments.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n'
);


BULK INSERT events
FROM 'C:\Users\sweth\Documents\analytics_project\events.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n'
);