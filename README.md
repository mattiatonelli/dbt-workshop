# 🏰 The Mystery of the Missing Analyst in the FAIR Kingdom! 🧙‍♂️

Once upon a time in the **FAIR Kingdom**, we had a brilliant data analyst by the name of **Percival the Query Whisperer**. He could summon the most complex SQL spells and weave data into elegant answers faster than you could say **"SELECT \* FROM"**. 🧑‍💻✨

For weeks, Percival had been working diligently on our latest quest: finding the **top 3 citizens by number of quests completed**. As a reward, the **top citizens** were to be **awarded a special prize**: a **Golden Dragon Coin** 🪙 (only given to those truly worthy). It was going to be the **honor of a lifetime** for the three adventurers who topped the leaderboard. 🎖️

And then... **Percival went missing**. 😱 One day, he was sitting at his desk, typing away at his computer with a mug of hot cocoa, muttering something about “optimizing queries” and “removing unnecessary joins.” The next day, his desk was empty. No mug, no computer—just a single **document** named the **Holy Grail of Data Management: FAIR** 🌲.

Rumor has it that Percival was last seen **entering a tavern called "The Unoptimized Query"**, and since then, no one’s heard from him. 🕵️‍♂️

Now, here we are, holding the **query he left behind**. Yes, it gives us the **top 3 citizens** along with their **height** and **most used weapon**. **But...** we’re **not entirely sure** it’s correct. 🧐 The numbers look good, but something’s missing — maybe it's the magic of optimization? Or perhaps it’s a little too... **messy**?

The kingdom is eager to give out the **Golden Dragon Coins** to the top 3 adventurers, but we **dare not proceed** until we’re certain the data is **FAIR**.

That’s where you come in! 🚀

It’s time to **dust off the old queries**, use the **FAIR principles** (the secret document Percival left behind), and **enhance** this query to make sure the results are **findable, accessible, interoperable**, and **reusable** for future users! 🧙‍♀️

Are you ready to venture through the **mystical land of data management** and become the hero who **rescues the query** and ensures the **Golden Dragon Coins** are truly earned? 🏆

Now we can begin our quest to make the query **FAIR** for the kingdom. The first task awaits! ✨

```sql
WITH citizen_quests AS (

    SELECT
        c.citizen_id,
        c.first_name,
        c.last_name,
        c.date_of_birth,
        c.height_centimeters,
        COUNT(q.quest_id)               AS 'total_quests'

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
        item_name                       AS 'most_used_item',
        length_centimeters              AS 'most_used_item_length_cm'

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

SELECT * FROM citizens_winners;
```
