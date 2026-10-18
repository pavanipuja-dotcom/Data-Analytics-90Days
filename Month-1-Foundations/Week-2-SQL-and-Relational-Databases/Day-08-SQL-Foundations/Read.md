# Day 08: RDBMS Foundations, SQL Server Setup & T-SQL Filtering

## 📌 Daily Overview
- **Focus Area:** SQL Server / SSMS Environment Setup, RDBMS vs. Flat Files, SQL Execution Order, Schema Design, Data Types, and T-SQL Filtering Operators (`LIKE`, `IN`, `BETWEEN`, `ESCAPE`).
- **Time Invested:** 10 Hours
- **Core Objective:** Establish local SQL Server instance (`Data_Analytics_90Days`), design relational table schemas with primary keys and constraints, and execute filtered transactional queries across multi-condition business requirements.

---

## 🔄 SQL Logical Execution Order

Understanding execution order prevents scoping errors when aliasing and filtering:

$$\text{FROM} \longrightarrow \text{WHERE} \longrightarrow \text{GROUP BY} \longrightarrow \text{HAVING} \longrightarrow \text{SELECT} \longrightarrow \text{ORDER BY} \longrightarrow \text{OFFSET/FETCH}$$

---

## 🛠️ T-SQL Operator Reference Sheet

| Operator | Syntax Example | Purpose |
| :--- | :--- | :--- |
| **`LIKE`** | `WHERE Email LIKE '%.com'` | Pattern matching using `%` (multi-char) and `_` (single-char). |
| **`IN`** | `WHERE Region IN ('North', 'West')` | Filters against a explicit set or subquery list. |
| **`BETWEEN`** | `WHERE Date BETWEEN '2026-10-01' AND '2026-10-03'` | Inclusive range filter for dates or numbers. |
| **`ESCAPE`** | `WHERE Email LIKE '%\_%' ESCAPE '\'` | Treats wildcard characters (`_`, `%`) as literal strings. |
| **`<>` / `!=`** | `WHERE Status <> 'Inactive'` | Evaluates non-equality conditions. |

---

## 📂 Deliverables & File Index
- `scripts/01_day_08_foundations.sql`: Full DDL and query solution scripts for Day 8 challenge blocks.
- `data/raw_transactions.sql`: Database schema creation and insert statements for `Fact_Transactions`.
