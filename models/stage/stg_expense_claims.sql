
with ranked_claims as (
select
claim_id ,
employee_id,
claim_date,
UPPER(expense_type) as expense_type,
claimed_amount,
currency,
LOWER(approval_status) as approval_status,
approver_id,
row_number() over(partition by claim_id order by claim_date desc) as rn
FROM RAW.PUBLIC.EXPENSE_CLAIMS
)
select
claim_id ,
employee_id,
claim_date,
UPPER(expense_type) as expense_type,
claimed_amount,
currency,
LOWER(approval_status) as approval_status,
approver_id
FROM ranked_claims
where rn=1