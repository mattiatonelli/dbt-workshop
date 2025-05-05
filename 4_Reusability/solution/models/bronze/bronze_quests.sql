SELECT
    quest_id,
    citizen_id,
    quest_name,
    reward,
    status,
    {{ format_date('completion_date') }}    AS completion_date  -- Using the macro for date formatting

FROM {{ source('raw', 'raw_quests') }}
