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