-- Phase 8: PostgreSQL Schema for EV Charging Analytics
-- Database: ev_charging
-- Purpose: Relational analytical layer for demand, utilization, and infrastructure analysis

-- Drop tables if they exist (for schema recreation)
DROP TABLE IF EXISTS station_hourly_metrics CASCADE;
DROP TABLE IF EXISTS traffic CASCADE;
DROP TABLE IF EXISTS weather CASCADE;
DROP TABLE IF EXISTS charging_sessions CASCADE;
DROP TABLE IF EXISTS vehicles CASCADE;
DROP TABLE IF EXISTS stations CASCADE;
DROP TABLE IF EXISTS calendar CASCADE;

-- 1. Calendar dimension table
-- Grain: One row per date
CREATE TABLE calendar (
    date DATE PRIMARY KEY,
    year INTEGER NOT NULL,
    month INTEGER NOT NULL,
    quarter VARCHAR(2) NOT NULL,
    week INTEGER NOT NULL,
    day_of_week VARCHAR(20) NOT NULL,
    weekend_flag INTEGER NOT NULL,
    season VARCHAR(20) NOT NULL,
    holiday_flag INTEGER NOT NULL
);

-- 2. Stations dimension table
-- Grain: One row per station
CREATE TABLE stations (
    station_id VARCHAR(50) PRIMARY KEY,
    location_id VARCHAR(50),
    latitude NUMERIC(10, 8) NOT NULL,
    longitude NUMERIC(11, 8) NOT NULL,
    city VARCHAR(100),
    state VARCHAR(50),
    number_of_chargers INTEGER NOT NULL,
    max_station_power_kw NUMERIC(10, 2) NOT NULL,
    parking_spots INTEGER,
    charging_capacity_kw NUMERIC(10, 2),
    cost_usd_per_kwh NUMERIC(6, 3),
    station_operator VARCHAR(100),
    station_type VARCHAR(50),
    charger_type VARCHAR(50),
    installation_year INTEGER,
    station_age_years INTEGER,
    renewable_energy_source VARCHAR(50),
    availability VARCHAR(50),
    avg_users_per_day NUMERIC(10, 2),
    capacity_per_parking_spot_kw NUMERIC(10, 2)
);

-- 3. Vehicles dimension table
-- Grain: One row per vehicle
CREATE TABLE vehicles (
    vehicle_id VARCHAR(50) PRIMARY KEY,
    vehicle_type VARCHAR(50),
    battery_capacity_kwh NUMERIC(6, 2),
    vehicle_age_years INTEGER
);

-- 4. Charging sessions fact table
-- Grain: One row per charging session
CREATE TABLE charging_sessions (
    session_id VARCHAR(50) PRIMARY KEY,
    station_id VARCHAR(50) NOT NULL REFERENCES stations(station_id),
    vehicle_id VARCHAR(50) NOT NULL REFERENCES vehicles(vehicle_id),
    start_time TIMESTAMP NOT NULL,
    end_time TIMESTAMP NOT NULL,
    charging_duration_min INTEGER,
    energy_delivered_kwh NUMERIC(8, 3),
    average_power_kw NUMERIC(8, 2),
    charger_type VARCHAR(50),
    battery_capacity_kwh NUMERIC(6, 2),
    initial_soc_pct NUMERIC(5, 2),
    final_soc_pct NUMERIC(5, 2),
    wait_time_min INTEGER,
    queue_length INTEGER,
    session_status VARCHAR(50),
    revenue_usd NUMERIC(8, 2),
    peak_demand_flag INTEGER
);

-- 5. Weather context table
-- Grain: One row per location-hour
CREATE TABLE weather (
    location_id VARCHAR(50),
    date DATE,
    hour INTEGER,
    city VARCHAR(100),
    state VARCHAR(50),
    temperature_c NUMERIC(6, 2),
    humidity_pct NUMERIC(5, 2),
    rainfall_mm NUMERIC(8, 2),
    wind_speed_kmh NUMERIC(8, 2),
    weather_condition VARCHAR(100),
    PRIMARY KEY (location_id, date, hour),
    FOREIGN KEY (date) REFERENCES calendar(date)
);

-- 6. Traffic context table
-- Grain: One row per station-hour
CREATE TABLE traffic (
    station_id VARCHAR(50),
    date DATE,
    hour INTEGER,
    traffic_volume INTEGER,
    average_speed_kmh NUMERIC(8, 2),
    congestion_level VARCHAR(50),
    PRIMARY KEY (station_id, date, hour),
    FOREIGN KEY (station_id) REFERENCES stations(station_id),
    FOREIGN KEY (date) REFERENCES calendar(date)
);

-- 7. Station hourly metrics fact table
-- Grain: One row per station-hour
CREATE TABLE station_hourly_metrics (
    station_id VARCHAR(50),
    date DATE,
    hour INTEGER,
    sessions_count INTEGER,
    energy_delivered_kwh NUMERIC(12, 3),
    average_power_kw NUMERIC(10, 2),
    peak_power_kw NUMERIC(10, 2),
    avg_session_duration_min NUMERIC(8, 2),
    avg_wait_time_min NUMERIC(8, 2),
    max_queue_length INTEGER,
    number_of_chargers INTEGER,
    max_station_power_kw NUMERIC(10, 2),
    charger_hours_used NUMERIC(10, 2),
    utilization_rate NUMERIC(5, 4),
    capacity_utilization NUMERIC(5, 4),
    chargers_occupied INTEGER,
    available_chargers INTEGER,
    congestion_flag INTEGER,
    peak_demand_flag INTEGER,
    PRIMARY KEY (station_id, date, hour),
    FOREIGN KEY (station_id) REFERENCES stations(station_id),
    FOREIGN KEY (date) REFERENCES calendar(date)
);

-- Create indexes for common queries
CREATE INDEX idx_charging_sessions_station_id ON charging_sessions(station_id);
CREATE INDEX idx_charging_sessions_vehicle_id ON charging_sessions(vehicle_id);
CREATE INDEX idx_charging_sessions_start_time ON charging_sessions(start_time);
CREATE INDEX idx_station_hourly_metrics_station_id ON station_hourly_metrics(station_id);
CREATE INDEX idx_station_hourly_metrics_date ON station_hourly_metrics(date);
CREATE INDEX idx_traffic_station_id ON traffic(station_id);
CREATE INDEX idx_weather_location_id ON weather(location_id);
