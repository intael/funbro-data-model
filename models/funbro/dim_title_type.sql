{{
    config(
        materialized='incremental'
    )
}}

WITH title_types AS
(
    SELECT DISTINCT titletype
    FROM
        {{ source("staging", "title_basics")}}
)

SELECT
     {{ dbt_utils.surrogate_key(
      ['titletype']
    ) }}::UUID as id,
    titletype AS title_type
FROM title_types
WHERE {{ dbt_utils.surrogate_key(
      ['titletype']
    ) }}::UUID NOT IN (SELECT id FROM {{ this }}) 