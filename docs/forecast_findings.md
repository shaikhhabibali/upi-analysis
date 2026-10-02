# Forecast Findings

## Final Model

The final forecasting model is Holt-Winters Exponential Smoothing with additive trend and additive 12-month seasonality.

The model was fitted on the complete UPI monthly transaction-volume dataset covering April 2021 to September 2026.

## Forecast Period

The forecast covers October 2026 to March 2027.

## Forecast Summary

- Average forecast volume: 25,725 million transactions.
- October 2026 forecast: 25,261 million transactions.
- March 2027 forecast: 26,889 million transactions.
- Forecast change from October 2026 to March 2027: +6.4%.

## Prediction Interval

A 95% prediction interval was estimated using repeated simulation from the fitted Holt-Winters model.

## Model Selection Context

Holt-Winters was selected after comparison with the Seasonal Naive baseline and Trend + Seasonal Regression model using walk-forward backtesting and a final untouched six-month holdout evaluation.

## Output Files

- `images/09_upi_forecast.png`
- `dashboard/charts/09_upi_forecast.html`
- `data/clean/upi_forecast.csv`
