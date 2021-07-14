drop table if exists imdb_dev.dim_title CASCADE;

create table imdb_dev.dim_title
(
    id                 UUID        NOT NULL,
    tconst             VARCHAR(10) NOT NULL,
    title_type_id      UUID        NOT NULL,
    primary_title      TEXT,
    original_title     text,
    is_adult           BOOL,
    start_year         INTEGER,
    end_year           INTEGER,
    runtime_in_minutes INTEGER,
    PRIMARY KEY (id),
    CONSTRAINT fk_title_type
        FOREIGN KEY (title_type_id)
            REFERENCES imdb_dev.dim_title_type (id)
);

alter table imdb_dev.dim_title
    owner to dbt;

grant select on imdb_dev.dim_title to api;