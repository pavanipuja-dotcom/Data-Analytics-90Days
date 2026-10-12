# Day 2: Dynamic Arrays, Multi-Criteria Filtering & SaaS Metrics

## 📌 Daily Overview
- **Focus Area:** Dynamic Arrays (`FILTER`, `UNIQUE`, `SORT`) & Pre-2019 Legacy Equivalents (`INDEX-MATCH-SMALL`).
- **Time Invested:** 10 Hours
- **Core Objective:** Automate report generation using spilled arrays, understand backward compatibility for Excel 2016/older, and build SaaS financial models (CAC, LTV, MRR).

---

## 🛠️ Formula Syntax & Compatibility Matrix

| Goal | Modern Syntax (Excel 365 / 2021+) | Legacy Syntax (Excel 2016 & Older - `Ctrl+Shift+Enter`) |
| :--- | :--- | :--- |
| **Unique Active Regions** | `=UNIQUE(FILTER(D2:D13, F2:F13="Active"))` | `=IFERROR(INDEX($D$2:$D$13, MATCH(0, IF($F$2:$F$13="Active", COUNTIF($I$1:I1, $D$2:$D$13), 1), 0)), "")` |
| **Multi-Criteria Filter** | `=FILTER(A2:G13, ((C2:C13="Enterprise") + (C2:C13="Professional")) * (F2:F13="Active") * (E2:E13>=850))` | `=IFERROR(INDEX(A$2:A$13, SMALL(IF((($C$2:$C$13="Enterprise")+($C$2:$C$13="Professional"))*($F$2:$F$13="Active")*($E$2:$E$13>=850), ROW($A$2:$A$13)-ROW($A$2)+1), ROW(A1))), "")` |
| **Sorted Top Performers** | `=SORT(FILTER(A2:G13, F2:F13="Active"), 5, -1)` | Helper Column (`=IF(F2="Active", E2 + ROW()/100000, 0)`) + `=LARGE()` / `=MATCH()` |
| **Spilled Aggregation** | `=SUMIFS(E2:E13, C2:C13, K2#)` | `=SUMIFS($E$2:$E$13, $C$2:$C$13, K2)` *(dragged down explicitly)* |

---

## 📈 SaaS Unit Economics & Metrics Summary

Modeled key subscription performance drivers across 12 account logs:

- **Monthly Recurring Revenue (MRR):** Total active subscription value calculated using `=SUMIF(Status, "Active", MRR_Amount)`.
- **Customer Acquisition Cost (CAC):** Total sales and marketing expenditures divided by newly onboarded customer accounts.
- **Customer Lifetime Value (LTV):** Computed as $\text{ARPA} \times \text{Average Lifespan (Months)}$.
  - **ARPA Formula:** `=AVERAGEIF(Status_Range, "Active", MRR_Amount)`
  - **Lifespan Formula:** `=AVERAGEIF(Status_Range, "Cancelled", Contract_Months)`

---

## 📂 Deliverables & File Index
- `Day_02_Worksheet.xlsx`: Workbook containing Task 1–5 solutions (both dynamic array and legacy CSE implementations).

