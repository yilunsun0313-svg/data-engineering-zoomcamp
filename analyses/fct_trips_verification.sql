select 
vendorid,
ratecodeid,
pickup_locationid,
dropoff_locationid
from {{ ref('int_trips_unioned') }}
group by 1,2,3,4
having count(*) > 1


