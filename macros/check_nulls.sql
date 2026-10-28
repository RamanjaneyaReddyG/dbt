{% macro check_nulls(table_name, column_list) %}
{% set null_conditions = [] %}
{% for col in column_list %}
{% do null_conditions.append(col ~ ' IS NULL ') %}
{% endfor %}

select 
*,
case when {{ null_conditions | join(' OR ')  }} then 'FAIL'
else 'PASS' end as null_check_status
from {{ table_name }}
{% endmacro %}