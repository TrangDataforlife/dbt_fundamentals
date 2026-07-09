{#
Bài tập 4: Thống kê trạng thái đơn hàng (Jaffle Shop Data)
Yêu cầu: Bảng stg_jaffle_shop_order có cột status chứa các giá trị: 
'completed', 'shipped', 'returned', 'placed'. 
Hãy viết vòng lặp Jinja để đếm tổng số lượng đơn hàng (COUNT(order_id)) của từng trạng thái, 
nhóm theo customer_id.
#}

{% set ship_status = ['completed', 'shipped', 'returned', 'placed'] %}

select 
    customer_id,
    {% for status in ship_status %}
        sum(
            case 
                when status = '{{status}}' then 1 else 0
            end
        ) as {{status}}_count {% if not loop.last %} , {% endif %}
    {% endfor %}
from {{ref('stg_jaffleshop_order')}}
group by 1