# Day 10: Multi-Table Joins, ERD Design & Relational Schema

## 📌 Daily Overview
- **Focus Area:** Relational Data Modeling (1NF–3NF Normalization), Primary Keys (PK) vs. Foreign Keys (FK), Multi-Table `INNER JOIN`, `LEFT JOIN`, `RIGHT JOIN`, and `FULL OUTER JOIN` operations in T-SQL.
- **Time Invested:** 10 Hours
- **Core Objective:** Establish relational integrity across 3 schema entities (`Dim_Customers`, `Dim_Products`, `Fact_Orders`), query cross-table profitability metrics, and perform retention audits on unlinked dimension records.

---

## 📐 Relational Schema Architecture (Star Schema)
text
[Dim_Customers]                  [Dim_Products]
Customer_ID (PK) ──┐        ┌── Product_ID (PK)
│        │
▼        ▼
[Fact_Orders]
Customer_ID (FK)
Product_ID (FK)
Order_Quantity
Selling_Price

---

## 🛠️ T-SQL Join Mechanics Reference Sheet

| Join Type | Syntax Pattern | Use Case |
| :--- | :--- | :--- |
| **`INNER JOIN`** | `FROM Fact_Orders o JOIN Dim_Customers c ON o.Customer_ID = c.Customer_ID` | Returns only records where matching foreign keys exist in both tables. |
| **`LEFT JOIN`** | `FROM Dim_Customers c LEFT JOIN Fact_Orders o ON c.Customer_ID = o.Customer_ID` | Preserves all primary rows from the left table; populates `NULL` for unmatched right records. |
| **Unlinked Audit** | `WHERE Fact_Orders.Order_ID IS NULL` | Paired with `LEFT JOIN` to identify inactive accounts or unsold product inventory. |

---

## 📂 Deliverables & File Index
- `scripts/01_day_10_joins_and_schema.sql`: T-SQL query solutions for all Day 10 challenge blocks.
- `data/raw_schema_seed.sql`: Database table creation DDL, PK/FK constraints, and relational seed data.
