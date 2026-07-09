{#
Bài tập 5: Tự chế tạo Macro định dạng tiền tệ (Cents to Dollars với tham số tùy biến)
Yêu cầu: Dữ liệu số tiền amount trong bảng Stripe đang lưu ở dạng cents 
(ví dụ: số tiền là 1000 tương đương 10 USD). 
Hãy tạo một macro tên là cents_to_dollars đặt trong thư mục macros/. 
Macro này nhận vào 2 tham số: column_name (tên cột cần chia) 
và round_digits (số chữ số làm tròn, mặc định nếu không truyền gì vào thì là 2). 
Sau đó, áp dụng macro này để tính lại cột amount trong model của bạn.
#}

{% macro cents_to_dollars(col_name, decimal = 2) %}

     ROUND({{col_name}} *1.0 / 100, {{decimal}})

{% endmacro %}