with customers as (

    select * from {{ ref('stg_customers') }}

),

orders as (

    select * from {{ ref('fct_orders') }}

),

customer_orders as (

    -- Aggregate metrics at the customer level
    select
        customer_id,
        min(order_date) as first_order_date,
        max(order_date) as most_recent_order_date,
        count(order_id) as number_of_orders,
        sum(order_amount) as lifetime_value
    from orders
    group by 1

),

final as (

    -- Join customer profile data with their aggregated order metrics
    select
        customers.customer_id,
        customers.first_name,
        customers.last_name,
        customers.email,
        customers.customer_created_at,
        customer_orders.first_order_date,
        customer_orders.most_recent_order_date,
        coalesce(customer_orders.number_of_orders, 0) as number_of_orders,
        coalesce(customer_orders.lifetime_value, 0) as lifetime_value
    from customers
    left join customer_orders
        on customers.customer_id = customer_orders.customer_id

)

select * from final

