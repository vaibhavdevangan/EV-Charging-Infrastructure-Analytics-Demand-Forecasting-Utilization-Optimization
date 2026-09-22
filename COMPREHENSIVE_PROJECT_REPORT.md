# ⚡ Comprehensive Project Report: EV Charging Demand, Utilization & Infrastructure Analytics

**Date:** September 2026  
**Domain:** Business Intelligence, Data Engineering, & Prescriptive Analytics  
**Data Status:** Synthetic/Generated Dataset (Used to demonstrate advanced pipeline and analytical workflows)

---

## Executive Summary
As Electric Vehicle (EV) adoption accelerates, charging network operators face a critical infrastructure challenge: balancing capacity against geographic and temporal demand. Overbuilt stations strand capital, while underbuilt stations cause severe congestion, degrading the customer experience.

This project represents a complete, 10-phase data analytics pipeline designed to answer fundamental business questions regarding network efficiency. Utilizing SQL, Python, Machine Learning, and Business Intelligence (Plotly), this analysis dissects data from 5,000 EV charging stations (processing 500,000 charging sessions). The core output of this project is a **Decision-Support Engine (Gap Score)** and a **4-page interactive dashboard** that empowers stakeholders to allocate capital expenditure (Capex) analytically rather than intuitively.

---

## 1. Business Problem & Objectives
The operational mandate for this analysis was to move beyond basic descriptive statistics and provide prescriptive recommendations for infrastructure expansion.

### Key Objectives:
1. **Assess Performance:** How efficiently is the current 5,000-station EV charging network serving demand?
2. **Identify Bottlenecks:** Where are capacity constraints (high congestion and long wait times) occurring?
3. **Understand Drivers:** What structural factors (e.g., station type, number of chargers, parking ratio) are statistically associated with high utilization?
4. **Prioritize Capex:** How can the business mathematically prioritize which specific stations require immediate hardware expansion?

---

## 2. Dataset Overview
The analysis was performed on a highly detailed station-level dataset comprising:
* **Scope:** 5,000 unique charging stations.
* **Scale:** 500,000 individual charging sessions.
* **Features:** 17 core dimension and fact metrics, including `Number_of_Chargers`, `Max_Station_Power_kW`, `Avg_Utilization`, `Congestion_Freq`, `Total_Sessions`, and `Avg_Wait_Time`.
* *Note: The dataset relies on synthetic generation. Consequently, the observed metrics demonstrate exceptionally strong structural relationships used to illustrate an ideal analytics environment. Findings should be interpreted as associative, not strictly causal.*

---

## 3. Methodology & 10-Phase Analytics Workflow
The project was executed in a robust, industry-standard 10-phase sequence:

* **Phases 1-3 (Data Handling & SQL):** Raw transactional CSV data was ingested into a **PostgreSQL** database. Complex SQL queries were written to aggregate millions of raw session logs into hourly and station-level metrics.
* **Phases 4-5 (Cleaning & EDA):** Migrated aggregated data into **Python (Pandas)** for deep Exploratory Data Analysis. Identified distinct outliers, handling missing values, and charting base distributions.
* **Phases 6-7 (Statistics & Feature Engineering):** Conducted rigorous correlation testing. Engineered advanced metrics like `Power_per_Charger` and `Charger_to_Parking_Ratio` to evaluate infrastructure density.
* **Phase 8 (Machine Learning):** Leveraged **Scikit-Learn** to build baseline classification models capable of predicting which stations cross into critical congestion risk thresholds.
* **Phases 9-10 (Prescriptive Analytics & BI):** Merged SQL outputs with engineered features to segment the network and built an interactive **Plotly & Jupyter Dashboard** for executive consumption.

---

## 4. Key Analytical Insights
The Exploratory and Statistical phases unveiled profound structural patterns within the network:

### A. The "Fewer Chargers" Congestion Trap
The most actionable finding of the project was the extreme inverse correlation (-0.875) between the `Number_of_Chargers` at a station and its `Avg_Utilization`. 
* Stations with only **1 to 2 chargers** experienced extreme utilization rates (often over 85%).
* However, this hyper-utilization caused severe bottlenecks, resulting in Average Congestion Frequencies exceeding 75%. 
* **Business Insight:** Building small-footprint infrastructure is highly detrimental to customer wait times. The data strongly suggests a baseline minimum of 4 chargers should be targeted for new developments.

### B. The Demand vs. Capacity Disconnect
Total charging demand (`Total_Sessions`) showed a surprisingly weak direct correlation to utilization. Instead, utilization and congestion were almost entirely dictated by *hardware capacity*. A high-demand station with 8 chargers functions beautifully, while a low-demand station with 1 charger triggers a queue. 

---

## 5. The "Gap Score" & Capital Allocation Strategy
Instead of blindly funding expansions at stations with the highest total sessions, a custom metric was engineered to rank stations objectively: **The Gap Score**.

### The Gap Score Formula:
The Gap Score acts as a weighted decision-support indicator (normalized from 0 to 1), prioritizing stations where demand is outstripping physical capacity:
> `Gap Score = (Normalized Demand * 0.4) + (Normalized Congestion * 0.4) - (Normalized Capacity * 0.2)`

### Infrastructure Segmentation
Using the data, every station in the 5,000-location network was tagged into one of five actionable operational tiers:
1. **Critical Congestion & Expansion Candidates:** High Gap Scores. These are the immediate targets for Capex hardware upgrades.
2. **Healthy Giants:** Large stations processing massive volume efficiently. (Action: Monitor).
3. **Overbuilt / Underutilized:** Massive capacity but low utilization. (Action: Halt Capex, investigate location visibility).
4. **Low Demand:** Minimal traffic. (Action: Optimize operating costs).

---

## 6. Business Intelligence (Plotly Dashboard)
To hand off these insights to non-technical stakeholders, Phase 10 culminated in a professional, no-code-required analytical dashboard featuring 4 distinct pages:

1. **Executive Overview:** Network-level KPIs tracking Total Sessions, Energy Delivered, and Revenue, alongside an emergency tracker for the Top 10 worst-performing stations by wait times.
2. **Station Performance:** A breakdown of charging demand isolated by specific hardware tier (e.g., Ultra-Fast vs Level 2).
3. **Root Cause Analysis:** Interactive heatmaps visually proving to stakeholders why 1-2 charger layouts fail under stress.
4. **Action Plan:** The definitive Top-15 Capex priority list sorted by Gap Score, telling the business exactly where to deploy capital tomorrow.

---

## 7. Final Recommendations
Based on the data modeling and analytics pipeline, the charging network should adopt the following operational strategies:
1. **Revise Real Estate Minimums:** Cease acquiring footprints that only allow for 1-2 chargers. The threshold for preventing recurring congestion sits closer to 4+ chargers.
2. **Data-Driven Funding:** Utilize the newly implemented `Gap Score` metric for all future quarterly Capex reviews, ensuring expansion dollars are spent solving physical bottlenecks, not just chasing raw session volume. 
3. **Deploy the Dashboard:** Equip regional managers with the Phase 10 Plotly Tool to monitor localized segment shifts (e.g., stations moving from "Healthy" to "Critical Congestion" status) in real-time.
