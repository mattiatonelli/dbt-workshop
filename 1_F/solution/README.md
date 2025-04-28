# 🏆 **The Heroic Solution**

Here’s how you can solve the **Findable** part of our quest:

1. **Create the `schema.yml` file** for the `top_citizens` model:

```yaml
version: 2

models:
  - name: raw_citizens
    description: "This table contains the raw data for all citizens in the kingdom, including their ID, name, and height in centimeters."
    columns:
      - name: citizen_id
        description: "The unique identifier for each citizen."
      - name: first_name
        description: "The first name of the citizen."
      - name: last_name
        description: "The last name of the citizen."
      - name: height_cm
        description: "The height of the citizen in centimeters."
    tags:
      - "citizens"

  - name: raw_quests
    description: "This table contains the raw data for all quests completed by citizens, including quest name, type, and date completed."
    columns:
      - name: quest_id
        description: "The unique identifier for each quest."
      - name: citizen_id
        description: "The ID of the citizen who completed the quest."
      - name: quest_name
        description: "The name of the quest."
      - name: quest_type
        description: "The type or category of the quest."
      - name: completed_at
        description: "The date and time when the quest was completed."
    tags:
      - "quests"

  - name: raw_items
    description: "This table contains the raw data for all items used by citizens during quests, including weapon IDs, types, and lengths in inches."
    columns:
      - name: item_id
        description: "The unique identifier for each item (weapon)."
      - name: citizen_id
        description: "The ID of the citizen who used the item."
      - name: item_name
        description: "The name of the weapon or item."
      - name: item_type
        description: "The type of item, such as weapon, armor, etc."
      - name: length_inches
        description: "The length of the item in inches (only for weapons)."
    tags:
      - "items"

  - name: top_citizens
    description: "This model retrieves the top 3 citizens by number of quests completed, along with their height and the most used weapon."
    columns:
      - name: citizen_id
        description: "The unique identifier for each citizen."
      - name: first_name
        description: "The first name of the citizen."
      - name: last_name
        description: "The last name of the citizen."
      - name: height
        description: "The height of the citizen in centimeters."
      - name: total_quests
        description: "The total number of quests the citizen has completed."
      - name: most_used_weapon
        description: "The weapon that the citizen used most frequently in their quests."
      - name: most_used_weapon_length
        description: "The length of the most used weapon in inches."
    tags:
      - "prize"
      - "top_three"
```

2. Run dbt Docs to Generate Documentation

In the command line, run:

```bash
dbt docs generate
dbt docs serve
```

This will spin up a local web server where you can view the documentation for your project. It will allow you to see your models, columns, and their descriptions. 📜

3. Check Your Work

- Open the generated documentation in your browser (usually at [http://localhost:8000](http://localhost:8000)).
- Navigate to the `top_citizens` model and check that the model description and column descriptions are visible.
- Ensure that the tags like "citizens" and "quests" are present.

4. Test the Findability

Try to search for the model and its columns in the documentation interface. Can you easily find the `top_citizens` model? If so, the kingdom is now ready to discover and reuse it! 🔍
