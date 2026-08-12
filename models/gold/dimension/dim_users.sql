{{
  config(
         materialized = 'table'
         )
}}

-- Type 1: no history source available for users, one row per user
SELECT
    {{ dbt_utils.generate_surrogate_key(['id']) }} as user_sk,
    id as user_id,
    user_created_at,
    city,
    state,
    birth_year,
    sales_channel
FROM {{ ref('silver_users') }}
