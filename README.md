# Data-Analytics-90Days
# Day 1: Advanced Lookups, Logical Formulas & Business Math

## 📌 Daily Overview
- **Focus Area:** Excel Data Transformation & Descriptive Statistics
- **Time Invested:** 10 Hours
- **Core Objective:** Transition from basic table lookups to robust cross-table data ingestion and business statistical analysis.

---

## 🛠️ Key Technical Formulas Mastered

### 1. Robust Lookups & Cleansing
- **XLOOKUP with TRIM:** Handled leading/trailing whitespaces in raw customer IDs that caused standard lookup failures.

  excel = XLOOKUP(TRIM(Lookup_Value), Lookup_Array, Return_Array, "Not Found")
  
  Two-Way Indexing: Used INDEX + MATCH for dynamic unordered lookups to avoid hardcoding column index numbers.
  
###  2. Multi-Criteria Business Logic
- **Nested Logical Overrides:** Built combined conditional statements using IF(OR(AND(...), AND(...))) to determine tiered discount eligibility based on customer segment and sales thresholds.
##  📊 Business Math & Statistical Insights
  Analyzed daily revenue performance across two retail locations (Store A vs. Store B) to evaluate central tendency and operational risk:
### Store A

- **Mean**	$17,214.29

- **Median**	$12,900.00

- **Std Deviation**	$12,284.19

- **Skewness**	2.41 (Positive)


### Store B

- **Mean**	$4,714.29

- **Median**	$4,700.00

- **Std Deviation**	$241.03

- **Skewness**	0.34 (Symmetrical)

## Business Takeaway

- Store A's mean is heavily distorted upward by a single spike.

- Median provides a realistic baseline for Store A's daily performance.

- Store A displays severe volatility compared to Store B's steady model.

- Store A has a heavy right tail (infrequent massive promo days).


## Key Business Takeaway:


- When evaluating volatile performance metrics, never rely solely on the Mean. Standard deviation and skewness reveal underlying operational risks that single averages obscure.


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


# Day 3: Text Manipulation, Unstructured String Sanitization & E-Commerce Metrics

## 📌 Daily Overview
- **Focus Area:** Classic String Parsing (`LEFT`, `RIGHT`, `MID`, `FIND`, `SEARCH`, `SUBSTITUTE`, `TRIM`, `LEN`) for Excel 2016.
- **Time Invested:** 10 Hours
- **Core Objective:** Clean messy customer system logs, parse delimited SKUs and email domains, and compute clean conversion metrics from unformatted transactional text.

---

## 🛠️ Text Formula Reference Sheet (Excel 2016 Syntax)

| Parsing Objective | Formula Combination | Purpose / Notes |
| :--- | :--- | :--- |
| **Clean Whitespace** | `=TRIM(B2)` | Removes leading, trailing, and duplicate mid-string spaces. |
| **Extract Email User** | `=LEFT(C2, FIND(" ", C2) - 1)` | Extracts text prior to space/bracket delimiters. |
| **Extract Email Domain** | `=MID(G2, FIND("@", G2) + 1, LEN(G2) - FIND("@", G2))` | Dynamically extracts domain after `@` symbol. |
| **Parse Delimited Substring** | `=MID(D2, 5, 3)` | Extracts fixed-width internal codes (e.g., Category). |
| **Replace Characters** | `=SUBSTITUTE(SUBSTITUTE(E2, " / ", "-"), " ", "")` | Normalizes delimiters and strips illegal characters. |
| **Clean Currency Strings** | `=VALUE(SUBSTITUTE(SUBSTITUTE(C2, "$", ""), " USD", ""))` | Converts formatted text numbers (`"$1,250.00 USD"`) into raw integers. |

---

## 📊 E-Commerce Performance Metrics (Block 3 Insights)

Calculated key conversion and cart abandonment figures after sanitizing raw transaction streams:

- **Average Order Value (AOV):** Computed for all converted sales using `=AVERAGEIF(Status, "Converted", Clean_Numeric_Value)`.
- **Enterprise Conversion Rate:** Computed using `=COUNTIFS(Segment, "Enterprise_Tier", Status, "Converted") / COUNTIF(Segment, "Enterprise_Tier")`.
- **Abandoned Revenue Loss:** Measured total cart loss across unfulfilled sessions via `=SUMIF(Status, "Abandoned", Clean_Numeric_Value)`.

---

## 📂 Deliverables & File Index
- `Day_03_Worksheet.xlsx`: Complete workbook containing text parsing and financial cleaning solutions.
