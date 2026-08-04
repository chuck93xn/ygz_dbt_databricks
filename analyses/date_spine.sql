{{ dbt_utils.date_spine(
    datepart="day",
    start_date="cast('2022-11-28' as date)",
    end_date="cast('2025-03-20' as date)"
   )
}}