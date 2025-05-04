select
    citizen_id,
    first_name,
    last_name,
    race,
    to_char(to_date(date_of_birth, 'DD/MM/YYYY'), 'YYYY-MM-DD') as date_of_birth,
    round(height_centimeters * 30.48) as height_centimeters
from {{ source('raw', 'raw_citizens') }}