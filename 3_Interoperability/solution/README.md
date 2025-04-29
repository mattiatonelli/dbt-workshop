# 🏆 **The Heroic Solution**

## 1. Use dbt Sources for Standardization

Create a **source** in dbt for each of your data sources (e.g., `raw_citizens`, `raw_quests`, `raw_items`). This helps standardize the input data and enables easy reference across the project.

```yaml
version: 2

sources:
  - name: raw_citizens
    schema: _raw
    tables:
      - name: citizens
        description: "Raw data of citizens in the kingdom"
  - name: raw_quests
    schema: _raw
    tables:
      - name: quests
        description: "Raw data of quests undertaken by citizens"
  - name: raw_items
    schema: _raw
    tables:
      - name: items
        description: "Raw data of magical items used in quests"
```

Then, reference these sources in your models:

```sql
WITH citizens AS (
  SELECT * FROM {{ source('raw_citizens', 'citizens') }}
)
```

## 2. Apply the ISO 8601 date format and metric system

To standardize dates, use the ISO 8601 format (yyyy-mm-dd). Here’s how to transform raw date columns in your staging models:

## 3. Create dbt Tests for Commonly Tested Columns

Use dbt's built-in testing capabilities to make sure your data is clean and consistent:

- Test for null values in essential columns (e.g., citizen_id, quest_id).
- Test for uniqueness on columns that should be unique (e.g., citizen_id, quest_id).

In your `schema.yml`:

```yaml
version: 2

models:
  - name: processed_citizens
    description: "Processed data of citizens with consistent date format"
    columns:
      - name: citizen_id
        description: "Unique identifier for each citizen"
        tests: # <--
          - not_null # <--
          - unique # <--
      - name: first_name
        description: "First name of the citizen"
      - name: last_name
        description: "Last name of the citizen"
      - name: created_at
        description: "Date the citizen record was created"
        tests: # <--
          - not_null # <--
```
