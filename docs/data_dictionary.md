# UPI Data Dictionary

This data dictionary describes the cleaned monthly UPI dataset used in the project.

## Data Coverage

- Source: NPCI UPI Product Statistics
- Frequency: Monthly
- Period: April 2021 to September 2026
- Total observations: 66 months
- Financial years FY 2021-22 to FY 2025-26 contain 12 months each.
- FY 2026-27 currently contains 6 months (April 2026 to September 2026).
- Data download date: 02 October 2026

## Columns

| Column | Description | Unit |
|---|---|---|
| month | Original month label from NPCI | Month-Year |
| banks_live | Number of banks live on UPI during the month | Count |
| volume_mn | Total UPI transaction volume | Million transactions |
| value_cr | Total UPI transaction value | ₹ Crore |
| source_file | Original NPCI source Excel file | File name |
| date | Parsed date used for time-series analysis | Date |
| financial_year | Indian financial year associated with the month | FY |
| month_number | Numeric calendar month | 1-12 |
| month_name | Calendar month name | Month |
| avg_ticket_size | Average value per UPI transaction | ₹ per transaction |
| mom_growth_pct | Month-over-Month growth in transaction volume | Percentage |
| yoy_growth_pct | Year-over-Year growth in transaction volume | Percentage |
| value_mom_growth_pct | Month-over-Month growth in transaction value | Percentage |
| value_yoy_growth_pct | Year-over-Year growth in transaction value | Percentage |
| days_in_month | Number of calendar days in the month | Days |
| avg_daily_volume_mn | Average daily UPI transaction volume | Million transactions/day |
| avg_daily_value_cr | Average daily UPI transaction value | ₹ Crore/day |
| fy_months_available | Number of monthly observations currently available for the financial year | Months |