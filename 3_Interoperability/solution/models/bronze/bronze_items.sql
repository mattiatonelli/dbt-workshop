SELECT
    item_id,
    citizen_id,
    item_name,
    item_type,
    rarity,
    ROUND(length_centimeters * 2.54)        AS 'length_centimeters'

FROM {{ source('raw', 'raw_items') }}
