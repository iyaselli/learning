with orders as
(
select * from {{ ref('stg_jaffle_shop__orders') }}
),

daily as (

select  
    order_placed_at,
    count(*) as order_id

from orders
group by 1
),

compared as (
select *,

    lag(order_id) over (order by order_placed_at) as previous_day_orders
from daily
)

select * from compared