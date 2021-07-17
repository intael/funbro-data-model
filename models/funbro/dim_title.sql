{{
    config(
        materialized='incremental'
    )
}}

SELECT
    {{ dbt_utils.surrogate_key(
      ['tb.tconst']
    ) }}::UUID AS id,
    tb.tconst,
    tt.id AS title_type_id,
    tb.primarytitle AS primary_title,
    tb.originaltitle AS original_title,
    tb.isadult AS is_adult,
    tb.startyear AS start_year,
    tb.endyear AS end_year,
    tb.runtimeminutes AS runtime_in_minutes
FROM
    {{ source("staging", "title_basics")}} tb
LEFT JOIN
    {{ ref("dim_title_type")}} tt ON tt.id = {{ dbt_utils.surrogate_key(
      ['tb.titletype']
    ) }}::UUID
LEFT JOIN
    {{ this }} dim ON dim.id = {{ dbt_utils.surrogate_key(
      ['tb.tconst']
    ) }}::UUID

WHERE
    dim.id IS NULL