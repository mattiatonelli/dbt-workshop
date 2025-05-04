with citizen_quests as (
    select
        c.citizen_id,
        c.first_name,
        c.last_name,
        c.date_of_birth,
        c.height_centimeters,
        count(q.quest_id) as total_quests
    from dbt_mtonelli.bronze_citizens c -- remember to change to your schema
    left join dbt_mtonelli.bronze_quests q -- remember to change to your schema
        on c.citizen_id = q.citizen_id
    group by c.citizen_id, c.first_name, c.last_name, c.date_of_birth, c.height_centimeters
)

select * from citizen_quests
