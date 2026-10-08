{% test salary_check(model,column_name) %}

SELECT * FROM 
{{ model }}
where {{ column_name }} < 10000

{% endtest %}