with source as (

    select * from {{ source('ecommerce', 'raw_orders') }}

),

transformed as (

    select
        id as order_id,
        user_id as customer_id,
        order_date,
        status as order_status
    from source

)

select * from transformed