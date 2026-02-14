with all_trips as (
    select *,
    md5(concat(vendorid, pickup_datetime, dropoff_datetime,
    pickup_locationid, trip_type, passenger_count, fare_amount, payment_type, mta_tax,
    tolls_amount, tip_amount)) as trip_id
    from {{ ref('int_trips_unioned') }}
),

dup_trip_ids as (
    select 
    trip_id
    from all_trips
    group by trip_id
    having count(*) > 1
)

select *
from all_trips
where trip_id in (select trip_id from dup_trip_ids)
order by trip_id



