{% set method_list = ["credit_card", "coupon", "bank_transfer", "gift_card"] %}

select 
order_id, 

{% for payment_method in method_list %} 

    sum(CASE 
            WHEN payment_method = '{{payment_method}}' THEN amount
            ELSE 0 
        END) as {{ payment_method }}_amount
    {%- if not loop.last -%}
        , 
    {% endif -%}

{% endfor %}
FROM {{ref('stg_stripe__payments')}}
GROUP BY 1