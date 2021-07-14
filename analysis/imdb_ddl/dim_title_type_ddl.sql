drop table if exists imdb_dev.dim_title_type;
create table imdb_dev.dim_title_type
(
    id         UUID NOT NULL,
    title_type TEXT NOT NULL,
    PRIMARY KEY(id)
)
;

alter table imdb_dev.dim_title_type
    owner to dbt;

create index dim_title__index_on_title_id
    on imdb_dev.dim_title_type (id);

grant select on imdb_dev.dim_title_type to api;