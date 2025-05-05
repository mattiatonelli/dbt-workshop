# 🏰 The Mystery of the Missing Analyst in the FAIR Kingdom! 🧙‍♂️

Once upon a time in the **FAIR Kingdom**, there lived a legendary analyst named **Percival the Query Whisperer**. With a single line of SQL, he could tame wild datasets, unlock ancient joins, and summon insights from the deepest data lakes. 🧑‍💻✨

Percival had been working on his greatest masterpiece yet: a query to uncover the **top 3 citizens by number of quests completed**—so they could be honored with the sacred **Golden Dragon Coin** 🪙, the kingdom’s highest prize for valor and data excellence. 🎖️

But just as the final touches were being added… **Percival vanished.** 😱

One moment, he was sipping cocoa and muttering about “window functions” and “removing unnecessary CTEs.” The next, his desk sat empty. No mug. No laptop. Just a single parchment left behind:
**“The Holy Grail of Data Management: FAIR.”** 📜

The only clue? A witness saw him heading into a tavern suspiciously named **“The Unoptimized Query.”** He never came out. 🕵️‍♂️

Now, the query he left behind still runs... sort of. It gives the top 3 heroes, their **height**, and **most used weapon**. But it’s a bit... **wonky**. 😬
Some say it lacks **standardization**. Others claim the **documentation is missing**. There are whispers of **stale data** and **copy-pasted code**...

The **Golden Dragon Coins** cannot be handed out until we make this query truly **FAIR**:
**Findable**, **Accessible**, **Interoperable**, and **Reusable**. ✨

That’s where **you** come in!

Armed with the sacred principles of FAIR and your legendary dbt skills, you must **enhance Percival’s query**, modernize his logic, and leave behind a cleaner, better data world. 🌍

Will you complete all four quests, uncover the **truth behind Percival’s disappearance**, and restore balance to the data kingdom?

The first task awaits... 🏁

```sql
WITH citizen_quests AS (

    SELECT
        c.citizen_id,
        c.first_name,
        c.last_name,
        c.date_of_birth,
        c.height_centimeters,
        COUNT(q.quest_id)               AS total_quests

    FROM dbtworkshop.dbt_mtonelli.raw_citizens AS c

    LEFT JOIN
        dbtworkshop.dbt_mtonelli.raw_quests AS q ON
            c.citizen_id = q.citizen_id

    GROUP BY
        c.citizen_id,
        c.first_name,
        c.last_name,
        c.date_of_birth,
        c.height_centimeters
),

citizen_items AS (

    SELECT
        c.citizen_id,
        i.item_name,
        i.length_centimeters,
        COUNT(i.item_name) AS item_count

    FROM dbtworkshop.dbt_mtonelli.raw_citizens AS c

    LEFT JOIN dbtworkshop.dbt_mtonelli.raw_items AS i ON
        c.citizen_id = i.citizen_id

    GROUP BY
        c.citizen_id,
        i.item_name,
        i.length_centimeters
),

most_used_item AS (
    SELECT
        citizen_id,
        item_name                       AS most_used_item,
        length_centimeters              AS most_used_item_length_cm

    FROM (
        SELECT
            citizen_id,
            item_name,
            length_centimeters,
            ROW_NUMBER() OVER (PARTITION BY citizen_id ORDER BY COUNT(item_name) DESC) AS rank

        FROM citizen_items

        GROUP BY
            citizen_id,
            item_name,
            length_centimeters
    ) AS ranked
    WHERE rank = 1
),

citizens_winners AS (
    SELECT
        cq.citizen_id,
        cq.first_name,
        cq.last_name,
        cq.date_of_birth,
        cq.height_centimeters,
        cq.total_quests,
        mw.most_used_item,
        mw.most_used_item_length_cm

    FROM citizen_quests AS cq

    LEFT JOIN most_used_item AS mw
        ON cq.citizen_id = mw.citizen_id

    ORDER BY
        cq.total_quests DESC
)

SELECT * FROM citizens_winners
```
