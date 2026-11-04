{{ config(
    materialized='dynamic_table',
    snowflake_warehouse='COMPUTE_WH',
    database='snowflake_dt',
    schema='Transform_DT',
    target_lag='DOWNSTREAM' 
)}}
with Accessory_DT as (
select
    a.cust_id ,
    a.acc_id ,
    a.acc_CATEGORY ,
    a.acc_status ,
    a.acc_count ,
    a.acc_price
    from snowflake_dt.public.accessory_item a,
    (select cust_id,acc_id, max(acc_price) as acc_price 
    from snowflake_dt.public.accessory_item group by cust_id,acc_id) b
    where a.cust_id=b.cust_id
    and a.acc_price=b.acc_price and a.acc_id=b.acc_id
     )
select * from Accessory_DT