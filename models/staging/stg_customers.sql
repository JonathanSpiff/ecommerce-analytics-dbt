with source as (

    select * from {{ source('ecommerce', 'raw_customers') }}

),

transformed as (

    select
        id as customer_id,
        first_name,
        last_name,
        email,
        created_at as customer_created_at
    from source

)

select * from transformed