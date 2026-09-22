# Dataset Profiling Report

**Files profiled:** 8  
**Source:** `data/raw/`

---

## calendar.csv

- **Rows:** 731
- **Columns:** 9
- **Duplicate rows:** 0

### Column Details

| Column | Dtype | Missing | Missing % | Unique |
|--------|-------|---------|-----------|--------|
| Date | object | 0 | 0% | 731 |
| Year | int64 | 0 | 0% | 2 |
| Month | int64 | 0 | 0% | 12 |
| Quarter | object | 0 | 0% | 4 |
| Week | int64 | 0 | 0% | 52 |
| Day_of_Week | object | 0 | 0% | 7 |
| Weekend_Flag | int64 | 0 | 0% | 2 |
| Season | object | 0 | 0% | 4 |
| Holiday_Flag | int64 | 0 | 0% | 2 |

### Numeric Statistics

| Column | Min | Max | Mean | Median | Std |
|--------|-----|-----|------|--------|-----|
| Year | 2024 | 2025 | 2024 | 2024 | 0.5003 |
| Month | 1 | 12 | 6.52 | 7 | 3.452 |
| Week | 1 | 52 | 26.4 | 26 | 15.08 |
| Weekend_Flag | 0 | 1 | 0.2845 | 0 | 0.4515 |
| Holiday_Flag | 0 | 1 | 0.01094 | 0 | 0.1041 |

### Categorical Columns — Unique Values

- **Date** (731 unique): 2024-01-01, 2024-01-02, 2024-01-03, 2024-01-04, 2024-01-05, 2024-01-06, 2024-01-07, 2024-01-08, 2024-01-09, 2024-01-10, 2024-01-11, 2024-01-12, 2024-01-13, 2024-01-14, 2024-01-15 ... (731 total)
- **Quarter** (4 unique): Q1, Q2, Q3, Q4
- **Day_of_Week** (7 unique): Friday, Monday, Saturday, Sunday, Thursday, Tuesday, Wednesday
- **Season** (4 unique): Fall, Spring, Summer, Winter

### Data-Quality Observations

- ✅ No obvious issues found.

---

## charging_sessions.csv

- **Rows:** 500,000
- **Columns:** 17
- **Duplicate rows:** 0

### Column Details

| Column | Dtype | Missing | Missing % | Unique |
|--------|-------|---------|-----------|--------|
| Session_ID | object | 0 | 0% | 500000 |
| Station_ID | object | 0 | 0% | 5000 |
| Vehicle_ID | object | 0 | 0% | 10000 |
| Start_Time | object | 0 | 0% | 398206 |
| End_Time | object | 0 | 0% | 500000 |
| Charging_Duration_Min | float64 | 0 | 0% | 10714 |
| Energy_Delivered_kWh | float64 | 0 | 0% | 36982 |
| Average_Power_kW | float64 | 0 | 0% | 7086 |
| Charger_Type | object | 0 | 0% | 3 |
| Battery_Capacity_kWh | float64 | 0 | 0% | 7 |
| Initial_SOC_pct | float64 | 0 | 0% | 651 |
| Final_SOC_pct | float64 | 0 | 0% | 758 |
| Wait_Time_Min | float64 | 0 | 0% | 4212 |
| Queue_Length | int64 | 0 | 0% | 12 |
| Session_Status | object | 0 | 0% | 2 |
| Revenue_USD | float64 | 0 | 0% | 2144 |
| Peak_Demand_Flag | int64 | 0 | 0% | 2 |

### Numeric Statistics

| Column | Min | Max | Mean | Median | Std |
|--------|-----|-----|------|--------|-----|
| Charging_Duration_Min | 18.91 | 151.6 | 59.17 | 59.48 | 18.37 |
| Energy_Delivered_kWh | 3.759 | 48.83 | 17.09 | 15.91 | 7.495 |
| Average_Power_kW | 2.85 | 128.1 | 18.61 | 19.41 | 8.442 |
| Battery_Capacity_kWh | 40 | 100 | 65.75 | 60 | 16.76 |
| Initial_SOC_pct | 10 | 75 | 42.48 | 42.5 | 18.77 |
| Final_SOC_pct | 22.3 | 98 | 71.38 | 72.4 | 19.69 |
| Wait_Time_Min | 0 | 81.83 | 4.057 | 2.28 | 5.065 |
| Queue_Length | 0 | 11 | 0.7706 | 1 | 0.9347 |
| Revenue_USD | 0.39 | 25.34 | 5.214 | 4.48 | 3.18 |
| Peak_Demand_Flag | 0 | 1 | 0.3335 | 0 | 0.4715 |

### Categorical Columns — Unique Values

- **Session_ID** (500000 unique): SES0000001, SES0000002, SES0000003, SES0000004, SES0000005, SES0000006, SES0000007, SES0000008, SES0000009, SES0000010, SES0000011, SES0000012, SES0000013, SES0000014, SES0000015 ... (500000 total)
- **Station_ID** (5000 unique): EVS00001, EVS00002, EVS00003, EVS00004, EVS00005, EVS00006, EVS00007, EVS00008, EVS00009, EVS00010, EVS00011, EVS00012, EVS00013, EVS00014, EVS00015 ... (5000 total)
- **Vehicle_ID** (10000 unique): VEH00001, VEH00002, VEH00003, VEH00004, VEH00005, VEH00006, VEH00007, VEH00008, VEH00009, VEH00010, VEH00011, VEH00012, VEH00013, VEH00014, VEH00015 ... (10000 total)
- **Start_Time** (398206 unique): 2024-01-01 00:05:00, 2024-01-01 00:12:00, 2024-01-01 00:15:00, 2024-01-01 00:16:00, 2024-01-01 00:17:00, 2024-01-01 00:18:00, 2024-01-01 00:20:00, 2024-01-01 00:30:00, 2024-01-01 00:31:00, 2024-01-01 00:33:00, 2024-01-01 00:34:00, 2024-01-01 00:35:00, 2024-01-01 00:37:00, 2024-01-01 00:39:00, 2024-01-01 00:40:00 ... (398206 total)
- **End_Time** (500000 unique): 2024-01-01 00:33:45.689279826, 2024-01-01 00:49:34.540495152, 2024-01-01 00:53:46.012389054, 2024-01-01 01:11:49.672457082, 2024-01-01 01:15:22.278454104, 2024-01-01 01:21:27.855567738, 2024-01-01 01:25:13.974682788, 2024-01-01 01:25:15.082753314, 2024-01-01 01:28:44.373829272, 2024-01-01 01:29:06.563622810, 2024-01-01 01:29:31.705171584, 2024-01-01 01:31:31.694482787, 2024-01-01 01:31:49.687778808, 2024-01-01 01:33:08.007069281, 2024-01-01 01:33:24.670161660 ... (500000 total)
- **Charger_Type** (3 unique): AC Level 1, AC Level 2, DC Fast Charger
- **Session_Status** (2 unique): Completed, Interrupted

### Data-Quality Observations

- ✅ No obvious issues found.

---

## data_dictionary.csv

- **Rows:** 31
- **Columns:** 5
- **Duplicate rows:** 0

### Column Details

| Column | Dtype | Missing | Missing % | Unique |
|--------|-------|---------|-----------|--------|
| File | object | 0 | 0% | 6 |
| Column | object | 0 | 0% | 29 |
| Type | object | 0 | 0% | 6 |
| Definition | object | 0 | 0% | 31 |
| Lineage | object | 0 | 0% | 7 |

### Categorical Columns — Unique Values

- **File** (6 unique): calendar.csv, charging_sessions.csv, station_hourly_metrics.csv, stations.csv, traffic.csv, weather.csv
- **Column** (29 unique): Average_Power_kW, Average_Speed_kmh, Avg_Users_per_Day, Capacity_Utilization, Charging_Capacity_kW, Charging_Duration_Min, Congestion_Flag, Congestion_Level, Date, End_Time, Energy_Delivered_kWh, Holiday_Flag, Humidity_pct, Latitude, Longitude ... (29 total)
- **Type** (6 unique): category, date, datetime, float, integer, string
- **Definition** (31 unique): Ambient temperature, Average daily users from source, Average delivered power, Average road speed, Calendar date, Charging duration in minutes, Charging time / charger capacity during hour, Energy delivered during session, Energy delivered in station-hour, Estimated number of operational chargers, Estimated queue length at arrival, Estimated station aggregate power capacity, Estimated traffic volume index/count, Estimated waiting time before charging, Holiday indicator for selected major holidays ... (31 total)
- **Lineage** (7 unique): Derived, Derived from sessions, Source, Source/cleaned, Synthetic, Synthetic contextual, Synthetic/linked

### Data-Quality Observations

- ✅ No obvious issues found.

---

## station_hourly_metrics.csv

- **Rows:** 498,253
- **Columns:** 19
- **Duplicate rows:** 0

### Column Details

| Column | Dtype | Missing | Missing % | Unique |
|--------|-------|---------|-----------|--------|
| Station_ID | object | 0 | 0% | 5000 |
| Date | object | 0 | 0% | 730 |
| Hour | int64 | 0 | 0% | 24 |
| Sessions_Count | int64 | 0 | 0% | 3 |
| Energy_Delivered_kWh | float64 | 0 | 0% | 37521 |
| Average_Power_kW | float64 | 0 | 0% | 7781 |
| Peak_Power_kW | float64 | 0 | 0% | 7086 |
| Avg_Session_Duration_Min | float64 | 0 | 0% | 11597 |
| Avg_Wait_Time_Min | float64 | 0 | 0% | 4888 |
| Max_Queue_Length | int64 | 0 | 0% | 12 |
| Number_of_Chargers | int64 | 0 | 0% | 8 |
| Max_Station_Power_kW | int64 | 0 | 0% | 28 |
| Charger_Hours_Used | float64 | 0 | 0% | 11513 |
| Utilization_Rate | float64 | 0 | 0% | 9136 |
| Capacity_Utilization | float64 | 0 | 0% | 6943 |
| Chargers_Occupied | int64 | 0 | 0% | 4 |
| Available_Chargers | int64 | 0 | 0% | 8 |
| Congestion_Flag | int64 | 0 | 0% | 2 |
| Peak_Demand_Flag | int64 | 0 | 0% | 2 |

### Numeric Statistics

| Column | Min | Max | Mean | Median | Std |
|--------|-----|-----|------|--------|-----|
| Hour | 0 | 23 | 11.5 | 11 | 6.925 |
| Sessions_Count | 1 | 3 | 1.004 | 1 | 0.05925 |
| Energy_Delivered_kWh | 3.759 | 80.8 | 17.15 | 15.94 | 7.577 |
| Average_Power_kW | 2.85 | 128.1 | 18.61 | 19.4 | 8.435 |
| Peak_Power_kW | 2.85 | 128.1 | 18.62 | 19.43 | 8.445 |
| Avg_Session_Duration_Min | 18.91 | 151.6 | 59.17 | 59.47 | 18.36 |
| Avg_Wait_Time_Min | 0 | 81.83 | 4.056 | 2.28 | 5.06 |
| Max_Queue_Length | 0 | 11 | 0.7719 | 1 | 0.9353 |
| Number_of_Chargers | 1 | 8 | 3.606 | 3 | 1.969 |
| Max_Station_Power_kW | 22 | 2800 | 517.5 | 300 | 600.2 |
| Charger_Hours_Used | 0.3152 | 4.244 | 0.9897 | 0.9928 | 0.3124 |
| Utilization_Rate | 0.0402 | 1 | 0.3895 | 0.2856 | 0.2777 |
| Capacity_Utilization | 0.0012 | 1 | 0.1366 | 0.065 | 0.1897 |
| Chargers_Occupied | 1 | 4 | 1.404 | 1 | 0.496 |
| Available_Chargers | 0 | 7 | 2.201 | 2 | 1.912 |
| Congestion_Flag | 0 | 1 | 0.2723 | 0 | 0.4451 |
| Peak_Demand_Flag | 0 | 1 | 0.3334 | 0 | 0.4714 |

### Categorical Columns — Unique Values

- **Station_ID** (5000 unique): EVS00001, EVS00002, EVS00003, EVS00004, EVS00005, EVS00006, EVS00007, EVS00008, EVS00009, EVS00010, EVS00011, EVS00012, EVS00013, EVS00014, EVS00015 ... (5000 total)
- **Date** (730 unique): 2024-01-01, 2024-01-02, 2024-01-03, 2024-01-04, 2024-01-05, 2024-01-06, 2024-01-07, 2024-01-08, 2024-01-09, 2024-01-10, 2024-01-11, 2024-01-12, 2024-01-13, 2024-01-14, 2024-01-15 ... (730 total)

### Data-Quality Observations

- ✅ No obvious issues found.

---

## stations.csv

- **Rows:** 5,000
- **Columns:** 20
- **Duplicate rows:** 0

### Column Details

| Column | Dtype | Missing | Missing % | Unique |
|--------|-------|---------|-----------|--------|
| Station_ID | object | 0 | 0% | 5000 |
| City | object | 0 | 0% | 1 |
| State | object | 0 | 0% | 1 |
| Latitude | float64 | 0 | 0% | 4993 |
| Longitude | float64 | 0 | 0% | 4995 |
| Station_Operator | object | 0 | 0% | 5 |
| Charger_Type | object | 0 | 0% | 3 |
| Charging_Capacity_kW | int64 | 0 | 0% | 4 |
| Number_of_Chargers | int64 | 0 | 0% | 8 |
| Max_Station_Power_kW | int64 | 0 | 0% | 28 |
| Parking_Spots | int64 | 0 | 0% | 10 |
| Cost_USD_per_kWh | float64 | 0 | 0% | 41 |
| Renewable_Energy_Source | object | 0 | 0% | 2 |
| Availability | object | 0 | 0% | 3 |
| Installation_Year | int64 | 0 | 0% | 14 |
| Station_Age_Years | int64 | 0 | 0% | 14 |
| Station_Type | object | 0 | 0% | 3 |
| Capacity_per_Parking_Spot_kW | float64 | 0 | 0% | 77 |
| Avg_Users_per_Day | int64 | 0 | 0% | 165 |
| Location_ID | object | 0 | 0% | 1 |

### Numeric Statistics

| Column | Min | Max | Mean | Median | Std |
|--------|-----|-----|------|--------|-----|
| Latitude | -89.68 | 89.46 | 19.94 | 34.03 | 32.32 |
| Longitude | -178.9 | 179.7 | 8.833 | 18.5 | 93.72 |
| Charging_Capacity_kW | 22 | 350 | 144.3 | 150 | 128.4 |
| Number_of_Chargers | 1 | 8 | 3.607 | 3 | 1.971 |
| Max_Station_Power_kW | 22 | 2800 | 517.7 | 300 | 597.5 |
| Parking_Spots | 1 | 10 | 5.52 | 5 | 2.874 |
| Cost_USD_per_kWh | 0.1 | 0.5 | 0.3002 | 0.3 | 0.1157 |
| Installation_Year | 2010 | 2023 | 2017 | 2017 | 4.005 |
| Station_Age_Years | 3 | 16 | 9.431 | 9 | 4.005 |
| Capacity_per_Parking_Spot_kW | 7.33 | 350 | 98.05 | 66.67 | 92.51 |
| Avg_Users_per_Day | 15 | 179 | 96.78 | 96 | 47.76 |

### Categorical Columns — Unique Values

- **Station_ID** (5000 unique): EVS00001, EVS00002, EVS00003, EVS00004, EVS00005, EVS00006, EVS00007, EVS00008, EVS00009, EVS00010, EVS00011, EVS00012, EVS00013, EVS00014, EVS00015 ... (5000 total)
- **City** (1 unique): Unknown
- **State** (1 unique): Unknown
- **Station_Operator** (5 unique): ChargePoint, EVgo, Greenlots, Ionity, Tesla
- **Charger_Type** (3 unique): AC Level 1, AC Level 2, DC Fast Charger
- **Renewable_Energy_Source** (2 unique): No, Yes
- **Availability** (3 unique): 24/7, 6:00-22:00, 9:00-18:00
- **Station_Type** (3 unique): Destination/AC, Fast Charging, Ultra-Fast Charging
- **Location_ID** (1 unique): Unknown|Unknown

### Data-Quality Observations

- ⚠️ `Latitude` has 1132 negative values — verify if expected.
- ⚠️ `Longitude` has 2017 negative values — verify if expected.

---

## traffic.csv

- **Rows:** 498,253
- **Columns:** 6
- **Duplicate rows:** 0

### Column Details

| Column | Dtype | Missing | Missing % | Unique |
|--------|-------|---------|-----------|--------|
| Station_ID | object | 0 | 0% | 5000 |
| Date | object | 0 | 0% | 730 |
| Hour | int64 | 0 | 0% | 24 |
| Traffic_Volume | int64 | 0 | 0% | 1541 |
| Average_Speed_kmh | float64 | 0 | 0% | 465 |
| Congestion_Level | object | 0 | 0% | 4 |

### Numeric Statistics

| Column | Min | Max | Mean | Median | Std |
|--------|-----|-----|------|--------|-----|
| Hour | 0 | 23 | 11.5 | 11 | 6.925 |
| Traffic_Volume | 114 | 2017 | 524.1 | 457 | 233.9 |
| Average_Speed_kmh | 12 | 60 | 33.75 | 35.2 | 8.834 |

### Categorical Columns — Unique Values

- **Station_ID** (5000 unique): EVS00001, EVS00002, EVS00003, EVS00004, EVS00005, EVS00006, EVS00007, EVS00008, EVS00009, EVS00010, EVS00011, EVS00012, EVS00013, EVS00014, EVS00015 ... (5000 total)
- **Date** (730 unique): 2024-01-01, 2024-01-02, 2024-01-03, 2024-01-04, 2024-01-05, 2024-01-06, 2024-01-07, 2024-01-08, 2024-01-09, 2024-01-10, 2024-01-11, 2024-01-12, 2024-01-13, 2024-01-14, 2024-01-15 ... (730 total)
- **Congestion_Level** (4 unique): High, Low, Moderate, Severe

### Data-Quality Observations

- ✅ No obvious issues found.

---

## vehicles.csv

- **Rows:** 10,000
- **Columns:** 4
- **Duplicate rows:** 0

### Column Details

| Column | Dtype | Missing | Missing % | Unique |
|--------|-------|---------|-----------|--------|
| Vehicle_ID | object | 0 | 0% | 10000 |
| Vehicle_Type | object | 0 | 0% | 5 |
| Battery_Capacity_kWh | float64 | 0 | 0% | 7 |
| Vehicle_Age_Years | int64 | 0 | 0% | 12 |

### Numeric Statistics

| Column | Min | Max | Mean | Median | Std |
|--------|-----|-----|------|--------|-----|
| Battery_Capacity_kWh | 40 | 100 | 65.74 | 60 | 16.76 |
| Vehicle_Age_Years | 0 | 11 | 5.511 | 5 | 3.453 |

### Categorical Columns — Unique Values

- **Vehicle_ID** (10000 unique): VEH00001, VEH00002, VEH00003, VEH00004, VEH00005, VEH00006, VEH00007, VEH00008, VEH00009, VEH00010, VEH00011, VEH00012, VEH00013, VEH00014, VEH00015 ... (10000 total)
- **Vehicle_Type** (5 unique): Hatchback, Pickup, SUV, Sedan, Van

### Data-Quality Observations

- ✅ No obvious issues found.

---

## weather.csv

- **Rows:** 17,520
- **Columns:** 10
- **Duplicate rows:** 0

### Column Details

| Column | Dtype | Missing | Missing % | Unique |
|--------|-------|---------|-----------|--------|
| Location_ID | object | 0 | 0% | 1 |
| Date | object | 0 | 0% | 730 |
| Hour | int64 | 0 | 0% | 24 |
| City | object | 0 | 0% | 1 |
| State | object | 0 | 0% | 1 |
| Temperature_C | float64 | 0 | 0% | 398 |
| Humidity_pct | float64 | 0 | 0% | 532 |
| Rainfall_mm | float64 | 0 | 0% | 727 |
| Wind_Speed_kmh | float64 | 0 | 0% | 337 |
| Weather_Condition | object | 0 | 0% | 5 |

### Numeric Statistics

| Column | Min | Max | Mean | Median | Std |
|--------|-----|-----|------|--------|-----|
| Hour | 0 | 23 | 11.5 | 11.5 | 6.922 |
| Temperature_C | -3.2 | 40 | 18 | 18 | 7.947 |
| Humidity_pct | 33.6 | 98 | 64.97 | 64.95 | 8.485 |
| Rainfall_mm | 0 | 17.74 | 0.3855 | 0 | 1.312 |
| Wind_Speed_kmh | 0 | 37.6 | 13.9 | 13.8 | 5.927 |

### Categorical Columns — Unique Values

- **Location_ID** (1 unique): Unknown|Unknown
- **Date** (730 unique): 2024-01-01, 2024-01-02, 2024-01-03, 2024-01-04, 2024-01-05, 2024-01-06, 2024-01-07, 2024-01-08, 2024-01-09, 2024-01-10, 2024-01-11, 2024-01-12, 2024-01-13, 2024-01-14, 2024-01-15 ... (730 total)
- **City** (1 unique): Unknown
- **State** (1 unique): Unknown
- **Weather_Condition** (5 unique): Clear, Cold, Hot, Light Rain, Rain

### Data-Quality Observations

- ⚠️ `Temperature_C` has 37 negative values — verify if expected.

---
