## Credit Risk Customer Analytics

## Project Overview

This project performs an end-to-end exploratory credit risk analysis by transforming transaction-level customer data into customer-level financial profiles.

The analysis uses **SQL and Python** to examine customer financial characteristics, transaction behaviour, debt burden, and credit quality. It further develops project-defined customer risk segments and two composite risk-scoring approaches to prioritize customers based on their relative financial risk.

The project focuses on analytical exploration and internal consistency rather than predicting actual defaults or credit losses.

---

## Business Objectives

The key objectives of this project were to:

- Transform transaction-level data into a customer-level analytical dataset.
- Analyse customer credit scores, debt levels, income, and debt-to-income ratios.
- Examine relationships between key financial variables.
- Identify customers with relatively elevated financial risk.
- Segment customers into Standard, Elevated, and High-Risk groups using rule-based criteria.
- Analyse transaction behaviour across different risk segments.
- Detect unusually high DTI values using the IQR method.
- Develop a transparent bucket-based composite risk score.
- Create a continuous risk score to provide greater customer-ranking granularity.
- Compare and validate consistency across the project-defined risk frameworks.

---

 ## Tools & Technologies

- **SQL** – Data extraction, aggregation, and validation
- **Python**
- **Pandas** – Data manipulation and feature engineering
- **NumPy** – Numerical calculations
- **Matplotlib** – Data visualization
- **Seaborn** – Statistical visualization
- **Jupyter Notebook / Google Colab** – Analysis environment

---

 Dataset

The analysis begins with a transaction-level dataset containing approximately **20,000 transactions** across **4,941 customers**.

The dataset includes customer and transaction-related information such as:

- Client ID
- Transaction ID
- Transaction date
- Credit score
- Yearly income
- Total debt
- Transaction amount

Additional customer-level variables were engineered during the analysis.

> **Note:** The raw dataset is not included in this repository. The analysis is intended to demonstrate the SQL and Python workflow used for customer-level financial profiling and exploratory risk analysis.

---

## Project Workflow

```text
Transaction-Level Data
        │
        ▼
Data Preparation & Quality Checks
        │
        ▼
Customer-Level Feature Engineering
        │
        ▼
SQL vs Python Validation
        │
        ▼
Exploratory Data Analysis
        │
        ▼
Customer Risk Segmentation
        │
        ▼
DTI Outlier & Transaction Analysis
        │
        ▼
Composite Risk Scoring
        │
        ▼
Business Insights & Recommendations


 Key Analysis Performed
 1. Data Preparation & Quality Checks

 The dataset was inspected for:

Missing values
Duplicate records
Unique customers
Unique transactions
Data types
Date ranges

The transaction date was converted into a datetime format, and additional date-related features were created, including:

Year
Month
Month name
Day of week
2. Customer-Level Feature Engineering

Transaction-level data was aggregated to create a customer-level analytical dataset.

Key engineered features include:

Total spending
Total transactions
Average transaction amount
Transaction amount standard deviation
Debt-to-income ratio (DTI)
Credit score groups

This process resulted in a customer-level dataset containing 4,941 customers and 10 analytical features.

3. Validation Against SQL Results

SQL and Python outputs were compared to validate consistency between the two analytical workflows.

The validation included comparisons such as:

Customer counts by credit group
Average DTI by credit group
Average total debt by credit group

This helped ensure that the customer-level calculations produced in Python aligned with the SQL analysis.

4. Exploratory Data Analysis

The analysis examined:

Credit score distribution
Customer income distribution
Total debt distribution
Debt-to-income ratios
Spending patterns
Transaction frequency
Transaction amount variability
Relationships between key financial variables

A correlation analysis found a moderate negative relationship between credit score and DTI, with a correlation of approximately -0.25.

This suggests that customers with higher debt burdens tend to have lower credit scores, although DTI alone does not explain overall credit score variation.

5. Customer Risk Segmentation

Customers were classified into three project-defined risk segments:

Risk Segment	Criteria
High Risk	Credit score < 650 and DTI ≥ 50%
Elevated Risk	Credit score < 650 or DTI ≥ 50%, excluding High-Risk customers
Standard Risk	Customers not meeting the above conditions

The resulting distribution was:

Risk Segment	Customers
Standard Risk	3,497
Elevated Risk	1,298
High Risk	146

The risk segments showed meaningful differences in financial characteristics.

High-Risk customers had:

Lower average credit scores
Higher average DTI
Higher average debt levels

However, spending and transaction frequency were relatively similar across the segments.

6. DTI Outlier Detection

The Interquartile Range (IQR) method was used to identify customers with unusually high DTI values.

The analysis calculated:

First quartile (Q1)
Third quartile (Q3)
Interquartile Range (IQR)
Upper outlier threshold

Customers exceeding the threshold were identified as potential candidates for further financial review.

7. Transaction Patterns & Large Transaction Analysis

Transaction behaviour was analysed across customer risk segments.

The analysis included:

Monthly transaction trends
Correlation between financial and transaction variables
Large transaction identification
Customer-level large transaction rates
Segment-level large transaction rates

Large transaction rates were broadly similar across the three risk segments, ranging from approximately 3.0% to 3.4%.

This suggests that unusually large transactions, based on the project-defined threshold, were not strongly concentrated within a particular financial-risk segment.

Composite Risk Scoring Framework

A transparent composite risk score was developed using three financial indicators:

Risk Component	Weight
Credit Score	40%
Debt-to-Income Ratio	40%
Total Debt	20%

The maximum possible risk score was 100.

The weighting structure gives greater importance to:

Credit quality
Relative debt burden

while incorporating absolute debt exposure as an additional risk dimension.

Bucket-Based Risk Score

The initial scoring approach assigns discrete risk points based on project-defined thresholds.

Customers were subsequently grouped into four score bands:

Score Band	Risk Score
Low	0–39
Moderate	40–59
Moderate-High	60–79
High	80–100

The bucket-based framework is transparent and easy to interpret but provides limited ranking granularity because multiple customers can receive the same score.

Continuous Risk Score

A continuous risk score was developed to provide more granular customer ranking.

The methodology:

Inverts credit score so that lower credit scores correspond to higher risk.
Normalizes DTI, where higher values correspond to higher risk.
Normalizes total debt, where higher values correspond to higher risk.
Retains the same 40% / 40% / 20% weighting structure.

The continuous score enables more precise differentiation between customers who may receive the same bucket-based risk score.

Risk Score Consistency

The bucket-based and continuous scoring approaches showed a strong positive correlation of approximately:

0.95

This indicates strong internal consistency between the two project-defined scoring frameworks.

However, this should not be interpreted as predictive validation. Actual delinquency, default, or credit-loss outcomes would be required to evaluate the ability of either model to predict real-world credit risk.

Key Findings
Credit score and DTI have a moderate negative relationship, with a correlation of approximately -0.25.
Total debt and DTI are positively related, indicating that customers with greater debt burdens generally have higher debt-to-income ratios.
High-Risk customers have the lowest average credit scores and highest average DTI and debt levels.
Spending and transaction frequency are relatively similar across risk segments, suggesting that transaction activity alone may not strongly differentiate the project-defined financial-risk profiles.
Large transaction rates are broadly similar across risk segments, ranging from approximately 3.0% to 3.4%.
A small group of customers displays significantly elevated DTI values, making them potential candidates for additional review.
The bucket-based composite score is interpretable but has limited granularity.
The continuous risk score provides more precise customer ranking while maintaining strong alignment with the bucket-based approach.
The two scoring approaches have a correlation of approximately 0.95, demonstrating strong internal consistency.
Both scoring approaches preserve the expected risk hierarchy, with High-Risk customers receiving higher average risk scores than Elevated-Risk and Standard-Risk customers.
Business Recommendations
Prioritize High-DTI and Low-Credit-Score Customers

Customers displaying both elevated DTI and relatively low credit scores can be prioritized for additional review.

Use Risk Scores for Prioritization

The composite risk score can serve as an analytical prioritization mechanism rather than an automated credit-decision system.

Use Continuous Scores for Ranking

The continuous scoring approach provides greater differentiation between customers with similar bucket-based scores.

Monitor Customers with Unusually High DTI

Customers with exceptionally high DTI values may warrant closer monitoring, particularly when combined with weak credit quality or high absolute debt levels.

Incorporate Additional Risk Variables

The framework could be improved by including variables such as:

Repayment history
Delinquencies
Defaults
Credit utilization
Account tenure
Historical changes in financial behaviour
Validate Against Actual Outcomes

Before real-world deployment, the framework should be evaluated against historical outcomes such as:

Delinquency
Default
Credit loss

This would allow the predictive performance of the framework to be assessed.

Limitations

This project has several limitations:

The dataset does not contain actual default, delinquency, repayment, or credit-loss outcomes.
The risk segments and composite scores are exploratory frameworks created specifically for this project.
The selected thresholds and weights are rule-based assumptions and have not been statistically optimized.
The continuous score uses min-max normalization and may be influenced by extreme values.
The analysis identifies relative financial-risk patterns and does not establish causation.
The scoring framework should not be interpreted as a production-ready credit risk model.

Conclusion

This project demonstrates an end-to-end analytical workflow using SQL and Python to transform transaction-level data into customer-level financial profiles.

The analysis combines:

Data quality checks
Feature engineering
SQL validation
Exploratory data analysis
Customer risk segmentation
DTI outlier detection
Transaction behaviour analysis
Composite risk scoring

The results demonstrate how financial and transactional data can be used to support structured customer profiling and risk prioritization.

While the project develops internally consistent analytical risk frameworks, actual customer performance outcomes would be required to validate their predictive effectiveness.
