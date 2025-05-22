{% macro format_date(date_column) %}
    TO_CHAR(TO_DATE({{ date_column }}, 'dd/MM/yyyy'), 'yyyy-MM-dd')
{% endmacro %}