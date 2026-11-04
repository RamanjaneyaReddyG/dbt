{{ config(
    materialized='dynamic_table',
    snowflake_warehouse='COMPUTE_WH',
    database='snowflake_dt',
    schema='Transform_DT',
    target_lag='DOWNSTREAM'
)}}

with Customers_DT as (
    select
     cust_id,
    cust_name,
    total_outstanding_amt,
    CRID,
    location,
    CUST_CREATED
    from snowflake_dt.public.customer
    qualify row_number() over (partition by cust_id order by cust_created desc) = 1
)
select * from Customers_DT