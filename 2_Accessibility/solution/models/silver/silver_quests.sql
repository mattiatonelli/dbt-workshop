with citizen_items as (
    select
        c.citizen_id,
        i.item_name,
        i.length_centimeters,
        count(i.item_name) as item_count
    from dbt_mtonelli.bronze_citizens c -- remember to change to your schema
    left join dbt_mtonelli.bronze_items i -- remember to change to your schema
        on c.citizen_id = i.citizen_id
    group by c.citizen_id, i.item_name, i.length_centimeters
),

most_used_item as (
    select
        citizen_id,
        item_name as most_used_item,
        length_centimeters as most_used_item_length_centimeters
    from (
        select
            citizen_id,
            item_name,
            length_centimeters,
            row_number() over (
                partition by citizen_id 
                order by count(item_name) desc
            ) as rank
        from citizen_items
        group by citizen_id, item_name, length_centimeters
    ) ranked
    where rank = 1
)

select * from most_used_item
