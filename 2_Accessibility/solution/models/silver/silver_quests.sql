WITH citizen_items AS (
    SELECT
        c.citizen_id,
        i.item_name,
        i.length_centimeters,
        COUNT(i.item_name)                  AS 'item_count'

    FROM dbt_mtonelli.bronze_citizens AS c -- remember to change to your schema

    LEFT JOIN dbt_mtonelli.bronze_items AS i -- remember to change to your schema
        ON c.citizen_id = i.citizen_id

    GROUP BY 
        c.citizen_id, 
        i.item_name, 
        i.length_centimeters
),

most_used_item AS (
    SELECT
        citizen_id,
        item_name                           AS 'most_used_item',
        length_centimeters                  AS 'most_used_item_length_centimeters'
    FROM (
        SELECT
            citizen_id,
            item_name,
            length_centimeters,
            ROW_NUMBER() OVER (
                PARTITION BY citizen_id 
                ORDER BY COUNT(item_name) DESC
            ) AS rank

        FROM citizen_items
        
        GROUP BY 
            citizen_id, 
            item_name, 
            length_centimeters
    ) AS ranked
    WHERE rank = 1
)

SELECT * FROM most_used_item;
