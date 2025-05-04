select
    quest_id,
    citizen_id,
    quest_name,
    reward,
    status,
    completion_date
from dbt_mtonelli.raw_quests -- remember to change to your schema