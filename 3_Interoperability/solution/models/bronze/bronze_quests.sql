SELECT
    quest_id,
    citizen_id,
    quest_name,
    reward,
    status,
    TO_CHAR(TO_DATE(completion_date, 'DD/MM/YYYY'), 'YYYY-MM-DD')       AS 'completion_date'

FROM {{ source('raw', 'raw_quests') }}
