with orders as (

    -- 1. Reference the clean staging view
    select * from {{ ref('stg_orders') }}

),

payments as (

    -- 2. Reference the clean payments view
    select * from {{ ref('stg_payments') }}

),

order_payments as (

    -- 3. Aggregate payments at the order level
    -- (An order could theoretically have split payments)
    select
        order_id,
        sum(payment_amount) as total_amount
    from payments
    group by 1

),

final as (

    -- 4. Join orders with their calculated revenue amounts
    select
        orders.order_id,
        orders.customer_id,
        orders.order_date,
        orders.order_status,
        coalesce(order_payments.total_amount, 0) as order_amount
    from orders
    left join order_payments
        on orders.order_id = order_payments.order_id

)

select * from final