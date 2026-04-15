** End-to-End Analytics Engineering Project**

 **Overview**

This project demonstrates a complete analytics engineering pipeline from raw data generation to business intelligence dashboards.

It covers:

* Data generation using Python
* Data storage and transformation using SQL Server
* Data modeling (Star Schema)
* Visualization using Power BI
* Deployment to Power BI Service

---

**Architecture**

Raw Data → Staging Layer → Data Mart → Power BI Dashboard

---

**Tech Stack**

* Python (Pandas, Faker)
* SQL Server (SSMS)
* Power BI
* Git & GitHub

---

**Project Structure**

* `data/raw/` → Generated CSV files
* `scripts/data_generation/` → Python scripts
* `scripts/sql/` → SQL scripts (DDL, staging, mart)
* `powerbi/` → Power BI dashboard
* `docs/` → Architecture diagrams

---

**Data Pipeline**

 1. Data Generation

Synthetic data generated using Python (Faker library)

 2. Data Ingestion

CSV files loaded into SQL Server using BULK INSERT

 3. Staging Layer

    * Data cleaning
    * Standardization
    * Derived columns

 4. Data Mart (Star Schema)

    * Fact Tables:
    
      * fact_orders
      * fact_order_items
      * fact_events
    * Dimension Tables:
    
      * dim_customers
      * dim_products
      * dim_date

 5. Visualization (Interactive dashboards built in Power BI) :

      * Executive Summary
      * Customer Analytics
      * Product Insights
      * Sales Trends
      * Funnel Analysis

---

**Key Features**

* End-to-end data pipeline
* Star schema modeling
* DAX-based KPIs
* Funnel analysis
* Customer segmentation
* Revenue analytics

---

**Sample Insights**

* Revenue trends over time
* Top-performing products
* Customer lifetime value
* Conversion funnel drop-off

---

**Deployment**

Dashboard published to Power BI Service.

---

**Learnings**

* Data modeling best practices
* Handling cyclic dependencies
* Building scalable analytics pipelines
* Designing business dashboards

---

**Author**

Swetha

---
