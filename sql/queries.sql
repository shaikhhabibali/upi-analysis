-- ============================================================
-- UPI SQL ANALYSIS QUERIES
-- These queries answer key business questions about UPI growth.
-- ============================================================


-- ============================================================
-- Query 1: Financial Year Summary
-- Business question:
-- How large is UPI each financial year?
-- ============================================================

-- name: fy_summary

SELECT
    financial_year,
    COUNT(*) AS months,

    ROUND(
        SUM(volume_mn) / 1000.0,
        1
    ) AS volume_bn,

    ROUND(
        SUM(value_cr) / 100000.0,
        1
    ) AS value_lakh_cr,

    ROUND(
        SUM(value_cr) * 10.0 / SUM(volume_mn),
        0
    ) AS avg_ticket_rs

FROM upi_monthly

GROUP BY financial_year

ORDER BY financial_year;


-- ============================================================
-- Query 2: Like-for-Like H1 Comparison
-- Business question:
-- How did Apr-Sep UPI growth change across financial years?
-- ============================================================

-- name: like_for_like_h1

WITH h1 AS (

    SELECT
        financial_year,
        SUM(volume_mn) AS vol,
        SUM(value_cr) AS val

    FROM upi_monthly

    WHERE month_number IN (4, 5, 6, 7, 8, 9)

    GROUP BY financial_year
)

SELECT
    financial_year,

    ROUND(
        vol / 1000.0,
        1
    ) AS volume_bn,

    ROUND(
        (
            vol - LAG(vol) OVER (
                ORDER BY financial_year
            )
        ) * 100.0
        / LAG(vol) OVER (
            ORDER BY financial_year
        ),
        1
    ) AS volume_yoy_pct,

    ROUND(
        (
            val - LAG(val) OVER (
                ORDER BY financial_year
            )
        ) * 100.0
        / LAG(val) OVER (
            ORDER BY financial_year
        ),
        1
    ) AS value_yoy_pct

FROM h1

ORDER BY financial_year;


-- ============================================================
-- Query 3: Top Growth Months
-- Business question:
-- Which months experienced the strongest daily transaction growth?
-- Daily averages are used so different month lengths do not distort
-- the comparison.
-- ============================================================

-- name: top_growth_months

WITH d AS (

    SELECT
        month,
        date,
        avg_daily_volume_mn,

        (
            avg_daily_volume_mn * 1.0
            / LAG(avg_daily_volume_mn) OVER (
                ORDER BY date
            ) - 1
        ) * 100 AS daily_mom_pct

    FROM upi_monthly
)

SELECT
    month,

    ROUND(
        daily_mom_pct,
        1
    ) AS daily_mom_pct,

    RANK() OVER (
        ORDER BY daily_mom_pct DESC
    ) AS rnk

FROM d

WHERE daily_mom_pct IS NOT NULL

ORDER BY daily_mom_pct DESC

LIMIT 5;


-- ============================================================
-- Query 4: Festive vs Other Months
-- Business question:
-- Do October-November months show different growth patterns?
-- ============================================================

-- name: festive_vs_other

WITH d AS (

    SELECT
        month_number,

        (
            avg_daily_volume_mn * 1.0
            / LAG(avg_daily_volume_mn) OVER (
                ORDER BY date
            ) - 1
        ) * 100 AS daily_mom_pct

    FROM upi_monthly
)

SELECT

    CASE
        WHEN month_number IN (10, 11)
            THEN 'Festive (Oct-Nov)'
        ELSE 'Other months'
    END AS period,

    COUNT(*) AS months,

    ROUND(
        AVG(daily_mom_pct),
        2
    ) AS avg_daily_mom_pct

FROM d

WHERE daily_mom_pct IS NOT NULL

GROUP BY period;