select
    cq.citizen_id,
    cq.first_name,
    cq.last_name,
    cq.date_of_birth,
    cq.height_centimeters,
    cq.total_quests,
    mw.most_used_item,
    mw.most_used_item_length_centimeters

from dbt_mtonelli.silver_citizens cq -- remember to change to your schema
left join dbt_mtonelli.silver_quests mw -- remember to change to your schema
    on cq.citizen_id = mw.citizen_id
order by cq.total_quests desc