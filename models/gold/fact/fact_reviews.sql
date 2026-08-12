{{
  config(
         materialized = 'table'
         )
}}

-- Grain: one row per review
-- product_sk is resolved to the product version that was valid on review_date (Type 2 band join)
SELECT
    r.id as review_id,
    date(date_format(r.created_at, 'yyyy-MM-dd')) as review_date,
    dp.product_sk,
    r.rating
FROM {{ ref('bronze_reviews') }} r
LEFT JOIN {{ ref('dim_products') }} dp
    ON r.product_id = dp.product_id
    AND date(date_format(r.created_at, 'yyyy-MM-dd')) >= date(dp.valid_from)
    AND (date(date_format(r.created_at, 'yyyy-MM-dd')) < date(dp.valid_to) OR dp.valid_to IS NULL)
