SELECT
    citizen_id,
    first_name,
    last_name,
    race,
    TO_CHAR(TO_DATE(date_of_birth, 'DD/MM/YYYY'), 'YYYY-MM-DD')         AS 'date_of_birth',
    ROUND(height_centimeters * 30.48)                                   AS 'height_centimeters'

FROM {{ source('raw', 'raw_citizens') }};
