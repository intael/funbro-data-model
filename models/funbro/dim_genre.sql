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
      ['genre']
    ) }}::UUID as id,
    genre
FROM genres
WHERE {{ dbt_utils.surrogate_key(
      ['genre']
    ) }}::UUID NOT IN (SELECT id FROM {{ this }}) 