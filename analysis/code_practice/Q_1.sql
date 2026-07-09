{#
Yêu cầu 1: Viết một câu lệnh SQL để lấy toàn bộ dữ liệu từ bảng stg_jaffle_shop_order. 
Tuy nhiên, để tiết kiệm chi phí tính toán trên Snowflake khi làm việc ở máy cá nhân (môi trường dev), 
hãy thêm điều kiện lọc: Chỉ lấy dữ liệu của các đơn hàng có trạng thái là 'completed'. 
Khi dự án được deploy lên môi trường prod, điều kiện lọc này sẽ tự động biến mất để quét toàn bộ trạng thái.
#}

select *
from {{ source('jaffle_shop', 'orders') }}
{% if target.name == 'dev' %}
where status = 'completed'
{% endif %}


