-- Phase 8 repair: preserve raw energy precision and enforce relational integrity.
-- Run with psql because \copy reads the existing local raw CSV files.
\set ON_ERROR_STOP on

CREATE TEMP TABLE staging_charging_sessions (LIKE charging_sessions INCLUDING DEFAULTS);
CREATE TEMP TABLE staging_station_hourly_metrics (LIKE station_hourly_metrics INCLUDING DEFAULTS);

ALTER TABLE staging_charging_sessions
    ALTER COLUMN energy_delivered_kwh TYPE NUMERIC(8, 3);

ALTER TABLE staging_station_hourly_metrics
    ALTER COLUMN energy_delivered_kwh TYPE NUMERIC(12, 3);

\copy staging_charging_sessions FROM 'C:/PYTHON p45/EV-Charging-Infrastructure-Analytics-Demand-Forecasting-Utilization-Optimization/Project_files/data/raw/charging_sessions.csv' WITH (FORMAT csv, HEADER true)
\copy staging_station_hourly_metrics FROM 'C:/PYTHON p45/EV-Charging-Infrastructure-Analytics-Demand-Forecasting-Utilization-Optimization/Project_files/data/raw/station_hourly_metrics.csv' WITH (FORMAT csv, HEADER true)

BEGIN;

DROP VIEW IF EXISTS vw_geographic_summary;
DROP VIEW IF EXISTS vw_station_infrastructure_efficiency;
DROP VIEW IF EXISTS vw_station_congestion;
DROP VIEW IF EXISTS vw_station_utilization;
DROP VIEW IF EXISTS vw_station_performance;

ALTER TABLE charging_sessions
    ALTER COLUMN energy_delivered_kwh TYPE NUMERIC(8, 3)
    USING energy_delivered_kwh::NUMERIC(8, 3);

ALTER TABLE station_hourly_metrics
    ALTER COLUMN energy_delivered_kwh TYPE NUMERIC(12, 3)
    USING energy_delivered_kwh::NUMERIC(12, 3);

TRUNCATE TABLE charging_sessions, station_hourly_metrics;

INSERT INTO charging_sessions SELECT * FROM staging_charging_sessions;
INSERT INTO station_hourly_metrics SELECT * FROM staging_station_hourly_metrics;

ALTER TABLE charging_sessions DROP CONSTRAINT IF EXISTS charging_sessions_station_id_fkey;
ALTER TABLE charging_sessions DROP CONSTRAINT IF EXISTS charging_sessions_vehicle_id_fkey;
ALTER TABLE weather DROP CONSTRAINT IF EXISTS weather_date_fkey;
ALTER TABLE traffic DROP CONSTRAINT IF EXISTS traffic_station_id_fkey;
ALTER TABLE traffic DROP CONSTRAINT IF EXISTS traffic_date_fkey;
ALTER TABLE station_hourly_metrics DROP CONSTRAINT IF EXISTS station_hourly_metrics_station_id_fkey;
ALTER TABLE station_hourly_metrics DROP CONSTRAINT IF EXISTS station_hourly_metrics_date_fkey;

ALTER TABLE charging_sessions
    ADD CONSTRAINT charging_sessions_station_id_fkey
    FOREIGN KEY (station_id) REFERENCES stations(station_id);

ALTER TABLE charging_sessions
    ADD CONSTRAINT charging_sessions_vehicle_id_fkey
    FOREIGN KEY (vehicle_id) REFERENCES vehicles(vehicle_id);

ALTER TABLE weather
    ADD CONSTRAINT weather_date_fkey
    FOREIGN KEY (date) REFERENCES calendar(date);

ALTER TABLE traffic
    ADD CONSTRAINT traffic_station_id_fkey
    FOREIGN KEY (station_id) REFERENCES stations(station_id);

ALTER TABLE traffic
    ADD CONSTRAINT traffic_date_fkey
    FOREIGN KEY (date) REFERENCES calendar(date);

ALTER TABLE station_hourly_metrics
    ADD CONSTRAINT station_hourly_metrics_station_id_fkey
    FOREIGN KEY (station_id) REFERENCES stations(station_id);

ALTER TABLE station_hourly_metrics
    ADD CONSTRAINT station_hourly_metrics_date_fkey
    FOREIGN KEY (date) REFERENCES calendar(date);

\i 'C:/PYTHON p45/EV-Charging-Infrastructure-Analytics-Demand-Forecasting-Utilization-Optimization/Project_files/sql/views/01_analytical_views.sql'

COMMIT;
