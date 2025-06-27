with

    -- Import CTEs
    customers as ( select * from {{ ref('stg_jaffle_shop__customers') }}),

    orders as ( select * from {{ ref('stg_jaffle_shop__orders') }}),

    payments as ( select * from {{ ref('stg_stripe__payments') }}),

    -- Logical CTEs
    completed_payments as (
        select
            order_id,
            max(payment_created_at) as payment_finalized_date,
            sum(payment_amount) as total_amount_paid
        from payments
        where payment_status <> 'fail'
        group by 1
    ),

    customer_orders as (
        select
            customers.customer_id,
            min(orders.order_placed_at) as first_order_date,
            max(orders.order_placed_at) as most_recent_order_date,
            count(orders.order_id) as number_of_orders
        from customers
        left join orders on orders.customer_id = customers.customer_id
        group by 1
    ),


    paid_orders as (
        select
            orders.order_id,
            orders.customer_id,
            orders.order_placed_at,
            orders.order_status,
            completed_payments.total_amount_paid,
            completed_payments.payment_finalized_date,
            customers.customer_first_name,
            customers.customer_last_name
        from orders 
        left join completed_payments on orders.order_id = completed_payments.order_id
        left join customers on orders.customer_id = customers.customer_id
    ),


    -- Final CTEs
final as (
    select
        paid_orders.order_id,
        paid_orders.customer_id,
        paid_orders.order_placed_at,
        paid_orders.total_amount_paid,
        paid_orders.order_status,
        paid_orders.payment_finalized_date,
        paid_orders.customer_first_name,
        paid_orders.customer_last_name,

    -- sales transaction sequence
        row_number() over (order by paid_orders.order_id) as transaction_seq,

    -- customer sales sequence 
        row_number() over (
            partition by paid_orders.customer_id order by paid_orders.order_id
        ) as customer_sales_seq,

 -- new vs returning customer       
        case
            when rank() over (
                partition by paid_orders.customer_id
                order by paid_orders.order_placed_at, paid_orders.order_id
            ) = 1 then 'new'
            else 'returning'

        end as nvsr,

 -- customer life time value           
        sum(paid_orders.total_amount_paid) over (
            partition by paid_orders.customer_id
            order by paid_orders.order_placed_at
        ) as customer_lifetime_value,

-- customer first order
        first_value(paid_orders.order_placed_at) over (
            partition by paid_orders.customer_id
            order by paid_orders.order_placed_at
        ) as fdos

    from paid_orders


    )

select * from final
