# olist-ecommerce-revenue-analysis

End-to-end analytics project on the Brazilian Olist e-commerce dataset.

## Business questions

1. How much revenue did Olist generate, and how did it change month by month?
2. When did demand peak, and what likely drove it?
3. How reliable was fulfilment: what share of orders were delivered, and what share were lost?

## Tools
Python, Google BigQuery, SQL, Power BI

## Pipeline
CSV files -> Python script -> BigQuery tables -> SQL queries -> Power BI dashboard

## What I did
1. Wrote a Python script (`load_to_bigquery.py`) that loads 9 CSV files into BigQuery with one command.
2. Checked row counts to confirm every table loaded fully (for example, orders: 99,441 rows and geolocation: 1,000,163 rows).
3. Wrote SQL queries (joins and aggregations) to analyse sales.
4. Built an interactive Power BI dashboard with a date slicer and a product category slicer.

## Key results (delivered orders only)
- Total revenue: 13.22M
- Delivered orders: 96,478
- 97% of orders were delivered successfully, while 1.2% were lost to cancellation or unavailability.
- Revenue peaked in November 2017 at about 988K BRL, consistent with Black Friday demand.

## Dashboard
![Dashboard](dashboard.png)

## Files
- `load_to_bigquery.py`: loads all CSV files into BigQuery
- `queries.sql`: SQL queries used for the analysis
- `dashboard.png`: Power BI dashboard screenshot

## How to run the loader
1. Install Python and run `pip install google-cloud-bigquery`.
2. Log in with `gcloud auth application-default login`.
3. Put the Olist CSV files in the same folder as the script.
4. Run `python load_to_bigquery.py`

## Business Insights

1. **Average order value is about 137 BRL.** Total revenue of 13.22M across 96,478 delivered orders works out to roughly 137 per order.
2. **Three categories lead revenue:** health_beauty, watches_gifts and bed_bath_table are the top three in the category chart.
3. **Revenue grew strongly through 2017, then levelled off in 2018.** The monthly revenue trend rises steeply in 2017 and stays roughly flat through mid-2018.
4. **Recommendation:** focus marketing and stock on the top categories, and investigate why growth stalled in 2018, for example by checking order volume, delivery times and review scores.

*Revenue is the sum of item prices for delivered orders, excluding freight.*
## Data source

Brazilian E-Commerce Public Dataset by Olist, from Kaggle:
https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce

Note: BigQuery sandbox tables expire after 60 days. If they disappear, rerun `load_to_bigquery.py` to rebuild them.
