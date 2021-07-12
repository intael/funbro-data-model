

select 
    averageRating
from {{ source("staging", "title_ratings") }}
where averageRating < 0 or averageRating > 10