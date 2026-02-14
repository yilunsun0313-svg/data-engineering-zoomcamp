with fhv_tripdata as (
    select *
    from {{ source('raw_data', 'fhv_tripdata') }}
)

select count(*)
from fhv_tripdata
where dispatching_base_num is not null