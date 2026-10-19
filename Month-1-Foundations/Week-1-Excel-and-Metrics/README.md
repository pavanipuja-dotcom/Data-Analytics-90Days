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


# Day 4: Power Query ETL, Data Ingestion & Structural Transformations

## 📌 Daily Overview
- **Focus Area:** Repeatable ETL Pipelines, M-Code Basics, Delimited Text Splitting, Column Unpivoting, Data Type Enforcement, and YoY Growth Metrics.
- **Time Invested:** 10 Hours
- **Core Objective:** Automate multi-file data ingestion and unpivot wide transactional data matrices into narrow, normalized tables loaded into the Excel Data Model.

---

## 🛠️ Power Query Transformation Steps & Mechanics

| Transformation Step | M-Code Function / UI Tool | Purpose / Technical Outcome |
| :--- | :--- | :--- |
| **Delimited Split** | `Table.SplitColumn(..., Splitter.SplitTextByDelimiter("("))` | Separates complex composite strings (e.g., Customer Name and Location Code). |
| **Text Sanitization** | `Text.Trim`, `Text.Proper`, `Text.Replace` | Strips whitespace, standardizes casing, and removes closing parentheses. |
| **Unpivot Columns** | `Table.UnpivotOtherColumns(...)` | Converts wide multi-year columns (`Sales_2024`, `Sales_2025`, `Sales_2026`) into normalized attribute-value pairs. |
| **Null Handling** | `Table.ReplaceValue(..., "null", "0", ...)` | Standardizes missing data or empty strings before numeric formatting. |
| **Type Enforcement** | `Table.TransformColumnTypes(..., {{"Amount", Currency.Type}})` | Enforces strict schema typing prior to loading to the Data Model. |

---

## 💻 Complete Power Query M-Code Script (Block 2 Pipeline)
powerquery
let
Source = Csv.Document(File.Contents("raw_regional_sales_b2.csv"),[Delimiter=",", Columns=8, Encoding=1252, QuoteStyle=QuoteStyle.None]),
#"Promoted Headers" = Table.PromoteHeaders(Source, [PromoteAllScalars=true]),
#"Split Manager" = Table.SplitColumn(#"Promoted Headers", "Region_Manager", Splitter.SplitTextByDelimiter(" (", QuoteStyle.Csv), {"Manager_Name", "Region"}),
#"Cleaned Manager" = Table.TransformColumns(#"Split Manager", {{"Manager_Name", Text.Trim, type text}, {"Manager_Name", Text.Proper, type text}, {"Region", each Text.Replace(, ")", ""), type text}}),
#"Unpivoted Years" = Table.UnpivotOtherColumns(#"Cleaned Manager", {"Store_ID", "Manager_Name", "Region", "Month_Year", "Category_Raw", "Status_Code"}, "Attribute", "Value"),
#"Renamed Unpivoted" = Table.RenameColumns(#"Unpivoted Years",{{"Attribute", "Report_Year"}, {"Value", "Revenue_Amount"}}),
#"Cleaned Year Code" = Table.TransformColumns(#"Renamed Unpivoted", {{"Report_Year", each Text.AfterDelimiter(, "_"), type text}}),
#"Replaced Null Revenue" = Table.ReplaceValue(#"Cleaned Year Code","null","0",Replacer.ReplaceText,{"Revenue_Amount"}),
#"Cleaned Currency Symbols" = Table.ReplaceValue(Table.ReplaceValue(#"Replaced Null Revenue","$","",Replacer.ReplaceText,{"Revenue_Amount"}),",","",Replacer.ReplaceText,{"Revenue_Amount"}),
#"Enforced Types" = Table.TransformColumnTypes(#"Cleaned Currency Symbols",{{"Revenue_Amount", Currency.Type}, {"Report_Year", Int64.Type}})
in
#"Enforced Types"

---

## 📊 Revenue Growth Metrics (Block 3 Insights)

Applied on transformed outputs loaded into Excel:

- **Year-over-Year (YoY) Growth % (2025 vs 2026):**
  $$\text{YoY Growth \%} = \frac{\text{Sales}_{2026} - \text{Sales}_{2025}}{\text{Sales}_{2025}}$$
- **Compound Annual Growth Rate (CAGR, 2024 to 2026):**
  $$\text{CAGR} = \left(\frac{\text{Sales}_{2026}}{\text{Sales}_{2024}}\right)^{\frac{1}{2}} - 1$$

---

## 📂 Deliverables & File Index
- `Day_04_Worksheet.xlsx`: Complete Excel workbook with Power Query connection queries and data model tables.
- `data/`: Raw CSV input files for order logs and regional sales matrices.


# Day 5: Pivot Tables, Data Modeling & Customer Retention Analytics

## 📌 Daily Overview
- **Focus Area:** Pivot Cache Optimization, Star Schema Data Modeling (Fact vs. Dimensions), Multi-Table Relationships, DAX Measures, and Cohort Churn Modeling.
- **Time Invested:** 10 Hours
- **Core Objective:** Build a relational Star Schema model inside the Excel Data Model (Power Pivot) without traditional VLOOKUP formulas, construct cross-filtering slicer controls, and analyze customer churn and margin dynamics.

---

## 📐 Star Schema Architecture & Relationships

2.Write Technical Documentation:README.md Setup.Create a README.md file inside Month-01-Foundations/01-Excel-and-Business-Math/Day-05-Pivot-Tables-and-Data-Modeling/. Copy and populate the template below:Markdown# Day 5: Pivot Tables, Data Modeling & Customer Retention Analytics

## 📌 Daily Overview
- **Focus Area:** Pivot Cache Optimization, Star Schema Data Modeling (Fact vs. Dimensions), Multi-Table Relationships, DAX Measures, and Cohort Churn Modeling.
- **Time Invested:** 10 Hours
- **Core Objective:** Build a relational Star Schema model inside the Excel Data Model (Power Pivot) without traditional VLOOKUP formulas, construct cross-filtering slicer controls, and analyze customer churn and margin dynamics.

---

## 📐 Star Schema Architecture & Relationships

text[Dim_Customers]                  [Dim_Products]Customer_ID (PK) ──┐        ┌── Product_ID (PK)│        │▼        ▼[Fact_Orders]Customer_ID (FK)Product_ID (FK)Sales_Amount

- **`Fact_Orders[Customer_ID]` $\rightarrow$ `Dim_Customers[Customer_ID]`** (Many-to-One)
- **`Fact_Orders[Product_ID]` $\rightarrow$ `Dim_Products[Product_ID]`** (Many-to-One)

---

## 🛠️ Data Model Measures & DAX Expressions

| Calculation Name | Code / Expression | Purpose |
| :--- | :--- | :--- |
| **`Total_Cost` (Column)** | `= Fact_Orders[Units_Sold] * RELATED(Dim_Products[Unit_Cost])` | Calculated column fetching unit cost across relationships. |
| **`Gross_Margin` (Column)** | `= Fact_Orders[Sales_Amount] - Fact_Orders[Total_Cost]` | Determines net transaction margin. |
| **`Active_July_Customers`** | `CALCULATE(DISTINCTCOUNT(Fact_Orders[Customer_ID]), FILTER(Fact_Orders, MONTH(Fact_Orders[Order_Date]) = 7))` | Counts unique active July buyers (`2`). |
| **`Retained_August_Customers`** | `CALCULATETABLE(...)` / `INTERSECT(...)` | Measures July buyers who returned in August (`1`). |
| **`August_Churn_Rate`** | `= (July_Active - August_Retained) / July_Active` | Calculates monthly customer churn rate (**`50.00%`**). |

---

## 📊 Regional Performance & Financial Summary

| Region | Total Revenue | Unit Cost | Gross Profit |
| :--- | :--- | :--- | :--- |
| **North** | `$2,390` | `$900` | **`$1,490`** |
| **South** | `$1,650` | `$300` | **`$1,350`** |
| **East** | `$1,500` | `$450` | **`$1,050`** |
| **West** | `$1,800` | `$400` | **`$1,400`** |

---

## 📂 Deliverables & File Index
- `Day_05_Worksheet.xlsx`: Complete workbook with Power Pivot Star Schema model, DAX measures, and interactive Slicers.
- `data/`: Raw CSV files for `Fact_Orders`, `Dim_Customers`, and `Dim_Products`.
