\# Day 13: Analytical Window Functions \& Window Framing



\## 📌 Daily Overview

\- \*\*Focus Area:\*\* T-SQL Analytical Window Functions (`OVER()`), Ranking Functions (`ROW\_NUMBER`, `RANK`, `DENSE\_RANK`, `NTILE`), Value Functions (`LAG`, `LEAD`), and Frame Specifications (`ROWS BETWEEN`).

\- \*\*Time Invested:\*\* 10 Hours

\- \*\*Core Objective:\*\* Calculate MoM growth rates, running YTD revenue totals, rolling 3-month moving averages, and row-level percentage contributions without losing record granularity through `GROUP BY`.



\---



\## 🛠️ T-SQL Window Function Syntax \& Mechanics



$$\\text{FUNCTION()} \\text{ OVER (} \[\\text{PARTITION BY } \\text{col}] \\text{ ORDER BY } \\text{col} \[\\text{ ROWS BETWEEN ...}] \\text{)}$$



| Function / Frame | Syntax Example | Technical Purpose |

| :--- | :--- | :--- |

| \*\*`ROW\_NUMBER()`\*\* | `ROW\_NUMBER() OVER(PARTITION BY Sales\_Rep ORDER BY Revenue DESC)` | Assigns unique sequential integers; breaks ties arbitrarily. |

| \*\*`RANK()`\*\* | `RANK() OVER(ORDER BY Revenue DESC)` | Assigns ranks with gaps on tied values (e.g., 1, 1, 3). |

| \*\*`DENSE\_RANK()`\*\* | `DENSE\_RANK() OVER(ORDER BY Revenue DESC)` | Assigns ranks without gaps on tied values (e.g., 1, 1, 2). |

| \*\*`NTILE()` + `CASE`\*\* | `CASE WHEN NTILE(3) OVER(...) = 1 THEN 'High' ... END` | Bucketizes rows into equal partitions and maps to qualitative labels. |

| \*\*`LAG()`\*\* | `LAG(Revenue, 1) OVER(PARTITION BY Sales\_Rep ORDER BY Month)` | Pulls values from the previous row within a partition. |

| \*\*`LEAD()`\*\* | `LEAD(Revenue, 1) OVER(PARTITION BY Sales\_Rep ORDER BY Month)` | Pulls values from the subsequent row within a partition. |

| \*\*Running Total\*\* | `SUM(Revenue) OVER(ORDER BY Month ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)` | Calculates cumulative sums row-by-row. |

| \*\*Rolling Average\*\* | `AVG(Revenue) OVER(ORDER BY Month ROWS BETWEEN 2 PRECEDING AND CURRENT ROW)` | Computes moving averages across fixed frames. |



\---



\## 📂 Deliverables \& File Index

\- `scripts/01\_day\_13\_window\_functions.sql`: Complete T-SQL query solutions for all Day 13 challenge blocks.

\- `data/raw\_monthly\_sales\_ledger.sql`: Database table creation DDL and seed dataset (`Fact\_Monthly\_Sales\_Ledger`).

