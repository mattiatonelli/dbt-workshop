SELECT
    cq.citizen_id,
    cq.first_name,
    cq.last_name,
    cq.date_of_birth,
    cq.height_centimeters,
    cq.total_quests,
    mw.most_used_item,
    mw.most_used_item_length_centimeters

FROM dbt_mtonelli.silver_citizens AS cq -- remember to change to your schema

LEFT JOIN dbt_mtonelli.silver_quests AS mw -- remember to change to your schema
    ON cq.citizen_id = mw.citizen_id

ORDER BY 
    cq.total_quests DESC;
