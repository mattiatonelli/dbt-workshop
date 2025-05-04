select
    item_id,
    citizen_id,
    item_name,
    item_type,
    rarity,
    round(length_centimeters * 2.54) as length_centimeters
from {{ source('raw', 'raw_items') }}