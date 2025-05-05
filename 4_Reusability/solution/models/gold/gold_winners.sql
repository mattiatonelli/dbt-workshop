SELECT
    cq.citizen_id,
    cq.first_name,
    cq.last_name,
    cq.date_of_birth,
    cq.height_centimeters,
    cq.total_quests,
    mw.most_used_item,
    mw.most_used_item_length_centimeters

FROM {{ ref('silver_citizens') }} AS cq -- Using ref() for the silver_citizens model

LEFT JOIN {{ ref('silver_quests') }} AS mw -- Using ref() for the silver_quests model
    ON cq.citizen_id = mw.citizen_id

ORDER BY 
    cq.total_quests DESC
