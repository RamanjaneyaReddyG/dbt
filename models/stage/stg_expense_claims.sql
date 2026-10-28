select
claim_id ,
employee_id,
claim_date,
UPPER(expense_type) as expense_type,
claimed_amount,
currency,
LOWER(approval_status) as approval_status,
approver_id
FROM RAW.PUBLIC.EXPENSE_CLAIMS