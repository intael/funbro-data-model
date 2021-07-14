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
    using ( genre )
    LEFT JOIN
        {{ ref("dim_title")}} tt
    ON t.tconst = tt.tconst
)

SELECT
     title_id, genre_id
FROM
    title_ids_and_genre_ids
WHERE (title_id, genre_id) NOT IN (SELECT title_id, genre_id FROM {{ this }}) 