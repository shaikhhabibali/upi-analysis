-- Create the main monthly UPI table for SQL analysis

DROP TABLE IF EXISTS upi_monthly;

CREATE TABLE upi_monthly (
    date                  TEXT PRIMARY KEY,
    month                 TEXT NOT NULL,
    financial_year        TEXT NOT NULL,
    month_number          INTEGER NOT NULL,
    month_name            TEXT NOT NULL,
    banks_live             INTEGER,
    volume_mn              REAL NOT NULL,
    value_cr               REAL NOT NULL,
    avg_ticket_size        REAL,
    days_in_month          INTEGER,
    avg_daily_volume_mn    REAL,
    avg_daily_value_cr     REAL,
    mom_growth_pct         REAL,
    yoy_growth_pct         REAL,
    value_mom_growth_pct   REAL,
    value_yoy_growth_pct   REAL,
    fy_months_available    INTEGER,
    source_file            TEXT
);