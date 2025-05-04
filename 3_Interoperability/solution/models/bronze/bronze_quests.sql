select
    quest_id,
    citizen_id,
    quest_name,
    reward,
    status,
    to_char(to_date(completion_date, 'DD/MM/YYYY'), 'YYYY-MM-DD') as completion_date
from {{ source('raw', 'raw_quests') }}