# 🏆 **The Heroic Solution**

## 1. Use dbt Sources for Standardization

Define your upstream raw tables as **sources** in a new `schema.yml` inside the a a new folder `models/raw/`. This helps standardize the input data and enables easy reference across the project.

```yaml
version: 2

sources:
  - name: raw
    database: dbtworkshop
    schema: dbt_mtonelli # <-- remember to change to the schema name where your raw data tables live
    tables:
      - name: raw_citizens
      - name: raw_items
      - name: raw_quests
```

Then, reference these sources in your **bronze** models (`bronze_citizens`, `bronze_quests`, `bronze_items`). See examples below:

```sql
select
    citizen_id,
    first_name,
    last_name,
    race,
    to_char(to_date(date_of_birth, 'DD/MM/YYYY'), 'YYYY-MM-DD') as date_of_birth,
    round(height_centimeters * 30.48) as height_centimeters
from {{ source('raw', 'raw_citizens') }}
```

## 2. Apply the ISO 8601 date format and metric system

Standardize dates to the ISO 8601 format (yyyy-mm-dd) and convert measurements from feet to centimeters in the models contained in the `models/bronze/` folder. You can see the transformations in the above code snippet.

Then, to apply the changes run:

```bash
dbt run --select bronze_citizens bronze_items bronze_quests silver_citizens silver_items silver_quests gold_metrics gold_winners
```

## 3. Add dbt Tests for Commonly Tested Columns

Use **dbt's built-in tests** to validate data quality in your models. These include checks for:

- **`not_null`**: Ensures critical fields are always populated.
- **`unique`**: Confirms fields meant to be unique (like primary keys) have no duplicates.

For example, update the `schema.yml` inside the `models/bronze/` folder as below:

```yaml
---
models:
  - name: bronze_citizens
    description: Raw citizens data
    columns:
      - name: citizen_id
        description: Unique ID of the citizen
        tests: # <-- add the below tests
          - not_null
          - unique
---
```

Then run:

```bash
dbt test
```

This command will execute all defined tests and report results.
