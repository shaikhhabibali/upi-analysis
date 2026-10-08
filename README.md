# UPI Digital Payments in India: Growth, Seasonality & Forecast

An end-to-end data analytics project analysing the growth, seasonality, transaction value, average ticket size, and future transaction volume of India's UPI ecosystem using official NPCI monthly data.

---

## Project Overview

This project analyses India's UPI transaction ecosystem from **April 2021 to September 2026**, covering **66 monthly observations**.

The workflow combines:

- Python for data cleaning, transformation, exploratory analysis and forecasting
- SQL for business-focused analysis
- Power BI for interactive dashboarding
- Git & GitHub for project version control and portfolio presentation

The project focuses on understanding how UPI transaction volume and value have evolved, how seasonality affects monthly activity, how average transaction size has changed, and what transaction volume may look like over the next six months.

---

## Business Questions

This project answers the following questions:

1. How has UPI transaction volume grown over time?
2. How has transaction value changed relative to transaction volume?
3. What seasonal patterns exist across financial years?
4. How has the average UPI transaction size changed?
5. Is transaction volume growing faster than transaction value?
6. Which forecasting approach performs best on historical out-of-sample data?
7. What is the projected UPI transaction volume for October 2026 to March 2027?

---

## Dataset

### Source

Official **NPCI UPI Product Statistics**

Source:

https://www.npci.org.in/product/upi/product-statistics

### Coverage

- Frequency: Monthly
- Period: April 2021 – September 2026
- Observations: 66
- Latest available month: September 2026

### Raw Variables

- Month
- Number of Banks Live on UPI
- Volume (Million Transactions)
- Value (Crore INR)

---

## Project Workflow

```text
Official NPCI Data
        ↓
Data Cleaning & Transformation
        ↓
SQL Business Analysis
        ↓
Exploratory Data Analysis
        ↓
Forecasting & Model Validation
        ↓
Power BI Dashboard
        ↓
Insights & Documentation
```

---

## Phase 1–2 — Data Cleaning & Transformation

The raw NPCI files were consolidated and transformed into a clean monthly analytical dataset.

Key transformations included:

- Standardised monthly dates
- Financial year creation
- Month number and month name
- Average ticket size
- Month-over-month growth
- Year-over-year growth
- Calendar-day adjustments
- Average daily transaction metrics
- Financial-year month availability checks

Final cleaned dataset:

`data/clean/upi_clean.csv`

---

## Phase 3 — SQL Analysis

SQL was used to answer business-focused questions including:

- Financial-year volume and value summaries
- Like-for-like H1 comparisons
- Highest-growth months
- Festive-period versus other-month comparisons

Key finding:

**FY 2026–27 H1 transaction volume grew approximately 23.2% compared with FY 2025–26 H1.**

---

## Phase 4 — Exploratory Data Analysis

EDA explored long-term growth, volume-value divergence, ticket size and seasonality.

### Key Findings

- UPI monthly transaction volume increased by approximately **9.1×** from April 2021 to September 2026.
- Transaction value increased by approximately **6.0×** over the same period.
- Average ticket size declined from approximately **₹1,869 to ₹1,220**, a decline of about **34.7%**.
- September 2026 volume YoY growth was approximately **22.6%**.
- March showed the strongest seasonal volume pattern, while April was the weakest.
- Transaction volume and transaction value diverged over time, with volume generally growing faster.

EDA visuals are available in:

`images/`

pp-level or user-level behaviour cannot be inferred:

`dashboard/charts/`

---

## Phase 5 — Forecasting

The forecasting target was changed from monthly transaction totals to **average daily transaction volume**, allowing calendar-aware monthly forecasting.

### Models Evaluated

1. Last Value Repeat
2. Seasonal Naive
3. Growth-Adjusted Seasonal Naive
4. Holt-Winters
5. Trend + Seasonal Regression

SARIMA was also attempted during development, but reliable convergence was not achieved, so it was excluded from the final comparison.

### Walk-Forward Validation

The revised evaluation used:

- 19 temporal folds
- 114 out-of-sample observations
- Six-month forecasting horizon
- Final holdout kept untouched during model selection

### Walk-Forward MAPE

| Model | MAPE |
|---|---:|
| Holt-Winters | 1.56% |
| Growth-Adjusted Seasonal Naive | 3.26% |
| Trend + Seasonal Regression | 5.64% |
| Last Value Repeat | 7.59% |
| Seasonal Naive | 26.45% |

Holt-Winters achieved the best performance in the revised walk-forward evaluation with a **1.56% MAPE**.

On the final untouched six-month holdout, calendar-aware Holt-Winters achieved a **0.92% MAPE**.

---

## Final Forecast

The final Holt-Winters model was fitted on all 66 historical observations.

### Forecast Horizon

**October 2026 – March 2027**

| Month | Forecast Volume |
|---|---:|
| October 2026 | 25,324 Mn |
| November 2026 | 24,609 Mn |
| December 2026 | 25,879 Mn |
| January 2027 | 26,052 Mn |
| February 2027 | 24,115 Mn |
| March 2027 | 27,067 Mn |

The average forecast volume is approximately **25,508 million transactions per month**.

Forecast volume increases by approximately **6.9%** from October 2026 to March 2027.

### Prediction Intervals

Prediction intervals were calibrated empirically using historical forecast errors by forecast horizon.

Temporal validation achieved **100% coverage across 54 validation observations**.

These intervals should be interpreted as empirically calibrated historical-error intervals rather than as a guarantee of exact theoretical 95% coverage.

---

## Power BI Dashboard

The final Power BI report contains **5 pages**:

### 1. Executive Overview

High-level KPIs, monthly transaction trend, dynamic metric selector and executive insights.

### 2. Growth & Seasonality

Volume-versus-value trends, YoY growth and financial-year seasonality heatmap.

### 3. Ticket Size Story

Average ticket-size trend, volume-value growth gap and financial-year comparison.

### 4. Forecast

Actual versus forecast volume, prediction intervals, model performance and forecast limitations.

### 5. Executive Dashboard

A single-screen executive landing dashboard combining the most important findings from the full analysis.

### Interactive Features

- Volume / Value metric toggle
- Dynamic chart title
- Financial-year filtering
- Synced filters across analytical pages
- Dynamic insight measures
- Forecast model comparison

---

## Key Project Insights

### Scale

UPI processed approximately **24.1 billion transactions in September 2026**, with transaction volume up approximately **22.6% YoY**.

### Growth

UPI transaction volume has expanded much faster than transaction value over the full study period.

### Ticket Size

Average payment size declined from approximately **₹1,869 to ₹1,220**, consistent with increasing use for smaller, everyday transactions.

### Seasonality

March records the strongest seasonal volume pattern, while April is the weakest.

### Forecast

The final calendar-aware model projects approximately **27.1 billion transactions in March 2027**.

### Model Performance

Holt-Winters achieved a **1.56% walk-forward MAPE** across 19 temporal folds.

---

## Project Structure

```text
upi-analysis/
│
├── data/
│   ├── raw/
│   └── clean/
│
├── notebooks/
│   ├── 01_cleaning.ipynb
│   ├── 02_sql_analysis.ipynb
│   ├── 03_eda.ipynb
│   └── 04_forecast.ipynb
│
├── sql/
│   ├── schema.sql
│   ├── queries.sql
│   └── import_mysql.py
│
├── dashboard/
│   └── charts/
│
├── images/
│
├── docs/
│   ├── data_dictionary.md
│   ├── key_findings.md
│   └── forecast_findings.md
│
├── requirements.txt
├── UPI_Digital_Payments_India.pbix
└── README.md
```

---

## Tools & Technologies

- Python
- Pandas
- NumPy
- Statsmodels
- SQL / MySQL
- Power BI
- DAX
- JupyterLab
- Git
- GitHub

---

## How to Run

### 1. Clone the repository

```bash
git clone https://github.com/shaikhhabibali/upi-analysis.git
cd upi-analysis
```

### 2. Create a virtual environment

```bash
python -m venv venv
```

### 3. Activate the environment

Windows PowerShell:

```powershell
.\venv\Scripts\Activate.ps1
```

### 4. Install dependencies

```bash
pip install -r requirements.txt
```

### 5. Launch JupyterLab

```bash
jupyter lab
```

Run the notebooks in order:

```text
01_cleaning.ipynb
02_sql_analysis.ipynb
03_eda.ipynb
04_forecast.ipynb
```

### Power BI

Open:

`UPI_Digital_Payments_India.pbix`

in Power BI Desktop.

---

## Limitations

- The dataset contains monthly aggregate UPI statistics rather than user-level transaction data.
- App-level or user-level behaviour cannot be inferred from the available dataset.
- The forecast is based on historical transaction patterns and may be affected by future structural, policy or market changes.
- Forecast intervals are empirically calibrated from historical errors.
- FY 2026–27 currently contains only April–September 2026 observations in the historical dataset.

---

## Status

**Completed — Phase 1 to Phase 6**

The project currently includes the complete analytics workflow, forecasting pipeline and interactive Power BI dashboard.

---

## Author

**Shaikh Habib Ali**

GitHub:

https://github.com/shaikhhabibali/upi-analysis

---

## License

This project is intended for educational, portfolio and analytical demonstration purposes.
