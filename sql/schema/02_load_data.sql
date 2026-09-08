-- Data loading script for ev_charging database
-- Load data from raw CSV files into PostgreSQL tables

-- 1. Load calendar data
\COPY calendar (date, year, month, quarter, week, day_of_week, weekend_flag, season, holiday_flag) 
FROM 'c:/PYTHON p45/EV-Charging-Infrastructure-Analytics-Demand-Forecasting-Utilization-Optimization/Project_files/data/raw/calendar.csv' 
WITH (FORMAT csv, HEADER true, DELIMITER ',', NULL 'NaN');

-- 2. Load stations data
\COPY stations (station_id, location_id, latitude, longitude, city, state, number_of_chargers, max_station_power_kw, parking_spots, charging_capacity_kw, cost_usd_per_kwh, station_operator, station_type, charger_type, installation_year, station_age_years, renewable_energy_source, availability, avg_users_per_day, capacity_per_parking_spot_kw)
FROM 'c:/PYTHON p45/EV-Charging-Infrastructure-Analytics-Demand-Forecasting-Utilization-Optimization/Project_files/data/raw/stations.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', NULL 'NaN');

-- 3. Load vehicles data
\COPY vehicles (vehicle_id, vehicle_type, battery_capacity_kwh, vehicle_age_years)
FROM 'c:/PYTHON p45/EV-Charging-Infrastructure-Analytics-Demand-Forecasting-Utilization-Optimization/Project_files/data/raw/vehicles.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', NULL 'NaN');

-- 4. Load weather data
\COPY weather (location_id, date, hour, city, state, temperature_c, humidity_pct, rainfall_mm, wind_speed_kmh, weather_condition)
FROM 'c:/PYTHON p45/EV-Charging-Infrastructure-Analytics-Demand-Forecasting-Utilization-Optimization/Project_files/data/raw/weather.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', NULL 'NaN');

-- 5. Load traffic data
\COPY traffic (station_id, date, hour, traffic_volume, average_speed_kmh, congestion_level)
FROM 'c:/PYTHON p45/EV-Charging-Infrastructure-Analytics-Demand-Forecasting-Utilization-Optimization/Project_files/data/raw/traffic.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', NULL 'NaN');

-- 6. Load station_hourly_metrics data
\COPY station_hourly_metrics (station_id, date, hour, sessions_count, energy_delivered_kwh, average_power_kw, peak_power_kw, avg_session_duration_min, avg_wait_time_min, max_queue_length, number_of_chargers, max_station_power_kw, charger_hours_used, utilization_rate, capacity_utilization, chargers_occupied, available_chargers, congestion_flag, peak_demand_flag)
FROM 'c:/PYTHON p45/EV-Charging-Infrastructure-Analytics-Demand-Forecasting-Utilization-Optimization/Project_files/data/raw/station_hourly_metrics.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', NULL 'NaN');

-- 7. Load charging_sessions data (largest file - load last)
\COPY charging_sessions (session_id, station_id, vehicle_id, start_time, end_time, charging_duration_min, energy_delivered_kwh, average_power_kw, charger_type, battery_capacity_kwh, initial_soc_pct, final_soc_pct, wait_time_min, queue_length, session_status, revenue_usd, peak_demand_flag)
FROM 'c:/PYTHON p45/EV-Charging-Infrastructure-Analytics-Demand-Forecasting-Utilization-Optimization/Project_files/data/raw/charging_sessions.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', NULL 'NaN');
