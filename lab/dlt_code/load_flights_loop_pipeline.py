# Note that this code is not refactored

import os
import requests
import pandas as pd
from datetime import datetime, timedelta
from dotenv import load_dotenv
import dlt
from pathlib import Path

load_dotenv()

API_KEY = os.getenv("API_KEY")

airports = ["ARN", "BMA", "GOT", "MMX", "LLA", "UME", "OSD", "VBY", "RNB", "KRN"]
BASE_URL = "https://api.swedavia.se/flightinfo/v2"

headers = {
    "Ocp-Apim-Subscription-Key": API_KEY,
    "Accept": "application/json"
}

today = datetime.today()
dates = [(today - timedelta(days=i)).strftime("%Y-%m-%d") for i in range(3)]

@dlt.resource(write_disposition="append")
def fetch_flight_data(flight_type, airport, date):
    
    url = f"{BASE_URL}/{airport}/{flight_type}/{date}"

    response = requests.get(url, headers=headers)
    response.raise_for_status()
    data = response.json()

    flights = data.get("flights", [])
    if flights:
        df_day = pd.json_normalize(flights)
        df_day["airportIATA"] = airport
        df_day["queryDate"] = date

    yield df_day

def run_pipeline(flight_type, table_name):
    pipeline = dlt.pipeline(
        pipeline_name="flights",
        destination="snowflake",
        dataset_name="staging",
    )

    for airport in airports:
        for date in dates:
            load_info = pipeline.run(fetch_flight_data(flight_type, airport, date), table_name=table_name)
            print(load_info)

if __name__ == "__main__":
    working_directory = Path(__file__).parent
    os.chdir(working_directory)

    flight_type = "departures"
    table_name = "flights_departures_v2"

    run_pipeline(flight_type, table_name)
