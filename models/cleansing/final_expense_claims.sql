with base as (
    select * from {{ ref('stg_ranked_claims')}}
),
dq_check as (
    select *,
    case when ({{check_null_conditions(['claim_id', 'employee_id', 'claimed_amount'])}}) then 'FAIL'
    ELSE 'PASS' end as dq_check_status,
    case when claimed_amount>10000 and expense_type in ('TRAVEL', 'FOOD') then 'VIOLATION'
    ELSE 'OK' end as policy_violation_flag
    from base
)
select 
*
from dq_check
where dq_check_status='PASS'