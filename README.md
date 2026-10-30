# Modern Data Stack: E-Commerce Analytics (Snowflake + dbt)

An end-to-end data transformation pipeline built using **Snowflake** and **dbt Core**, implementing Kimball dimensional modeling (Star Schema) and automated data quality testing on transactional e-commerce data.

---

## Architecture Overview
[ RAW Data (Snowflake) ]
│
▼
[ Staging Layer (Views) ]
├── stg_customers
├── stg_orders
└── stg_payments
│
▼
[ Marts / Dimensional Layer (Tables) ]
├── fct_orders (Fact Table)
└── dim_customers (Dimension Table with Customer Lifetime Value)