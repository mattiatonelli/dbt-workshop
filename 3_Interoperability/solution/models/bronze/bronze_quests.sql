SELECT
    quest_id,
    citizen_id,
    quest_name,
    reward,
    status,
    TO_CHAR(TO_DATE(completion_date, 'dd/MM/yyyy'), 'yyyy-MM-dd')       AS completion_date

FROM {{ source('raw', 'quests') }}
