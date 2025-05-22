SELECT
    citizen_id,
    first_name,
    last_name,
    race,
    {{ format_date('date_of_birth') }}          AS date_of_birth,  -- Using the macro for date formatting
    ROUND(height_centimeters * 30.48)           AS height_centimeters

FROM {{ source('raw', 'citizens') }}