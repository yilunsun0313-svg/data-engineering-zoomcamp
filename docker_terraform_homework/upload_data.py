import pandas as pd
import pyarrow
from sqlalchemy import create_engine
import psycopg2
import click # this is used to parse command line arguments

df = pd.read_parquet("https://d37ci6vzurychx.cloudfront.net/trip-data/green_tripdata_2025-11.parquet")
zones = pd.read_csv('https://github.com/DataTalksClub/nyc-tlc-data/releases/download/misc/taxi_zone_lookup.csv')

# connect to the postgres database using sqlalchemy
# Click options are passed as function arguments only 
@click.command()
@click.option("--username", default="root", help="Postgres username")
@click.option("--password", default="root", help="Postgres password")
@click.option("--host", default="localhost", help="Postgres host")
@click.option("--port", default=5432, help="Postgres port")
@click.option("--db", default="homework", help="Postgres database name")

def upload(username, password, host, port, db):
    DATABASE_URL = f'postgresql://{username}:{password}@{host}:{port}/{db}'
    engine = create_engine(DATABASE_URL)

    df.to_sql(
        "green_tripdata",
        con = engine,
        if_exists = "replace"
    )

    zones.to_sql(
        "zones",
        con = engine,
        if_exists="replace"
    )

if __name__ == "__main__":
    upload()