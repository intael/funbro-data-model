select
    f.* from {{ source("staging", "title_ratings") }} f
left join 
    {{ source("staging", "title_basics") }} t using ( tconst )
where t.tconst is null