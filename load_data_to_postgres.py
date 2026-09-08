"""
Data loading script for EV Charging PostgreSQL database
Loads all raw CSV files into corresponding PostgreSQL tables
"""

import pandas as pd
import psycopg
from psycopg import sql
from pathlib import Path
import os

# Database connection parameters
DB_HOST = "localhost"
DB_PORT = 5432
DB_NAME = "ev_charging"
DB_USER = "postgres"
DB_PASSWORD = os.getenv("PGPASSWORD", "postgres")  # Use environment variable if available

# Raw data directory
RAW_DATA_DIR = Path(r"c:\PYTHON p45\EV-Charging-Infrastructure-Analytics-Demand-Forecasting-Utilization-Optimization\Project_files\data\raw")

# Mapping of CSV files to table names and their columns
DATA_MAPPING = {
    "calendar.csv": {
        "table": "calendar",
        "columns": ["date", "year", "month", "quarter", "week", "day_of_week", "weekend_flag", "season", "holiday_flag"],
        "dtype": {"year": "int64", "month": "int64", "quarter": "int64", "week": "int64", "day_of_week": "int64", "weekend_flag": "int64", "holiday_flag": "int64"}
    },
    "stations.csv": {
        "table": "stations",
        "columns": None,  # Auto-detect
    },
    "vehicles.csv": {
        "table": "vehicles",
        "columns": None,
    },
    "weather.csv": {
        "table": "weather",
        "columns": None,
    },
    "traffic.csv": {
        "table": "traffic",
        "columns": None,
    },
    "station_hourly_metrics.csv": {
        "table": "station_hourly_metrics",
        "columns": None,
    },
    "charging_sessions.csv": {
        "table": "charging_sessions",
        "columns": None,
    },
}

def load_data():
    """Load all CSV files into PostgreSQL"""
    
    try:
        # Connect to database
        with psycopg.connect(
            dbname=DB_NAME,
            user=DB_USER,
            password=DB_PASSWORD,
            host=DB_HOST,
            port=DB_PORT
        ) as conn:
            with conn.cursor() as cur:
                
                for csv_file, config in DATA_MAPPING.items():
                    filepath = RAW_DATA_DIR / csv_file
                    table_name = config["table"]
                    
                    if not filepath.exists():
                        print(f"⚠️  WARNING: {csv_file} not found at {filepath}")
                        continue
                    
                    print(f"\n📂 Loading {csv_file} → {table_name}...")
                    
                    # Read CSV
                    df = pd.read_csv(filepath)
                    
                    # Handle calendar date column
                    if csv_file == "calendar.csv":
                        df['date'] = pd.to_datetime(df['date']).dt.date
                    
                    # Handle timestamp columns for charging_sessions and station_hourly_metrics
                    if csv_file == "charging_sessions.csv":
                        df['start_time'] = pd.to_datetime(df['Start_Time'])
                        df['end_time'] = pd.to_datetime(df['End_Time'])
                    
                    if csv_file == "station_hourly_metrics.csv":
                        df['date'] = pd.to_datetime(df['Date']).dt.date
                    
                    if csv_file == "weather.csv":
                        df['date'] = pd.to_datetime(df['Date']).dt.date
                    
                    if csv_file == "traffic.csv":
                        df['date'] = pd.to_datetime(df['Date']).dt.date
                    
                    # Normalize column names to lowercase with underscores
                    df.columns = df.columns.str.lower().str.replace(' ', '_').str.replace('-', '_')
                    
                    print(f"   Rows to insert: {len(df):,}")
                    print(f"   Columns: {len(df.columns)}")
                    
                    # Insert data
                    for idx, row in df.iterrows():
                        # Build INSERT statement
                        cols = ", ".join(row.index)
                        placeholders = ", ".join(["%s"] * len(row))
                        
                        insert_sql = f"INSERT INTO {table_name} ({cols}) VALUES ({placeholders})"
                        
                        # Replace NaN with None for NULL insertion
                        values = [None if pd.isna(v) else v for v in row.values]
                        
                        try:
                            cur.execute(insert_sql, values)
                        except Exception as e:
                            if idx < 5:  # Show first few errors
                                print(f"   Row {idx} error: {e}")
                        
                        # Commit every 1000 rows to avoid memory issues
                        if (idx + 1) % 1000 == 0:
                            conn.commit()
                            print(f"   Inserted {idx + 1:,} rows...")
                    
                    # Final commit
                    conn.commit()
                    
                    # Verify count
                    cur.execute(f"SELECT COUNT(*) FROM {table_name}")
                    count = cur.fetchone()[0]
                    print(f"   ✅ Total rows in {table_name}: {count:,}")
        
        print("\n✅ Data loading complete!")
        
    except Exception as e:
        print(f"❌ Error: {e}")
        raise

if __name__ == "__main__":
    load_data()
