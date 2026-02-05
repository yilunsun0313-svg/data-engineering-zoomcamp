# To create a dataset in my project 
CREATE SCHEMA IF NOT EXISTS `de-zoomcamp-dbt.ny_taxi`
OPTIONS(
  location = 'US',
  description = 'Dataset for taxi trip data homework'
);

# Create an external table using parquet files

CREATE OR REPLACE EXTERNAL TABLE `de-zoomcamp-dbt.ny_taxi.external_yellow_taxi_table`
OPTIONS (
  format = 'PARQUET',
  uris = ['gs://ny_taxi_bucket_123/yellow_tripdata_2024-*.parquet']
);

# Create a regular table using parquet files

LOAD DATA OVERWRITE `de-zoomcamp-dbt.ny_taxi.regular_yellow_taxi_table`
FROM FILES (
  format = 'PARQUET',
  uris = ['gs://ny_taxi_bucket_123/yellow_tripdata_2024-*.parquet']
);

# count of records 
select count(*)
from ny_taxi.regular_yellow_taxi_table;

# distinct number of PULocationIDs for the entire dataset on both the tables.
select count(distinct PULocationID)
from ny_taxi.external_yellow_taxi_table;

select count(distinct PULocationID)
from ny_taxi.regular_yellow_taxi_table;

# Write a query to retrieve the PULocationID from the table (not the external table) in BigQuery. Now write a query to retrieve the PULocationID and DOLocationID on the same table.

select PULocationID, DOLocationID
from ny_taxi.regular_yellow_taxi_table;

# How many records have a fare_amount of 0?

select count(*)
from  ny_taxi.regular_yellow_taxi_table
where fare_amount = 0;

# Write a query to retrieve the distinct VendorIDs between tpep_dropoff_datetime 2024-03-01 and 2024-03-15 (inclusive)

# Use the materialized table you created earlier in your from clause and note the estimated bytes. Now change the table in the from clause to the partitioned # table you created for question 5 and note the estimated bytes processed. What are these values?

select distinct VendorID
from ny_taxi.regular_yellow_taxi_table
where tpep_dropoff_datetime >= '2024-03-01'
and tpep_dropoff_datetime < '2024-03-16';

CREATE OR REPLACE TABLE `ny_taxi.partitioned_yellow_taxi_table`
PARTITION BY DATE(tpep_dropoff_datetime)
CLUSTER BY VendorID
AS
SELECT * FROM `ny_taxi.regular_yellow_taxi_table`;

select distinct VendorID
from ny_taxi.partitioned_yellow_taxi_table
where tpep_dropoff_datetime >= '2024-03-01'
and tpep_dropoff_datetime < '2024-03-16';

# Write a `SELECT count(*)` query FROM the materialized table you created. How many bytes does it estimate will be read? Why?

select count(*)
from ny_taxi.regular_yellow_taxi_table;
