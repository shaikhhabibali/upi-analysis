# Forecast Findings

## Final Forecasting Approach

The final forecasting model uses Holt-Winters Exponential Smoothing with:

- Additive trend
- Additive 12-month seasonality
- Average daily UPI transaction volume as the forecasting target
- Calendar-aware conversion from daily volume to monthly transaction volume

The model was fitted on all 66 monthly observations from April 2021 to September 2026.

## Forecast Period

October 2026 to March 2027.

## Forecast Summary

- Average forecast volume: 25,508 million transactions.
- October 2026 forecast: 25,324 million transactions.
- March 2027 forecast: 27,067 million transactions.
- Forecast change from October 2026 to March 2027: +6.9%.

## Revised Model Evaluation

The forecasting workflow uses five models:

1. Last Value Repeat
2. Seasonal Naive
3. Growth-Adjusted Seasonal Naive
4. Holt-Winters
5. Trend + Seasonal Regression

The revised 19-fold walk-forward evaluation contains 114 out-of-sample observations.

Holt-Winters achieved a walk-forward MAPE of 1.56%.

On the final untouched six-month holdout, calendar-aware Holt-Winters achieved a MAPE of 0.92%.

The Growth-Adjusted Seasonal Naive baseline achieved a MAPE of 0.87% on the final holdout, so Holt-Winters is not described as the best-performing model on that particular six-month holdout.

## SARIMA Attempt

SARIMA was attempted during model development, but reliable convergence was not achieved. It was therefore excluded from the final model comparison.

## Prediction Interval Validation

The initial simulation-based interval showed 82.5% coverage across the 114 historical walk-forward observations.

A calibrated empirical interval was then created using horizon-specific historical Holt-Winters forecast errors.

Temporal validation of the calibrated intervals covered 54 out of 54 observations (100.0%).

These intervals should therefore be interpreted as empirically calibrated historical-error intervals rather than as a guarantee of exact theoretical 95% coverage.

## Output Files

- `images/09_upi_forecast.png`
- `dashboard/charts/09_upi_forecast.html`
- `data/clean/upi_forecast.csv`
- `data/clean/forecast_backtest_revised.csv`
- `data/clean/forecast_interval_widths.csv`
- `data/clean/prediction_interval_validation.csv`
