{{
  config(
         materialized = 'table'
         )
}}

-- Type 2 SCD: one row per product version, sourced from the snapshot
SELECT
    {{ dbt_utils.generate_surrogate_key(['id', 'dbt_valid_from']) }} as product_sk,
    id as product_id,
    title as product_name,
    category,
    ean,
    vendor,
    price,
    dbt_valid_from as valid_from,
    dbt_valid_to as valid_to,
    dbt_valid_to is null as is_current
FROM {{ ref('products_snapshot') }}
