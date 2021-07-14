{{
    config(
        materialized='incremental'
    )
}}

SELECT
    {{ dbt_utils.surrogate_key(
      ['tconst']
    ) }}::UUID AS id,
    tconst,
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
    {{ ref("dim_title_type")}} tt ON tt.title_type = tb.titleType

WHERE {{ dbt_utils.surrogate_key(
      ['tconst']
    ) }}::UUID NOT IN (select id from {{ this }})