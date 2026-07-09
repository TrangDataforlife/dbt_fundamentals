{% set payment_methods = ['credit_card', 'coupon', 'bank_transfer', 'gift_card'] %}

with customers as (
    select * from {{ ref('stg_jaffleshop_customer') }}
),

orders as (
    select * from {{ ref('fct_orders') }}
),

-- CTE tính toán các chỉ số thanh toán xoay ngang (Pivot) theo từng khách hàng
customer_payments as (
    select
        order_id,
        {% for payment_method in payment_methods %}
        sum(
            case 
                when payment_method = '{{ payment_method }}' then amount 
                else 0 
            end
        ) as {{ payment_method }}_amount{% if not loop.last %},{% endif %}
        {% endfor %}
    from {{ ref('stg_stripe__payments') }}
    group by 1
),

-- CTE gộp thông tin đơn hàng và tiền thanh toán theo từng khách hàng
customer_orders_summary as (
    select
        orders.customer_id,
        count(distinct orders.order_id) as number_of_orders,
        {% for payment_method in payment_methods %}
        sum(coalesce(customer_payments.{{ payment_method }}_amount, 0)) as {{ payment_method }}_total_amount{% if not loop.last %},{% endif %}
        {% endfor %}
    from orders
    left join customer_payments using (order_id)
    group by 1
),

-- CTE kết hợp thông tin định danh khách hàng và toàn bộ chỉ số 360 độ
final as (
    select
        customers.customer_id,
        {{ clean_null_whitespace('customers.first_name') }} as first_name,
        {{ clean_null_whitespace('customers.last_name') }} as last_name,
        coalesce(customer_orders_summary.number_of_orders, 0) as number_of_orders,
        {% for payment_method in payment_methods %}
        coalesce(customer_orders_summary.{{ payment_method }}_total_amount, 0) as {{ payment_method }}_total_amount{% if not loop.last %},{% endif %}
        {% endfor %}
    from customers
    left join customer_orders_summary using (customer_id)
)

select * from final

{# Cài đặt điều kiện lọc tối ưu tốc độ chạy thử trên môi trường Snowflake cá nhân #}
{% if target.name == 'dev' %}
where customer_id <= 50
{% endif %}