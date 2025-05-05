WITH citizen_quests AS (
    SELECT
        c.citizen_id,
        c.first_name,
        c.last_name,
        c.date_of_birth,
        c.height_centimeters,
        COUNT(q.quest_id)                       AS 'total_quests'

    FROM dbt_mtonelli.bronze_citizens AS c -- remember to change to your schema
    
    LEFT JOIN dbt_mtonelli.bronze_quests AS q -- remember to change to your schema
        ON c.citizen_id = q.citizen_id
    
    GROUP BY 
        c.citizen_id, 
        c.first_name, 
        c.last_name, 
        c.date_of_birth, 
        c.height_centimeters
)

SELECT * FROM citizen_quests;
