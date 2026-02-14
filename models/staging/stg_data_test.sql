select *
from {{ source('raw_data', 'data_test') }}