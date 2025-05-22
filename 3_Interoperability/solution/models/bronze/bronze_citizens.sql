SELECT
    citizen_id,
    first_name,
    last_name,
    race,
    TO_CHAR(TO_DATE(date_of_birth, 'dd/MM/yyyy'), 'yyyy-MM-dd')         AS date_of_birth,
    ROUND(height_centimeters * 30.48)                                   AS height_centimeters

FROM {{ source('raw', 'citizens') }}
