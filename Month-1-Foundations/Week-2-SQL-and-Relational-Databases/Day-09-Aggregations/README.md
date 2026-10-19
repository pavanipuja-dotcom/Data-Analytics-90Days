# Day 09: SQL Aggregations, GROUP BY Logic & Business Metrics

## 📌 Daily Overview
- **Focus Area:** T-SQL Aggregate Functions (`COUNT`, `SUM`, `AVG`, `MIN`, `MAX`, `COUNT(DISTINCT)`), Multi-Column `GROUP BY` Clause, `WHERE` vs. `HAVING` Filtering Mechanics, and E-Commerce Metrics (AOV, Channel Mix %).
- **Time Invested:** 10 Hours
- **Core Objective:** Transform row-level sales logs into multi-dimensional summaries, analyze channel discount leakage, and measure customer segment order volume.

---

## 🔄 Execution Mechanics: `WHERE` vs. `HAVING`

Understanding the functional order of operations prevents aggregation scoping errors:

$$\text{FROM} \longrightarrow \text{WHERE (Filters Raw Rows)} \longrightarrow \text{GROUP BY} \longrightarrow \text{HAVING (Filters Aggregated Groups)} \longrightarrow \text{SELECT} \longrightarrow \text{ORDER BY}$$

- **`WHERE` Clause:** Applied **before** data is grouped. Used to eliminate raw rows (e.g., `WHERE Order_Status = 'Completed'`).
- **`HAVING` Clause:** Applied **after** data is aggregated. Used to filter grouped summaries (e.g., `HAVING SUM(Net_Revenue) > 5000.00`).

---

## 🛠️ T-SQL Aggregation Reference Sheet

| Function / Clause | Syntax Example | Business Purpose |
| :--- | :--- | :--- |
| **`COUNT(DISTINCT)`** | `COUNT(DISTINCT Customer_Segment)` | Counts unique active entities in a group. |
| **`GROUP BY`** | `GROUP BY Store_Region, Product_Category` | Defines dimensions for dynamic aggregations. |
| **`HAVING`** | `HAVING SUM(Order_Quantity) >= 15` | Filters summary rows based on aggregate metrics. |
| **Channel Mix %** | `SUM(Units) * 100.0 / (SELECT SUM(Units) FROM Table)` | Subquery percentage calculation across all records. |

---

## 📂 Deliverables & File Index
- `scripts/01_day_09_aggregations.sql`: T-SQL queries for all Day 9 challenge blocks.
- `data/raw_daily_sales.sql`: Database table creation and seed data for `Fact_Daily_Sales`.
