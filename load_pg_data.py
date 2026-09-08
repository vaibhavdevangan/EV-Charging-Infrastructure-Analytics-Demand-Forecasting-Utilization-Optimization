#!/usr/bin/env python
"""
Load EV Charging data into PostgreSQL database
Phase 8: SQL Analytical Layer
"""

import pandas as pd
from sqlalchemy import create_engine, text
import sys

def main():
    # Connection
    engine = create_engine('postgresql://postgres:postgres@localhost:5432/ev_charging')
    
    # Temporarily disable foreign keys
    with engine.connect() as conn:
        conn.execute(text("SET CONSTRAINTS ALL DEFERRED"))
        conn.commit()
    
    # Load calendar first 
    print('Loading calendar.csv...')
    df_calendar = pd.read_csv('data/raw/calendar.csv')
    df_calendar['Date'] = pd.to_datetime(df_calendar['Date']).dt.date
    df_calendar = df_calendar.rename(columns={
        'Date': 'date',
        'Year': 'year',
        'Month': 'month',
        'Quarter': 'quarter',
        'Week': 'week',
        'Day_of_Week': 'day_of_week',
        'Weekend_Flag': 'weekend_flag',
        'Season': 'season',
        'Holiday_Flag': 'holiday_flag'
    })
    df_calendar = df_calendar[['date', 'year', 'month', 'quarter', 'week', 'day_of_week', 'weekend_flag', 'season', 'holiday_flag']]
    df_calendar.to_sql('calendar', engine, if_exists='append', index=False)
    print(f'  OK Loaded {len(df_calendar):,} rows')
    
    # Load stations with explicit column order
    print('Loading stations.csv...')
    df_stations = pd.read_csv('data/raw/stations.csv')
    df_stations.columns = df_stations.columns.str.lower().str.replace(' ', '_').str.replace('-', '_')
    cols_order = ['station_id', 'location_id', 'latitude', 'longitude', 'city', 'state', 
                  'number_of_chargers', 'max_station_power_kw', 'parking_spots', 'charging_capacity_kw',
                  'cost_usd_per_kwh', 'station_operator', 'station_type', 'charger_type',
                  'installation_year', 'station_age_years', 'renewable_energy_source', 'availability',
                  'avg_users_per_day', 'capacity_per_parking_spot_kw']
    df_stations = df_stations[cols_order]
    df_stations.to_sql('stations', engine, if_exists='append', index=False)
    print(f'  OK Loaded {len(df_stations):,} rows')
    
    # Load vehicles
    print('Loading vehicles.csv...')
    df_vehicles = pd.read_csv('data/raw/vehicles.csv')
    df_vehicles.columns = df_vehicles.columns.str.lower().str.replace(' ', '_')
    df_vehicles.to_sql('vehicles', engine, if_exists='append', index=False)
    print(f'  OK Loaded {len(df_vehicles):,} rows')
    
    # Load weather
    print('Loading weather.csv...')
    df_weather = pd.read_csv('data/raw/weather.csv')
    df_weather.columns = df_weather.columns.str.lower().str.replace(' ', '_')
    df_weather['date'] = pd.to_datetime(df_weather['date']).dt.date
    df_weather.to_sql('weather', engine, if_exists='append', index=False)
    print(f'  OK Loaded {len(df_weather):,} rows')
    
    # Load traffic
    print('Loading traffic.csv...')
    df_traffic = pd.read_csv('data/raw/traffic.csv')
    df_traffic.columns = df_traffic.columns.str.lower().str.replace(' ', '_')
    df_traffic['date'] = pd.to_datetime(df_traffic['date']).dt.date
    df_traffic.to_sql('traffic', engine, if_exists='append', index=False)
    print(f'  OK Loaded {len(df_traffic):,} rows')
    
    # Load station_hourly_metrics
    print('Loading station_hourly_metrics.csv...')
    df_shm = pd.read_csv('data/raw/station_hourly_metrics.csv')
    df_shm.columns = df_shm.columns.str.lower().str.replace(' ', '_')
    df_shm['date'] = pd.to_datetime(df_shm['date']).dt.date
    df_shm.to_sql('station_hourly_metrics', engine, if_exists='append', index=False)
    print(f'  OK Loaded {len(df_shm):,} rows')
    
    # Load charging_sessions (largest file)
    print('Loading charging_sessions.csv (this may take a moment)...')
    df_sessions = pd.read_csv('data/raw/charging_sessions.csv', low_memory=False)
    df_sessions.columns = df_sessions.columns.str.lower().str.replace(' ', '_')
    df_sessions['start_time'] = pd.to_datetime(df_sessions['start_time'])
    df_sessions['end_time'] = pd.to_datetime(df_sessions['end_time'])
    df_sessions.to_sql('charging_sessions', engine, if_exists='append', index=False, chunksize=5000)
    print(f'  OK Loaded {len(df_sessions):,} rows')
    
    print('\nOK ALL DATA LOADED SUCCESSFULLY!')

if __name__ == '__main__':
    main()
