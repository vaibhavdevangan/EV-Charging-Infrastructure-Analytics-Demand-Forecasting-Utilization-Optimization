import psycopg2
from psycopg2.extensions import ISOLATION_LEVEL_AUTOCOMMIT
import os

DB_NAME = "ev_charging"
USER = "postgres"
HOST = "localhost"
RAW_DIR = r"c:\PYTHON p45\New_Project\data\raw"

# Connect to database
conn = psycopg2.connect(dbname="postgres", user=USER, host=HOST)
conn.set_isolation_level(ISOLATION_LEVEL_AUTOCOMMIT)
cur = conn.cursor()
try:
    cur.execute(f"DROP DATABASE {DB_NAME} WITH (FORCE);")
except:
    pass
cur.execute(f"CREATE DATABASE {DB_NAME};")
cur.close()
conn.close()

conn = psycopg2.connect(dbname=DB_NAME, user=USER, host=HOST)
cur = conn.cursor()

schema = """
CREATE TABLE stations (
    Station_ID VARCHAR(50) PRIMARY KEY,
    City VARCHAR(100),
    State VARCHAR(100),
    Latitude NUMERIC,
    Longitude NUMERIC,
    Station_Operator VARCHAR(100),
    Charger_Type VARCHAR(50),
    Charging_Capacity_kW NUMERIC,
    Number_of_Chargers INTEGER,
    Max_Station_Power_kW NUMERIC,
    Parking_Spots INTEGER,
    Cost_USD_per_kWh NUMERIC,
    Renewable_Energy_Source VARCHAR(50),
    Availability VARCHAR(100),
    Installation_Year INTEGER,
    Station_Age_Years INTEGER,
    Station_Type VARCHAR(100),
    Capacity_per_Parking_Spot_kW NUMERIC,
    Avg_Users_per_Day NUMERIC,
    Location_ID VARCHAR(50)
);

CREATE TABLE charging_sessions (
    Session_ID VARCHAR(100) PRIMARY KEY,
    Station_ID VARCHAR(50),
    Vehicle_ID VARCHAR(100),
    Start_Time TIMESTAMP,
    End_Time TIMESTAMP,
    Charging_Duration_Min NUMERIC,
    Energy_Delivered_kWh NUMERIC,
    Average_Power_kW NUMERIC,
    Charger_Type VARCHAR(50),
    Battery_Capacity_kWh NUMERIC,
    Initial_SOC_pct NUMERIC,
    Final_SOC_pct NUMERIC,
    Wait_Time_Min NUMERIC,
    Queue_Length INTEGER,
    Session_Status VARCHAR(50),
    Revenue_USD NUMERIC,
    Peak_Demand_Flag VARCHAR(50)
);

CREATE TABLE station_hourly_metrics (
    Station_ID VARCHAR(50),
    Date DATE,
    Hour INTEGER,
    Sessions_Count INTEGER,
    Energy_Delivered_kWh NUMERIC,
    Average_Power_kW NUMERIC,
    Peak_Power_kW NUMERIC,
    Avg_Session_Duration_Min NUMERIC,
    Avg_Wait_Time_Min NUMERIC,
    Max_Queue_Length INTEGER,
    Number_of_Chargers INTEGER,
    Max_Station_Power_kW NUMERIC,
    Charger_Hours_Used NUMERIC,
    Utilization_Rate NUMERIC,
    Capacity_Utilization NUMERIC,
    Chargers_Occupied INTEGER,
    Available_Chargers INTEGER,
    Congestion_Flag VARCHAR(50),
    Peak_Demand_Flag VARCHAR(50)
);
"""
cur.execute(schema)
conn.commit()

def load_csv(table, filename):
    path = os.path.join(RAW_DIR, filename)
    with open(path, 'r', encoding='utf-8') as f:
        cur.copy_expert(f"COPY {table} FROM STDIN WITH CSV HEADER", f)
        conn.commit()
    print(f"Loaded {filename} into {table}")

load_csv("stations", "stations.csv")
load_csv("charging_sessions", "charging_sessions.csv")
load_csv("station_hourly_metrics", "station_hourly_metrics.csv")

views = """
CREATE OR REPLACE VIEW vw_station_performance AS
SELECT 
    s.Station_ID,
    s.Station_Type,
    s.Number_of_Chargers,
    s.Max_Station_Power_kW,
    COUNT(cs.Session_ID) as Total_Sessions,
    SUM(cs.Energy_Delivered_kWh) as Total_Energy_kWh,
    SUM(cs.Revenue_USD) as Total_Revenue_USD,
    AVG(cs.Wait_Time_Min) as Avg_Wait_Time,
    AVG(cs.Charging_Duration_Min) as Avg_Duration
FROM stations s
LEFT JOIN charging_sessions cs ON s.Station_ID = cs.Station_ID
GROUP BY 1,2,3,4;

CREATE OR REPLACE VIEW vw_station_congestion AS
SELECT 
    Station_ID,
    AVG(Utilization_Rate) as Avg_Utilization,
    AVG(CASE WHEN Congestion_Flag = 'True' THEN 1 ELSE 0 END) as Congestion_Frequency,
    MAX(Max_Queue_Length) as Peak_Queue
FROM station_hourly_metrics
GROUP BY Station_ID;

CREATE OR REPLACE VIEW vw_geographic_summary AS
SELECT 
    City,
    State,
    COUNT(Station_ID) as Total_Stations,
    SUM(Number_of_Chargers) as Total_Chargers,
    SUM(Max_Station_Power_kW) as Total_Capacity_kW
FROM stations
GROUP BY City, State;
"""
cur.execute(views)
conn.commit()

cur.close()
conn.close()
print("Success")
