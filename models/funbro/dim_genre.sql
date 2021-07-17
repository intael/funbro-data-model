{{
    config(
        materialized='incremental'
    )
}}

WITH genres AS
(
    SELECT DISTINCT unnest(string_to_array(genres, ',')) as genre
    FROM
        {{ source("staging", "title_basics")}}
)

SELECT
     {{ dbt_utils.surrogate_key(
      ['g.genre']
    ) }}::UUID as id,
    g.genre
FROM
    genres g
LEFT JOIN
    {{ this }} ge
ON ge.id = {{ dbt_utils.surrogate_key(
      ['g.genre']
    ) }}::UUID
WHERE ge.id IS NULL