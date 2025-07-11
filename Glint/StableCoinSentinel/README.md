
- **queries/**  
  - `peg_deviations.sql` – Calculates hourly and daily deviations from the $1 peg.  
  - `supply_trends.sql` – Tracks circulating supply changes over time.  
  - `velocity_ratios.sql` – Computes velocity (turnover) as volume / circulating supply.  
  - `swap_slippage.sql` – Estimates average slippage on $1M swaps across major AMMs.
  - `StableCoinSankey.sql` - Generates the classigfication of the types of Stablecoins, can be used to build Sankey Chart

---

## 🚀 Dashboard Overview
![Screenshot 2025-07-11 at 07 57 46](https://github.com/user-attachments/assets/43e236c9-e9cf-44c6-931e-e4e06ee3ba7d)
![Screenshot 2025-07-11 at 07 58 33](https://github.com/user-attachments/assets/d05575a2-45f9-4bfc-be43-be2a45c8f6c0)

### Top-10 Stablecoins Health Board 💵

- **Focus**  
  - **Peg Stability** – How closely each stablecoin holds to its $1 target.  
  - **Velocity** – Transaction turnover relative to supply.

- **Key Metrics**  
  1. **Peg Deviations** – Absolute and percentage distance from $1.00.  
  2. **Supply Trends** – Daily circulating supply movements.  
  3. **Velocity Ratios** – 7-day and 30-day volume / supply.  
  4. **$1M Swap Slippage** – Median slippage for a $1 million trade.

- **Visualizations**  
  - **Peg Heatmap** – Hourly deviations across coins and time.  
  - **Supply Area Chart** – Stacked areas showing supply growth or contraction.  
  - **Velocity Scatter Plot** – Velocity vs. market‐cap for comparative analysis.  

---

## 📖 How to Use

1. **Load your data** into your SQL-capable analytics platform (e.g., Glint Analytics).  
2. **Run each query** in the `/queries` folder to populate your charts and tables.  
3. **Hook up visual widgets** to the result sets:  
   - Heatmap for `peg_deviations`  
   - Area chart for `supply_trends`  
   - Scatter plot for `velocity_ratios`  
   - Table or gauge for `swap_slippage`

4. **Arrange your dashboard** to recreate the Top-10 Health Board layout.

---

## ⚙️ Customization

- **Date ranges** – parameterize queries with custom start/end dates.  
- **Coin list** – adjust the `WHERE` clause to monitor a different set of assets.  
- **Aggregation intervals** – switch hourly to daily or weekly granularity as needed.

---

With these queries and visuals, you’ll have a clear, data-driven view of stablecoin dynamics—pinpointing peg risks and tracking on-chain velocity at a glance.

