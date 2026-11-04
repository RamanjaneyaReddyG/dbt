{{ config(
    materialized='dynamic_table',
    snowflake_warehouse='COMPUTE_WH',
    database='snowflake_dt',
    schema='Transform_DT',
    target_lag='3 minutes'
)}}

with cust_acc_dt as (
    select
        c.cust_id,
        c.cust_name,
        c.total_outstanding_amt,
        c.crid,
        c.location,
        c.cust_created,
        a.acc_id,
        a.acc_category,
        a.acc_status,
        a.acc_count,
        a.acc_price
        from {{ ref('Customer_DT')}} c, {{ ref('Accessory_DT') }} a
        where c.cust_id=a.cust_id
)
select * from cust_acc_dt