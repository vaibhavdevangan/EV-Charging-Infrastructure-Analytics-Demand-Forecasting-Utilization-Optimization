# Phase 8: SQL vs Python Responsibility Architecture

## Overview

The EV Charging Infrastructure Analytics project uses a layered analytical architecture that divides responsibilities between Python (exploratory, statistical, ML) and SQL (relational, operational, BI-ready).

## Architecture Layers

```
┌──────────────────────────────────────────────────────────────────┐
│ RAW CSV FILES (data/raw/)                                        │
│ - calendar.csv, stations.csv, vehicles.csv                       │
│ - charging_sessions.csv, weather.csv, traffic.csv                │
│ - station_hourly_metrics.csv                                     │
└────────────────────────┬─────────────────────────────────────────┘
                         │
                         ▼
┌──────────────────────────────────────────────────────────────────┐
│ PYTHON LAYER (Phases 1-7)                                        │
│ - Data validation and cleaning                                   │
│ - Exploratory Data Analysis (EDA)                                │
│ - Feature engineering                                            │
│ - Statistical analysis                                           │
│ - Geospatial analysis                                            │
│ - ML modeling (demand forecasting)                               │
│ - Visualization and storytelling                                 │
└────────────────────────┬─────────────────────────────────────────┘
                         │
                         ▼
┌──────────────────────────────────────────────────────────────────┐
│ POSTGRESQL RELATIONAL STORAGE (Phase 8 - NEW)                    │
│ - 7 normalized tables with PKs/FKs/Indexes                       │
│ - Business rule constraints                                      │
│ - Temporal and dimensional modeling                              │
│ - Complete referential integrity                                 │
└────────────────────────┬─────────────────────────────────────────┘
                         │
                         ▼
┌──────────────────────────────────────────────────────────────────┐
│ SQL ANALYTICAL LAYER (Phase 8)                                   │
│ - Aggregations (SUM, AVG, COUNT, etc.)                           │
│ - Multi-stage CTEs for complex logic                             │
│ - Window functions (RANK, DENSE_RANK, LAG/LEAD, etc.)           │
│ - Reusable views for consistency                                 │
│ - BI-ready datasets                                              │
│ - Operational dashboards                                         │
└────────────────────────┬─────────────────────────────────────────┘
                         │
                         ▼
┌──────────────────────────────────────────────────────────────────┐
│ FUTURE ANALYTICS                                                 │
│ - Power BI dashboards and reports (Phase 9)                      │
│ - Real-time operational monitoring                               │
│ - Infrastructure optimization recommendations                    │
│ - Prescriptive analytics                                         │
└──────────────────────────────────────────────────────────────────┘
```

## Why SQL Was Introduced (Phase 8)

### Problems Solved by SQL

1. **Data Integrity & Consistency**
   - Enforced schema with data types, PKs, FKs
   - Prevents invalid data insertion
   - Ensures referential integrity
   - Single source of truth for business metrics

2. **Operational Scalability**
   - Python in-memory analysis limited to available RAM
   - PostgreSQL handles 500K+ charging sessions efficiently
   - Indexes enable fast queries on large tables
   - Connection pooling for concurrent access

3. **Reusability & Standardization**
   - SQL views define consistent business metrics once
   - BI tools (Power BI, Tableau) connect to views directly
   - Eliminates calculation inconsistencies across teams
   - Version-controlled analytical definitions

4. **Aggregation Efficiency**
   - Database does aggregation at source (server-side)
   - Reduces network transfer of raw data
   - Queries return only results (not source data)
   - Natural for dimensional/temporal roll-ups

5. **Multi-User Analytics**
   - Concurrent access without code conflicts
   - Different analysts query same database simultaneously
   - Audit trail of queries and access
   - Role-based permissions support

6. **BI Tool Integration**
   - Power BI, Tableau, Looker connect directly to SQL
   - Dashboard creation without Python dependencies
   - Automatic refresh schedules
   - SQL becomes the analytics contract

## Python Responsibilities (Phases 1-7)

### Data Preparation & Validation
- Inspect raw CSV files
- Handle missing values
- Detect outliers
- Standardize data types
- Create derived features (datetime components, aggregations)

### Statistical Analysis
- Descriptive statistics (mean, median, std dev)
- Correlation analysis
- Hypothesis testing
- Probability distributions
- Parametric and non-parametric tests

### Advanced Modeling
- Time-series forecasting (ARIMA, Prophet)
- Machine learning (Random Forest, XGBoost)
- Geospatial analysis (clustering, distance calculations)
- Anomaly detection
- Dimensionality reduction

### Visualization & Communication
- Interactive plots with Plotly
- Static charts for reports
- Exploratory dashboards
- Data storytelling
- Insight communication

### One-Off Analysis
- Ad-hoc investigations
- Scenario testing
- Model validation
- Custom calculations
- Prototype analytics

## SQL Responsibilities (Phase 8+)

### Relational Data Management
- Table schema design
- Primary/foreign key definition
- Index strategy
- Constraint enforcement
- Data quality validation

### Analytical Aggregations
- Network-level KPIs
- Station performance rankings
- Temporal demand patterns
- Utilization calculations
- Efficiency metrics

### Complex Multi-Step Logic
- Multi-stage CTEs for interdependent calculations
- Window functions for relative rankings
- Percentile-based classifications
- Cumulative and rolling metrics
- Segmentation logic

### BI-Ready Datasets
- Pre-aggregated views
- Consistent metric definitions
- Dimensional tables
- Fact tables
- Conformed dimensions

### Operational Reporting
- Scheduled reports
- Real-time dashboards
- KPI monitoring
- Alert thresholds
- Audit trails

## Key Techniques Demonstrated

### SQL Techniques (Phase 8)

1. **CTEs (Common Table Expressions)**
   - Multi-stage logical flow
   - Readability and maintainability
   - Recursive queries (not needed here)
   - Example: `demand_capacity_analysis` (3-stage CTE)

2. **Window Functions**
   - RANK(), DENSE_RANK(), ROW_NUMBER()
   - LAG() and LEAD() for time-series
   - SUM() OVER for cumulative metrics
   - AVG() OVER for rolling averages
   - Example: Station ranking with cumulative sessions

3. **Aggregation**
   - GROUP BY with multiple levels
   - HAVING clauses for filtered groups
   - Composite aggregates
   - CASE-based grouping
   - Example: City-level geographic summary

4. **Classification Logic**
   - CASE statements for segmentation
   - Percentile-based thresholds
   - Multi-condition rules
   - Example: Station demand/congestion segments

5. **Index Strategy**
   - Station, vehicle, session ID lookups
   - Date range queries
   - Join optimization
   - Composite indexes for compound keys

### Python Techniques (Phases 1-7)

1. **Data Frame Manipulation**
   - pandas groupby() and agg()
   - merge() and join()
   - apply() for custom functions
   - Rolling windows and time-series

2. **Statistical Testing**
   - scipy.stats for distributions
   - hypothesis testing
   - correlation/regression
   - ANOVA and post-hoc tests

3. **Machine Learning**
   - scikit-learn models
   - train/test splits
   - cross-validation
   - hyperparameter tuning

4. **Visualization**
   - matplotlib for static plots
   - plotly for interactive dashboards
   - seaborn for statistical visualization
   - folium/geopandas for maps

5. **Feature Engineering**
   - Datetime features (hour, day, season)
   - Lag and diff features
   - Aggregated features
   - Domain knowledge features

## When to Use SQL vs Python

### Use SQL When

✓ Aggregating across large datasets
✓ Joining multiple tables consistently
✓ Defining reusable business metrics
✓ Creating BI-ready datasets
✓ Enforcing data constraints
✓ Running scheduled reports
✓ Supporting concurrent access
✓ Calculating percentile-based thresholds
✓ Implementing complex multi-step logic
✓ Building operational dashboards

### Use Python When

✓ Exploring raw data for the first time
✓ Performing statistical tests
✓ Building machine learning models
✓ Creating one-off analyses
✓ Prototyping new metrics
✓ Advanced visualization (interactive)
✓ Geospatial analysis
✓ Data validation and cleaning
✓ Custom aggregations not in SQL
✓ Scripting workflows

## Example: Station Performance Metric

### Python Approach (Exploratory)

```python
# Load charging sessions
df = pd.read_csv('charging_sessions.csv')
df_stations = pd.read_csv('stations.csv')

# Merge and aggregate
merged = df.merge(df_stations, on='station_id', how='left')
station_perf = merged.groupby('station_id').agg({
    'session_id': 'count',
    'energy_delivered_kwh': 'sum',
    'revenue_usd': 'sum'
}).rename(columns={'session_id': 'total_sessions'})

# Sort and display
top_stations = station_perf.nlargest(10, 'total_sessions')
print(top_stations)

# Visualize
top_stations.plot(kind='bar')
plt.show()
```

**Limitations:**
- Must load entire file into memory (500K rows × 17 columns)
- Different Python script for each metric
- Hard to maintain consistency across analyses
- Not suitable for concurrent access
- Difficult to integrate with BI tools

### SQL Approach (Operational)

```sql
-- Define once in a view
CREATE VIEW vw_station_performance AS
SELECT 
    s.station_id,
    s.city,
    COUNT(*) as total_sessions,
    SUM(cs.energy_delivered_kwh) as total_energy_kwh,
    SUM(cs.revenue_usd) as total_revenue_usd
FROM stations s
LEFT JOIN charging_sessions cs ON s.station_id = cs.station_id
GROUP BY s.station_id, s.city
ORDER BY total_sessions DESC;

-- Query once when needed
SELECT * FROM vw_station_performance LIMIT 10;

-- Use in Power BI, Tableau, or Python
df = pd.read_sql("SELECT * FROM vw_station_performance", conn)
```

**Advantages:**
- Executed at database (server-side)
- Consistent across all tools
- Indexed for performance
- Concurrent access support
- Directly connects to BI tools
- Version-controlled definition

## Data Flow Summary

1. **Raw CSV** → Inspected by Python, validated, transformed
2. **PostgreSQL** → SQL schema enforces structure and integrity
3. **SQL Queries** → Define business metrics consistently
4. **Python/BI** → Connect to SQL views for analysis and visualization
5. **Insights** → Delivered to stakeholders via dashboards

## Conclusion

The Phase 8 SQL layer complements Python analysis by:
- Ensuring data quality through schema constraints
- Providing reusable, standardized metrics
- Enabling operational reporting and BI integration
- Supporting scalability and concurrent access
- Creating a single source of truth for analytics

This layered approach combines Python's analytical flexibility with SQL's operational reliability—the best of both worlds for modern data analytics.
