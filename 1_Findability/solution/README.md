# 🏆 **The Heroic Solution**

Here’s how you can solve the **Findable** part of our quest:

## 1. Include the Metadata File

Create the `schema.yml` file for the `gold_winners.sql` model in the `models` folder:

```yaml
version: 2

models:
  - name: gold_winners
    description: "This model retrieves the top 3 citizens by number of quests completed, along with their height and the most used weapon."
    config:
      tags: ["prize", "FAIR"]
    columns:
      - name: citizen_id
        description: "The unique identifier for each citizen."
      - name: first_name
        description: "The first name of the citizen."
      - name: last_name
        description: "The last name of the citizen."
      - name: date_of_birth
        description: "The date of birth of the citizen in ISO format."
      - name: height_cm
        description: "The height of the citizen in centimeters."
      - name: total_quests
        description: "The total number of quests the citizen has completed."
      - name: most_used_item
        description: "The item that the citizen used most frequently in their quests."
      - name: most_used_item_length_cm
        description: "The length of the most used weapon in centimeters."
```

## 2. Replace the Original Project File

Remove the original and then copy the GitHub version of the file `dbt_project.yml`.

```yaml
# Name your project! Project names should contain only lowercase characters
# and underscores. A good package name should reflect your organization's
# name or the intended use of these models
name: "dbt_workshop"
version: "1.0.0"
config-version: 2

# This setting configures which "profile" dbt uses for this project.
profile: "default"

# These configurations specify where dbt should look for different types of files.
# The `model-paths` config, for example, states that models in this project can be
# found in the "models/" directory. You probably won't need to change these!
model-paths: ["models"]
analysis-paths: ["analyses"]
test-paths: ["tests"]
seed-paths: ["seeds"]
macro-paths: ["macros"]
snapshot-paths: ["snapshots"]

target-path: "target" # directory which will store compiled SQL files
clean-targets: # directories to be removed by `dbt clean`
  - "target"
  - "dbt_packages"

# Configuring models
# Full documentation: https://docs.getdbt.com/docs/configuring-models

# In dbt, the default materialization for a model is a view. This means, when you run
# dbt run or dbt build, all of your models will be built as a view in your data platform.
# The configuration below will override this setting for models in the example folder to
# instead be materialized as tables. Any models you add to the root of the models folder will
# continue to be built as views. These settings can be overridden in the individual model files
# using the `{{ config(...) }}` macro.

models:
  dbt_workshop:
    +materialized: table
```

## 3. Run dbt Docs to Generate Documentation

In the command line, run:

```bash
dbt docs generate
```

And then click on the document button as shown below:

![Visual Guide](./doc_button.png)

This will spin up a local web server where you can view the documentation for your project. It will allow you to see your models, tags, columns, and their descriptions. 📜

## 4. Test the Findability

Try to search for the model and its columns by using the search bar. Can you easily find the `winners` model? If so, the kingdom is now ready to easily discover it! 🔍
