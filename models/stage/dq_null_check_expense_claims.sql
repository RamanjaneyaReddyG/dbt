{{ config(materialized='table',
database='RAW',
alias='dq_null_check_expense_claims') }}

with dq_check as (
    {{ check_nulls(ref('stg_expense_claims'), ['claim_id', 'employee_id', 'claimed_amount']) }}
)

select * from dq_check
where null_check_status='FAIL'