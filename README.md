# ⚡ EV Charging Demand, Utilization & Infrastructure Analytics

![Python](https://img.shields.io/badge/Python-3.11-blue?logo=python&logoColor=white)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-Data_Analysis-336791?logo=postgresql&logoColor=white)
![Plotly](https://img.shields.io/badge/Plotly-Dashboard-3f4f75?logo=plotly&logoColor=white)
![Scikit-Learn](https://img.shields.io/badge/Scikit--Learn-Machine_Learning-F7931E?logo=scikit-learn&logoColor=white)

An end-to-end, portfolio-grade analytics project evaluating the performance, capacity constraints, and expansion potential of an EV charging network. 

## 📖 Business Problem
As EV adoption grows, charging networks must balance capacity with demand. Overbuilt stations waste capital, while underbuilt stations suffer from high congestion and poor customer experience. 

This project answers a central business question: 
> *"How efficiently is the EV charging network serving demand, what factors drive utilization, and where should additional charging infrastructure be prioritized?"*

## 🛠️ Tech Stack & Workflow
This project moves through a complete 10-phase data pipeline:
1. **Data Engineering:** Migrated raw CSV data into a **PostgreSQL** database for initial aggregation and validation.
2. **Data Processing:** Cleaned and formatted data using **Python (Pandas)**.
3. **Exploratory Data Analysis (EDA):** Identified demand distributions and temporal anomalies.
4. **Statistical Analysis:** Tested correlations between station characteristics, wait times, and congestion frequency.
5. **Feature Engineering & ML:** Created derived metrics and built baseline classification models (using **Scikit-Learn**) to analyze congestion risk.
6. **Interactive Dashboard:** Built a business-facing UI using **Plotly & Jupyter**.

---

## 📊 Dashboard Visuals & Business Solutions

The final output is a 4-page interactive dashboard. Each section is designed to answer a specific operational question and drive a business decision.

### 1. Executive Overview
* **The Business Question:** What is our current high-level network performance, and where are our immediate bottlenecks?
* **The Visuals:** 6 Network-level KPIs (Total Sessions, Revenue, Overall Utilization) & Top 10 Congested Stations Table.
* **The Solution:** Allows executives to instantly baseline network health and immediately deploy operational teams to the 10 stations causing the highest customer friction (wait times).

> *[ 📸 Insert Screenshot of Page 1 Here, e.g., `![Executive Overview](images/page1.png)` ]*

### 2. Station Performance
* **The Business Question:** Which station architectures and hardware types are processing the most demand?
* **The Visuals:** "Top 10 Stations by Demand" Table and "Charging Demand by Station Type" Bar Charts.
* **The Solution:** Reveals which hardware tier (e.g., Ultra-Fast vs Level 2) is carrying the network load, heavily informing future hardware purchasing and vendor negotiations. 

> *[ 📸 Insert Screenshot of Page 2 Here ]*

### 3. Root Cause Analysis
* **The Business Question:** What structural infrastructure decisions are directly associated with high congestion?
* **The Visuals:** Interactive Correlation Heatmap & "Utilization and Congestion by Charger Count" Grouped Box/Bar Plots.
* **The Solution:** Analytically proves the "Fewer Chargers Trap." Data shows that building small-footprint stations (1-2 chargers) leads to intense congestion (>75%). This proves to real-estate stakeholders that future site acquisitions must accommodate 4+ chargers per site.

> *[ 📸 Insert Screenshot of Page 3 Here ]*

### 4. Infrastructure Action Plan 
* **The Business Question:** Given limited Capital Expenditure (Capex) budgets, which specific stations should we expand next, and which should we leave alone?
* **The Visuals:** "Gap Score" Prioritization Table & Segmentation Distribution Donut Chart.
* **The Solution:** Translates raw descriptive data into prescriptive actions. Stations are grouped into operational segments (*Expansion Candidates, Healthy Giants, Overbuilt, Sleepy*). Using a custom, algorithmically weighted **Gap Score**, the business is given a ranked top-15 target list dictating exactly where to spend expansion dollars first.

> *[ 📸 Insert Screenshot of Page 4 Here ]*

---

## 🚀 How to Run the Dashboard locally
1. Clone this repository.
2. Ensure you have the required dependencies: `pip install pandas plotly jupyter`
3. Open `notebooks/10_dashboard/EV_Charging_Dashboard.ipynb`.
4. Click **Run All**. The Plotly dashboard will render interactively right inside the notebook!

---
*Note: This portfolio project utilizes a synthetic dataset to demonstrate advanced analytical workflows, pipeline development, and business intelligence techniques. Relationships observed are associative and meant for analytical demonstration, not direct real-world deployment.*
