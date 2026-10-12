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
