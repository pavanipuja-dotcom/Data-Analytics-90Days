# Day 11: Conditional Logic, Null Handling & Set Operators

## 📌 Daily Overview
- **Focus Area:** T-SQL Searched `CASE WHEN` Statements, Null-Handling (`COALESCE`, `NULLIF`), Set Theory (`UNION`, `UNION ALL`, `INTERSECT`, `EXCEPT`), and Conditional Aggregations.
- **Time Invested:** 10 Hours
- **Core Objective:** Clean unstructured multi-channel sales logs, protect calculations against division-by-zero errors, deduplicate cross-channel customers, and execute conditional pivot-style summaries.

---

## 🛠️ T-SQL Operators & Function Reference

| Operator / Function | Syntax Example | Technical Purpose |
| :--- | :--- | :--- |
| **`CASE WHEN`** | `CASE WHEN Amount >= 3000 THEN 'Enterprise' ELSE 'SMB' END` | Dynamic row-level categorization. |
| **`COALESCE()`** | `COALESCE(Discount_Amount, 0.00)` | Replaces `NULL` values with the first non-null fallback expression. |
| **`NULLIF()`** | `Order_Amount / NULLIF(Order_Amount, 0)` | Returns `NULL` if two arguments are equal; prevents division-by-zero crashes. |
| **`UNION ALL`** | `SELECT ... UNION ALL SELECT ...` | Combines result sets preserving all rows (including duplicates). |
| **`UNION`** | `SELECT ... UNION SELECT ...` | Combines result sets and applies distinct sorting to eliminate duplicates. |
| **`INTERSECT`** | `SELECT ... INTERSECT SELECT ...` | Returns only distinct rows present in **both** query result sets. |
| **`EXCEPT`** | `SELECT ... EXCEPT SELECT ...` | Returns distinct rows from the left query that are **not** present in the right query. |

---

## 📂 Deliverables & File Index
- `scripts/01_day_11_case_when_and_sets.sql`: Complete T-SQL query solutions for all Day 11 challenge blocks.
- `data/raw_multi_channel_sales.sql`: Database table creation DDL and seed datasets (`Fact_Web_Sales`, `Fact_Store_Sales`).
