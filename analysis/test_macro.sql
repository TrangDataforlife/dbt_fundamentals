select 
    id,
    {{ clean_null_whitespace('first_name') }} as clean_first_name
from {{ ref('stg_jaffleshop_customer') }} 

{#hoặc from {{ ref('jaffle_shop', 'stg_jaffle_shop_customer') }} tùy cấu hình ref của bạn#}