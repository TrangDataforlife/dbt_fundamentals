{#
Bài tập 2: Ẩn/Hiện cột dữ liệu nhạy cảm (Data Masking)
Yêu cầu: Sếp yêu cầu bảo mật thông tin khách hàng. 
Viết một truy vấn vào bảng stg_jaffle_shop_customer. 
Nếu hệ thống nhận diện bạn đang chạy ở môi trường dev, 
cột last_name của khách hàng phải bị mã hóa/ẩn đi bằng chuỗi ký tự '***'. 
Nếu chạy ở môi trường prod, 
cột này sẽ hiển thị họ của khách hàng như bình thường.
#}

select 
    id, 
    first_name,
    {% if target.name == 'dev' %}
        '***' as last_name
    {% else %}
        last_name
    {% endif %}
from {{ source('jaffle_shop', 'customers') }}

