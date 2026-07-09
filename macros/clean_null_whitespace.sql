{#
Bài tập 6: Macro kiểm tra chuỗi rỗng / giá trị trống (Clean Text Helper)
Yêu cầu: Trong bảng khách hàng, có nhiều dòng trường first_name bị để trống hoặc chỉ có khoảng trắng rác. 
Hãy viết một macro nhận vào một tên cột text, tự động trả về logic: 
Nếu cột đó bị NULL hoặc có chuỗi rỗng '' 
thì sẽ điền giá trị thay thế là 'Unknown'. 
Hãy gọi macro này để dọn dẹp các trường tên của khách hàng trước khi gộp dữ liệu thành phẩm.
#}

{% macro clean_null_whitespace(text) %}
    case 
        when {{ text }} is null or trim({{ text }}) = '' then 'Unknown'
        else {{ text }}
    end
{% endmacro %}