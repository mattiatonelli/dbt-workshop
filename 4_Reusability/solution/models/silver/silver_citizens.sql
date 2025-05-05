WITH citizen_quests AS (
    SELECT
        c.citizen_id,
        c.first_name,
        c.last_name,
        c.date_of_birth,
        c.height_centimeters,
        COUNT(q.quest_id)                       AS total_quests

    FROM {{ ref('bronze_citizens') }} AS c -- Using ref() for bronze_citizens model
    
    LEFT JOIN {{ ref('bronze_quests') }} AS q -- Using ref() for bronze_quests model
        ON c.citizen_id = q.citizen_id
    
    GROUP BY 
        c.citizen_id, 
        c.first_name, 
        c.last_name, 
        c.date_of_birth, 
        c.height_centimeters
)

SELECT * FROM citizen_quests
