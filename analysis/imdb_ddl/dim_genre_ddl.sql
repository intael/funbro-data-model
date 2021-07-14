drop table if exists imdb_dev.dim_genre;
create table imdb_dev.dim_genre
(
    id    UUID NOT NULL,
    genre VARCHAR(30) NOT NULL,
    PRIMARY KEY(id)
);

alter table imdb_dev.dim_genre
    owner to dbt;

grant select on imdb_dev.dim_genre to api;