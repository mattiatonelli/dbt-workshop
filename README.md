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
with citizen_quests as (

    select
        c.citizen_id,
        c.first_name,
        c.last_name,
        c.date_of_birth,
        c.height_feet,
        count(q.quest_id) as total_quests

    from dbtworkshop.dbt_mtonelli.raw_citizens c

    left join
        dbtworkshop.dbt_mtonelli.raw_quests q on
            c.citizen_id = q.citizen_id

    group by
        c.citizen_id, c.first_name, c.last_name, c.date_of_birth, c.height_feet
),

citizen_items as (

    select
        c.citizen_id,
        i.item_name,
        i.length_inches,
        count(i.item_name) as item_count

    from dbtworkshop.dbt_mtonelli.raw_citizens c

    left join dbtworkshop.dbt_mtonelli.raw_items i on
        c.citizen_id = i.citizen_id

    group by
        c.citizen_id, i.item_name, i.length_inches
),

most_used_item as (
    select
        citizen_id,
        item_name as most_used_item,
        length_inches as most_used_item_length
    from (
        select
            citizen_id,
            item_name,
            length_inches,
            row_number() over (partition by citizen_id order by count(item_name) desc) as rank
        from citizen_items
        group by
            citizen_id, item_name, length_inches
    ) ranked
    where rank = 1
),

top_citizens as (
    select
        cq.citizen_id,
        cq.first_name,
        cq.last_name,
        cq.date_of_birth,
        cq.height_feet AS height_cm,
        cq.total_quests,
        mw.most_used_item,
        mw.most_used_item_length AS most_used_item_length_cm

    from citizen_quests cq

    left join most_used_item mw
        on cq.citizen_id = mw.citizen_id

    order by
        cq.total_quests desc
)

select * from (
    select * from top_citizens limit 3
) as final_query
```
