EV Charging Demand, Utilization & Infrastructure Analytics — Dataset Package

FILES
- stations.csv: station infrastructure layer based on the user-provided station dataset, cleaned and supplemented with derived station attributes.
- vehicles.csv: synthetic vehicle dimension.
- charging_sessions.csv: synthetic but relational charging-session fact table covering 2024-2025.
- weather.csv: synthetic contextual weather layer at observed location/date/hour combinations.
- traffic.csv: synthetic contextual traffic layer at observed station/date/hour combinations.
- station_hourly_metrics.csv: metrics DERIVED from charging_sessions.csv, not independently generated.
- calendar.csv: date dimension.
- data_dictionary.csv: field definitions and lineage.

IMPORTANT PROVENANCE
The original station fields come from the user-provided CSV. Fields/tables marked Synthetic or Derived were created for portfolio case-study purposes. Synthetic values should NOT be represented as real-world observations.

DESIGN PRINCIPLES
- Session demand is weighted by station average users/day.
- Demand varies by hour, weekday/weekend, season and a modest two-year growth trend.
- Energy, duration and power are constrained by vehicle battery capacity and station charger capacity.
- Wait time and queue length rise with demand pressure and peak periods.
- Hourly utilization and capacity utilization are calculated from session records.
- Weather and traffic are contextual synthetic variables and should be treated as correlation/context, not causal evidence.

DATE RANGE
2024-01-01 through 2025-12-31.

RANDOM SEED
42 for reproducibility.
