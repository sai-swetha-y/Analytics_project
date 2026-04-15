import pandas as pd
import numpy as np
import random
from faker import Faker
from datetime import datetime, timedelta

fake = Faker()

NUM_CUSTOMERS = 10000
NUM_PRODUCTS = 500
NUM_ORDERS = 15000
NUM_EVENTS = 30000

# -----------------------------
# Customers
# -----------------------------
customers = []
for i in range(1, NUM_CUSTOMERS + 1):
    customers.append([
        i,
        fake.name(),
        fake.email(),
        fake.city(),
        fake.country(),
        fake.date_between(start_date='-2y', end_date='today')
    ])

customers_df = pd.DataFrame(customers, columns=[
    "customer_id", "name", "email", "city", "country", "signup_date"
])

customers_df.to_csv("customers.csv", index=False)

# -----------------------------
# Products
# -----------------------------
categories = ["Electronics", "Clothing", "Home", "Books", "Sports"]

products = []
for i in range(1, NUM_PRODUCTS + 1):
    products.append([
        i,
        fake.word().capitalize(),
        random.choice(categories),
        round(random.uniform(10, 1000), 2)
    ])

products_df = pd.DataFrame(products, columns=[
    "product_id", "product_name", "category", "price"
])

products_df.to_csv("products.csv", index=False)

# -----------------------------
# Orders
# -----------------------------
orders = []
for i in range(1, NUM_ORDERS + 1):
    customer_id = random.randint(1, NUM_CUSTOMERS)
    order_date = fake.date_between(start_date='-1y', end_date='today')

    orders.append([
        i,
        customer_id,
        order_date,
        random.choice(["Completed", "Cancelled", "Returned"])
    ])

orders_df = pd.DataFrame(orders, columns=[
    "order_id", "customer_id", "order_date", "status"
])

orders_df.to_csv("orders.csv", index=False)

# -----------------------------
# Order Items
# -----------------------------
order_items = []
order_item_id = 1

for order_id in range(1, NUM_ORDERS + 1):
    num_items = random.randint(1, 5)

    for _ in range(num_items):
        product_id = random.randint(1, NUM_PRODUCTS)
        quantity = random.randint(1, 3)

        price = products_df.loc[products_df.product_id == product_id, "price"].values[0]

        order_items.append([
            order_item_id,
            order_id,
            product_id,
            quantity,
            round(price * quantity, 2)
        ])

        order_item_id += 1

order_items_df = pd.DataFrame(order_items, columns=[
    "order_item_id", "order_id", "product_id", "quantity", "total_price"
])

order_items_df.to_csv("order_items.csv", index=False)

# -----------------------------
# Payments
# -----------------------------
payments = []

for order_id in range(1, NUM_ORDERS + 1):
    amount = order_items_df[order_items_df.order_id == order_id]["total_price"].sum()

    payments.append([
        order_id,
        order_id,
        round(amount, 2),
        random.choice(["Credit Card", "UPI", "Net Banking", "Wallet"]),
        random.choice(["Success", "Failed"])
    ])

payments_df = pd.DataFrame(payments, columns=[
    "payment_id", "order_id", "amount", "payment_method", "payment_status"
])

payments_df.to_csv("payments.csv", index=False)

# -----------------------------
# Events (User Behavior)
# -----------------------------
event_types = ["view", "click", "add_to_cart", "purchase"]

events = []
for i in range(1, NUM_EVENTS + 1):
    customer_id = random.randint(1, NUM_CUSTOMERS)

    events.append([
        i,
        customer_id,
        random.choice(event_types),
        fake.date_time_between(start_date='-6m', end_date='now')
    ])

events_df = pd.DataFrame(events, columns=[
    "event_id", "customer_id", "event_type", "event_timestamp"
])

events_df.to_csv("events.csv", index=False)

print("✅ All CSV files generated successfully!")