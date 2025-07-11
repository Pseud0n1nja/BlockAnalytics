# Analytics Dashboard with SQL Insights

A concise guide to using SQL queries for extracting actionable insights and building an interactive dashboard.

---

## Overview

This README outlines a generic workflow for turning raw market data into meaningful visualizations and metrics. By writing targeted SQL queries against a time-series data store (e.g., price, volume, supply), you can uncover trends, anomalies, and key performance indicators that drive better decision-making.

---

## Core Concepts

1. **Data Ingestion**  
   - Stream or batch-load JSON/CSV data into a relational table.  
   - Normalize timestamps, numeric fields, and identifiers for consistency.

2. **Insight-Driven Queries**  
   - **Trend Analysis:** Use window functions (`OVER`, `LAG`, `RANK`) to compute moving averages, growth rates, and ranking changes.  
   - **Comparative Metrics:** Join multiple assets or time periods to highlight relative performance.  
   - **Distribution & Segmentation:** Aggregate by category (e.g., token type, region) to see concentration or dispersion.

3. **Dashboard Assembly**  
   - Convert each SQL result into a chart or table: line charts for trends, bar/pie charts for distributions, heatmaps for correlation matrices.  
   - Add interactive filters (date ranges, asset selectors) so end-users can drill down.

---

## Typical Workflow

1. **Define Your Questions**  
   - What moved the most over the last 30 days?  
   - Which assets have the largest supply dilution?  
   - How did trading volume shift before, during, and after major events?

2. **Write & Refine Queries**  
   - Start with a simple `SELECT` and `WHERE` clause.  
   - Introduce aggregations (`SUM`, `AVG`, `COUNT`) and window functions.  
   - Test edge cases and compare against known benchmarks.

3. **Visualize & Share**  
   - Map each query to a visualization widget.  
   - Organize widgets into a coherent layout: overview at top, deep-dive charts below.  
   - Enable filters to empower exploratory analysis.

---

## Example Insight Queries

> *Note: table names and column names are placeholders.*

- **Top Movers**  
  ```sql
  SELECT symbol,
         ROUND((price_current - price_30d_ago) / price_30d_ago * 100, 2) AS pct_change
  FROM market_prices
  WHERE timestamp = CURRENT_DATE
  ORDER BY pct_change DESC
  LIMIT 5;
