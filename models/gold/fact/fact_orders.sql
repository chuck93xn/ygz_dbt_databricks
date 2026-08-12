{{
  config(
         materialized = 'table'
         )
}}

-- Grain: one row per order line
-- product_sk is resolved to the product version that was valid on order_date (Type 2 band join)
SELECT
    o.id as order_id,
    o.order_date,
    dp.product_sk,
    du.user_sk,
    o.quantity,
    o.unit_price,
    o.order_amount
FROM {{ ref('silver_orders') }} o
LEFT JOIN {{ ref('dim_products') }} dp
    ON o.product_id = dp.product_id
    AND o.order_date >= date(dp.valid_from)
    AND (o.order_date < date(dp.valid_to) OR dp.valid_to IS NULL)
LEFT JOIN {{ ref('dim_users') }} du
    ON o.user_id = du.user_id
