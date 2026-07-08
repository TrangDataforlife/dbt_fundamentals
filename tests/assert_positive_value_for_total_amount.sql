SELECT
payment_id,
SUM(amount) as total 
FROM {{ref('stg_stripe__payments')}}
GROUP BY 1
HAVING total < 0