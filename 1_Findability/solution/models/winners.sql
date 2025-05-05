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

SELECT * FROM citizens_winners