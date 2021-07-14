{% macro grant_select(table, role) %}
{% set sql %}
    grant select on table {{ table }} to role {{ role }};
{% endset %}

{% do run_query(sql) %}
{% do log("Privileges granted", info=True) %}
{% endmacro %}