# 🏆 **The Heroic Solution**

## 1. Use a Clean Model Folder Structure:

Create a folder structure like this inside your dbt project:

```
models/
├── bronze/
│   ├── schema.yml
│   ├── bronze_citizens.sql
│   ├── bronze_quests.sql
│   └── bronze_items.sql
├── silver/
│   ├── schema.yml
│   ├── silver_citizens.sql
│   └── silver_quests.sql
└── gold/
    ├── schema.yml
    └── gold_winners.sql
```

This simple tree structure clearly shows the organization of your models across different stages: **bronze** for raw data, **silver** for transformed data, and **gold** for final, aggregated results. 🌟

Remember to split the original full query into subqueries, each corresponding to its model. Also, you will need to create the new `schema.yml` file for the bronze and silver subfolders.

## 2. Define User Permissions And Use Views Where Needed

Inside your `dbt_project.yml` grants folder-specific access to different roles: #TODO: fix the grant permission as it is not working

```yaml
---
models:
  dbt_workshop:
    bronze:
      +materialized: table
      +grants:
        select:
          - data_engineer_role
    silver:
      +materialized: table
      +grants:
        select:
          - data_analyst_role
    gold:
      +materialized: view # Materialized as views
      +grants:
        select:
          - data_scientist_role
```

Using `grants` allows specific users to query information across all model layers, while preventing unauthorized users to access them. Using `materialized: view` attribute for the gold layer, enables to create views that are lightweight, quick to build, and ideal for sharing without blowing up compute budgets. 💨

## 4. Build Models in Order

To ensure the models are built in the correct order, you can run them using the following `dbt run` command with the following flag:

```bash
dbt run --select bronze_citizens bronze_items bronze_quests silver_citizens silver_items silver_quests gold_winners
```

This command will build your models in the correct sequence: starting from the bronze layer, moving through the silver transformations, and ending with the gold final results. ✨
