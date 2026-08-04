{{
  config(
         materialized = 'incremental'
         )
}}

SELECT
* 
FROM {{source("landing",'orders')}}

-- source time ≥ target time
{% if is_incremental() %}

WHERE created_at > (SELECT coalesce(max(created_at), '1900-01-01') FROM {{ this }})

{% endif %}