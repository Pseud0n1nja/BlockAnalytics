# Liquid Staking Monitor

This repository contains the SQL queries and assets needed to build an interactive dashboard for tracking liquid staking token (LST) expansion and yield dynamics.
- **queries/**  
  - `liquid_staking_queries.sql` – All SQL logic for computing market cap, dominance, yield spreads, peg deviations, and Curve pool depth.

- **assets/**  
  - `dashboard_screenshot.png` – Example snapshot of the Liquid Staking Monitor dashboard.

---

## 🚀 Dashboard Overview
![Screenshot 2025-07-11 at 08 11 05](https://github.com/user-attachments/assets/5088f1b0-60f0-49b2-94cb-58c71a9b20d0)
![Screenshot 2025-07-11 at 08 11 34](https://github.com/user-attachments/assets/8ff2f945-9ab2-4114-bf85-5d5aaae10083)



### Liquid Staking Monitor 🌊

- **Focus**  
  - **LST Expansion** – Growth in market capitalization and share of total staking.  
  - **Yields** – Comparative APY spreads across major LSTs and underlying protocols.

- **Key Metrics**  
  1. **LST Market Cap & Dominance** – Absolute market cap and percentage share versus total staking assets.  
  2. **Yield Spreads** – APY differentials between leading LSTs (e.g., stETH vs. rETH).  
  3. **Peg Deviations** – Distance from 1:1 peg for each LST.  
  4. **Curve Depth** – Liquidity depth in stable swap pools supporting LSTs.

- **Visualizations**  
  - **Dominance Charts** – Stacked area or pie charts showing LST market share over time.  
  - **Peg Deviation Lines** – Line charts tracking peg stability of each LST.  
  - **APY Spread Charts** – Bar or line charts comparing yield spreads across tokens.  
  - **Curve Depth Heatmap** – Visualization of liquidity concentration in key Curve pools.

---

## 📖 How to Use

1. **Load your data** into your SQL-capable analytics platform.  
2. **Execute** the `liquid_staking_queries.sql` to generate the necessary result sets.  
3. **Connect** each query output to your chart widgets:  
   - Area/pie for market dominance  
   - Line for peg deviations  
   - Bar/line for APY spreads  
   - Heatmap for Curve depth

4. **Compose your dashboard** to reflect the Liquid Staking Monitor layout.

---

## ⚙️ Customization

- **Timeframes** – parameterize queries with custom date windows (e.g., 7-day, 30-day).  
- **Token selection** – adjust the list of LST symbols in the SQL to include or exclude assets.  
- **Granularity** – switch between daily, hourly, or weekly aggregations.

---

With this single SQL file and dashboard setup, you can continuously monitor the health, growth, and yield competitiveness of the liquid staking ecosystem.

