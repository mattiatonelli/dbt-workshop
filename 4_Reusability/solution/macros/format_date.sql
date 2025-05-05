{% macro format_date(date_column) %}
    TO_CHAR(TO_DATE({{ date_column }}, 'DD/MM/YYYY'), 'YYYY-MM-DD')
{% endmacro %}