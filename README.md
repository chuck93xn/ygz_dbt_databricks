# dbt on Databricks — Analytics Engineering

A dbt project connected to Databricks, exploring analytics engineering practices — modular SQL models, testing, snapshots and dimensional modelling — on a small retail dataset (orders, products, reviews, users).

## Tech Stack

dbt Core · dbt Cloud · Databricks SQL · Jinja · dbt_utils · dbt_expectations

## Setup

Connected to Databricks via Partner Connect (initiated from the Databricks side — connecting outward from dbt directly didn't work reliably).

**dbt Core** (primary focus of this repo):

```
python -m venv .venv_dbt
pip install dbt-databricks
dbt init
```

Configuration lives in `dbt_project.yml`, with connection details in a local `profiles.yml` (not committed — see `.gitignore`).

```
dbt debug      # verify connection
dbt run        # build all models
dbt test       # run tests
```

The same project also runs in **dbt Cloud**, using environment-based dev/prod targets — included mainly to compare the two workflows rather than as a deployment target.

## Models

Layered bronze → silver → gold, following the same medallion naming used in the other Databricks projects:

- **Bronze** — raw source tables; `orders` is incrementally materialised, `products` is snapshotted for SCD Type 2.
- **Silver** — cleaned/transformed models, referencing bronze (and the `products` snapshot) via `ref()`.
- **Gold** — star schema: `fct_order` and `fct_review` fact tables, joined to `dim_product`(SCD2 dimensions with surrogate keys) and `dim_user`.

## Testing

Generic, singular and unit tests across all layers, including `relationships` tests between fact and dimension tables, plus custom checks via `dbt_utils` and `dbt_expectations`.
