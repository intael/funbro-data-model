# Funbro Data Model
This repo contains the data model of the funbro app. DBT is used to update, build and auto-document the data model. 

The target database is postgres and the connection details live in the `profiles.yml` file.

## Development

DBT expects the `profiles.yml` file to live under `~/.dbt/profiles.yml` but it is possible to pass it a custom path with the `--profiles-dir` flag. An example `profiles.yml` is included in the root of this repo for convenience. You can use it right away by adding the  `--profiles-dir .` flag.

## Postgres instance configuration

By default, the `profiles.yml` file included in this repo requires connecting to postgres securely using SSL. DBT expects a folder to exist in your home directory named `~/.postgresql` containing the following 3 required files:

- postgresql.crt
- postgresql.key
- root.crt

Read more about that [here](https://www.postgresql.org/docs/13/libpq-ssl.html). Alternatively, you can just connect with user and password if your postgres instance is not configured to accept only SSL connections. Read more in the [DBT docs on configuring postgres](https://test-next--docs-getdbt-com.netlify.app/reference/warehouse-profiles/postgres-profile).

It's a good idea to tune the instance accordingly, since postgres defaults are very conservative. [This site](https://pgtune.leopard.in.ua/#/) can help a lot along [this reference](https://postgresqlco.nf/).

## Usage
We will manage the environment with poetry:
```shell
poetry env use <your virtualenv path>
poetry shell
poetry update
```

Run the entire model:
```shell
dbt run
```

Same but only for a given model:
```shell
dbt run --model funbro.dim_title_genre
```

Run all the database tests (schema and data tests):
```shell
dbt test
```

You can render the models and check them running the following and then checking the `target` directory:
```shell
dbt compile
```

Generate and serve the docs (exposes a static site at port 8080):
```shell
dbt docs generate && dbt docs serve
```


### Resources:
- Learn more about dbt [in the docs](https://docs.getdbt.com/docs/introduction)
- Check out [Discourse](https://discourse.getdbt.com/) for commonly asked questions and answers
- Join the [chat](http://slack.getdbt.com/) on Slack for live discussions and support
- Find [dbt events](https://events.getdbt.com) near you
- Check out [the blog](https://blog.getdbt.com/) for the latest news on dbt's development and best practices
