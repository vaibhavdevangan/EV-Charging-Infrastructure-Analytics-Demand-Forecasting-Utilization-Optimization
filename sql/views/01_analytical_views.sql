-- Phase 8: SQL Analytical Views (Simplified)
-- EV Charging Network Views for BI and Operational Analytics

-- View 1: Station Performance Summary
CREATE OR REPLACE VIEW vw_station_performance AS
SELECT 
    s.station_id,
    s.city,
    s.station_type,
    s.number_of_chargers,
    s.max_station_power_kw,
    COUNT(*) as total_sessions,
    SUM(cs.energy_delivered_kwh) AS total_energy_kwh,
    ROUND(CAST(AVG(cs.energy_delivered_kwh) AS NUMERIC), 2) as avg_energy_kwh,
    ROUND(CAST(SUM(cs.revenue_usd) AS NUMERIC), 2) as total_revenue_usd,
    ROUND(CAST(AVG(cs.revenue_usd) AS NUMERIC), 2) as avg_revenue_per_session,
    ROUND(CAST(AVG(cs.charging_duration_min) AS NUMERIC), 2) as avg_duration_min,
    ROUND(CAST(COUNT(*) / NULLIF(s.number_of_chargers, 0)::NUMERIC AS NUMERIC), 2) as sessions_per_charger
FROM stations s
LEFT JOIN charging_sessions cs ON s.station_id = cs.station_id
GROUP BY s.station_id, s.city, s.station_type, s.number_of_chargers, s.max_station_power_kw
ORDER BY total_sessions DESC;

-- View 2: Station Utilization Analysis
CREATE OR REPLACE VIEW vw_station_utilization AS
SELECT 
    s.station_id,
    s.city,
    s.number_of_chargers,
    COUNT(*) as total_sessions,
    ROUND(CAST(SUM(EXTRACT(EPOCH FROM (cs.end_time - cs.start_time)) / 3600) AS NUMERIC), 2) as total_charger_hours_used,
    ROUND(CAST(SUM(EXTRACT(EPOCH FROM (cs.end_time - cs.start_time)) / 3600) / (s.number_of_chargers * 8766) * 100 AS NUMERIC), 2) as utilization_pct,
    ROUND(CAST(AVG(cs.wait_time_min) AS NUMERIC), 2) as avg_wait_time_min,
    CASE 
        WHEN SUM(EXTRACT(EPOCH FROM (cs.end_time - cs.start_time)) / 3600) / (s.number_of_chargers * 8766) * 100 >= 50 THEN 'High'
        WHEN SUM(EXTRACT(EPOCH FROM (cs.end_time - cs.start_time)) / 3600) / (s.number_of_chargers * 8766) * 100 < 25 THEN 'Low'
        ELSE 'Medium'
    END as utilization_class
FROM stations s
LEFT JOIN charging_sessions cs ON s.station_id = cs.station_id
GROUP BY s.station_id, s.city, s.number_of_chargers
ORDER BY utilization_pct DESC;

-- View 3: Station Congestion Analysis
CREATE OR REPLACE VIEW vw_station_congestion AS
SELECT 
    s.station_id,
    s.city,
    COUNT(*) as total_sessions,
    ROUND(CAST(AVG(cs.wait_time_min) AS NUMERIC), 2) as avg_wait_time_min,
    ROUND(CAST(MAX(cs.queue_length) AS NUMERIC), 2) as max_queue_length,
    ROUND(CAST(AVG(cs.queue_length) AS NUMERIC), 2) as avg_queue_length,
    SUM(CASE WHEN cs.wait_time_min > 15 THEN 1 ELSE 0 END) as sessions_with_long_wait,
    ROUND(CAST(SUM(CASE WHEN cs.wait_time_min > 15 THEN 1 ELSE 0 END) * 100.0 / NULLIF(COUNT(*), 0) AS NUMERIC), 2) as pct_long_wait_sessions,
    CASE 
        WHEN AVG(cs.wait_time_min) > 10 THEN 'High Congestion'
        WHEN AVG(cs.queue_length) > 2 THEN 'Moderate Congestion'
        ELSE 'Low Congestion'
    END as congestion_level
FROM stations s
LEFT JOIN charging_sessions cs ON s.station_id = cs.station_id
GROUP BY s.station_id, s.city
ORDER BY avg_wait_time_min DESC NULLS LAST;

-- View 4: Infrastructure Efficiency Metrics
CREATE OR REPLACE VIEW vw_station_infrastructure_efficiency AS
SELECT 
    s.station_id,
    s.city,
    s.number_of_chargers,
    s.max_station_power_kw,
    s.charging_capacity_kw,
    COUNT(*) as total_sessions,
    SUM(cs.energy_delivered_kwh) AS total_energy_kwh,
    ROUND(CAST(SUM(cs.revenue_usd) AS NUMERIC), 2) as total_revenue_usd,
    ROUND(CAST(NULLIF(SUM(cs.revenue_usd), 0) / NULLIF(s.number_of_chargers, 0)::NUMERIC AS NUMERIC), 2) as revenue_per_charger,
    ROUND(CAST(NULLIF(SUM(cs.energy_delivered_kwh), 0) / NULLIF(s.max_station_power_kw, 0)::NUMERIC AS NUMERIC), 2) as energy_intensity,
    CASE 
        WHEN NULLIF(SUM(cs.revenue_usd), 0) / NULLIF(s.number_of_chargers, 0) > 1000 THEN 'Highly Efficient'
        WHEN NULLIF(SUM(cs.revenue_usd), 0) / NULLIF(s.number_of_chargers, 0) > 500 THEN 'Efficient'
        WHEN NULLIF(SUM(cs.revenue_usd), 0) / NULLIF(s.number_of_chargers, 0) > 100 THEN 'Moderately Efficient'
        ELSE 'Low Efficiency'
    END as efficiency_class
FROM stations s
LEFT JOIN charging_sessions cs ON s.station_id = cs.station_id
GROUP BY s.station_id, s.city, s.number_of_chargers, s.max_station_power_kw, s.charging_capacity_kw
ORDER BY revenue_per_charger DESC NULLS LAST;

-- View 5: Geographic Summary by City
CREATE OR REPLACE VIEW vw_geographic_summary AS
SELECT 
    s.city,
    COUNT(DISTINCT s.station_id) as num_stations,
    SUM(s.number_of_chargers) as total_chargers,
    ROUND(CAST(SUM(s.max_station_power_kw) AS NUMERIC), 2) as total_capacity_kw,
    COUNT(DISTINCT cs.session_id) as total_sessions,
    COUNT(DISTINCT cs.vehicle_id) as unique_vehicles,
    SUM(cs.energy_delivered_kwh) AS total_energy_kwh,
    ROUND(CAST(SUM(cs.revenue_usd) AS NUMERIC), 2) as total_revenue_usd,
    ROUND(CAST(AVG(cs.charging_duration_min) AS NUMERIC), 2) as avg_duration_min,
    ROUND(CAST(AVG(cs.wait_time_min) AS NUMERIC), 2) as avg_wait_time_min
FROM stations s
LEFT JOIN charging_sessions cs ON s.station_id = cs.station_id
GROUP BY s.city
ORDER BY total_sessions DESC;
