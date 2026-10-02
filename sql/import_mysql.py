# ============================================================
# Import the cleaned UPI dataset into MySQL
# ============================================================

import getpass
import mysql.connector
import pandas as pd

from pathlib import Path

# Locate the project root so the CSV path works from any folder
BASE_DIR = Path(__file__).resolve().parent.parent

# Load the cleaned UPI dataset
df = pd.read_csv(
    BASE_DIR / "data" / "clean" / "upi_clean.csv"
)


# Ask for the MySQL root password without displaying it
password = getpass.getpass("Enter MySQL root password: ")


# Connect to the UPI analysis database
con = mysql.connector.connect(
    host="localhost",
    user="root",
    password=password,
    database="upi_analysis"
)


# Create a cursor for executing SQL commands
cursor = con.cursor()


# Clear the table before importing fresh data
cursor.execute("DELETE FROM upi_monthly")


# Prepare the INSERT statement
insert_query = """
INSERT INTO upi_monthly (
    date,
    month,
    financial_year,
    month_number,
    month_name,
    banks_live,
    volume_mn,
    value_cr,
    avg_ticket_size,
    days_in_month,
    avg_daily_volume_mn,
    avg_daily_value_cr,
    mom_growth_pct,
    yoy_growth_pct,
    value_mom_growth_pct,
    value_yoy_growth_pct,
    fy_months_available,
    source_file
)
VALUES (
    %s, %s, %s, %s, %s, %s, %s, %s, %s,
    %s, %s, %s, %s, %s, %s, %s, %s, %s
)
"""


# Convert pandas NaN values into Python None so MySQL stores them as NULL
df = df.astype(object).where(pd.notna(df), None)


# Arrange dataframe columns in the same order as the MySQL INSERT statement
insert_columns = [
    "date",
    "month",
    "financial_year",
    "month_number",
    "month_name",
    "banks_live",
    "volume_mn",
    "value_cr",
    "avg_ticket_size",
    "days_in_month",
    "avg_daily_volume_mn",
    "avg_daily_value_cr",
    "mom_growth_pct",
    "yoy_growth_pct",
    "value_mom_growth_pct",
    "value_yoy_growth_pct",
    "fy_months_available",
    "source_file"
]

df = df[insert_columns]

# Convert the dataframe into rows
rows = [
    tuple(row)
    for row in df.itertuples(index=False, name=None)
]


# Insert all 66 records
cursor.executemany(insert_query, rows)


# Save the changes
con.commit()


# Verify the imported row count
cursor.execute("SELECT COUNT(*) FROM upi_monthly")
count = cursor.fetchone()[0]


print(f"Successfully imported {count} rows into MySQL.")


# Close database resources
cursor.close()
con.close()

print("MySQL connection closed successfully.")