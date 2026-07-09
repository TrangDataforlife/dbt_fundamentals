{#
Bài tập 3: Pivot doanh thu theo phương thức thanh toán (Stripe Data)
Yêu cầu: Bảng thanh toán từ Stripe (stg_payments) 
chứa cột payment_method với các giá trị: 'credit_card', 'coupon', 'bank_transfer', 'gift_card'. 
Thay vì viết 4 dòng SUM(CASE WHEN...) thủ công, 
hãy dùng vòng lặp Jinja để tính tổng số tiền (amount) tương ứng của từng phương thức thanh toán 
cho mỗi order_id.
#}

{% set payment_methods = ['credit_card', 'coupon', 'bank_transfer', 'gift_card'] %}

select 
    order_id,
    {% for payment_method in payment_methods %}
        sum(
            case 
                when payment_method = '{{payment_method}}' then amount else 0
            end 
        ) as {{payment_method}}_amount{% if not loop.last %},{% endif %}
    {% endfor %}
from {{ ref('stg_stripe__payments') }}
group by 1