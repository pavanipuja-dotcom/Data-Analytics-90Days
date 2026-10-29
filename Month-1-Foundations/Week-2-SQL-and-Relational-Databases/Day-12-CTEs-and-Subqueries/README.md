
# Day 12: Subqueries, Derived Tables & Common Table Expressions (CTEs)

## 📌 Daily Overview
- **Focus Area:** T-SQL Subqueries (Scalar, Multi-row `IN`, Correlated `EXISTS`), Derived Tables, Single and Chained Common Table Expressions (`WITH` CTEs), and Business Benchmarking.
- **Time Invested:** 10 Hours
- **Core Objective:** Modularize complex multi-stage analytical pipelines, benchmark account performance against dynamic industry metrics, and analyze revenue contribution share.

---

## 🛠️ T-SQL Subquery & CTE Pattern Reference

| Pattern | Syntax Example | Technical Purpose |
| :--- | :--- | :--- |
| **Scalar Subquery** | `WHERE Revenue > (SELECT AVG(Revenue) FROM Table)` | Evaluates a single-value benchmark for row-level filtering. |
| **Correlated Subquery** | `WHERE EXISTS (SELECT 1 FROM Fact r WHERE r.ID = a.ID)` | Evaluates a subquery dynamically for every row in the outer query. |
| **Single CTE** | `WITH CTE_Name AS (SELECT ...) SELECT * FROM CTE_Name` | Creates a readable, temporary named result set for downstream queries. |
| **Chained CTEs** | `WITH CTE1 AS (...), CTE2 AS (...) SELECT ...` | Connects sequential data transformations into a linear pipeline. |

---

## 💡 Key Architectural Takeaway: Transaction vs. Account Aggregations

When calculating industry averages in multi-stage CTEs, pay close attention to grouping granularity:

- **Account-Level Average:** `AVG(Total_Account_Revenue)` calculates the average total revenue per account within an industry.
- **Transaction-Level Average:** `AVG(b.Revenue_Amount)` joining back to the raw transaction table calculates the average value per individual transaction across that industry.

---

## 📂 Deliverables & File Index
- `scripts/01_day_12_ctes_and_subqueries.sql`: Complete T-SQL query solutions for all Day 12 challenge blocks.
- `data/raw_account_revenue_seed.sql`: Database schema definition and seed datasets (`Dim_Enterprise_Accounts`, `Fact_Account_Revenue`).
