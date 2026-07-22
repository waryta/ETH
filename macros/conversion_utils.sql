{% macro ethereum_conversion(col_name) %}

sum( {{ col_name }} )/1e6
{% endmacro %}

{% macro stablecoin_conversion(col_name) %}


sum( {{ col_name }} )/1e6

{% endmacro %}

{% macro conversion(col_name,ex) %}

sum({{ col_name }}) / 1e{{ex}}
--sum( {{ col_name }}) / power(10, {{ ex }})


{% endmacro %}

{% macro conversion2(col_name, ex) %}
    sum({{ col_name }} / power(10, {{ ex }}))
{% endmacro %}