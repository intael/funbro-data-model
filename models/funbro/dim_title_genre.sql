{{
    config(
        materialized='incremental'
    )
}}

WITH titles_with_genres AS
(
   SELECT DISTINCT
        tconst,
        unnest(string_to_array(genres, ',')) as genre
   FROM
        {{ source("staging", "title_basics")}}
),
title_ids_and_genre_ids AS
(
    SELECT
        tt.id as title_id,
        g.id AS genre_id
    FROM 
        titles_with_genres t
    LEFT JOIN
        {{ ref("dim_genre")}} g
    USING ( genre )
    LEFT JOIN
        {{ ref("dim_title")}} tt
    ON tt.id = {{ dbt_utils.surrogate_key(
      ['t.tconst']
    ) }}::UUID
)

SELECT
     st.title_id, st.genre_id
FROM
    title_ids_and_genre_ids st
LEFT JOIN
    {{ this }} tg
ON tg.title_id = st.title_id AND tg.genre_id = st.genre_id
WHERE tg.title_id IS NULL