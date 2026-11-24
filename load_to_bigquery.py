from google.cloud import bigquery

PROJECT = "rohin-ecommerce-pipeline"
DATASET = "ecommerce_raw"

FILES = {
    "customers": "olist_customers_dataset.csv",
    "orders": "olist_orders_dataset.csv",
    "order_items": "olist_order_items_dataset.csv",
    "order_payments": "olist_order_payments_dataset.csv",
    "order_reviews": "olist_order_reviews_dataset.csv",
    "products": "olist_products_dataset.csv",
    "sellers": "olist_sellers_dataset.csv",
    "geolocation": "olist_geolocation_dataset.csv",
    "product_category_name_translation": "product_category_name_translation.csv",
}

client = bigquery.Client(project=PROJECT)

config = bigquery.LoadJobConfig(
    source_format=bigquery.SourceFormat.CSV,
    skip_leading_rows=1,
    autodetect=True,
    allow_quoted_newlines=True,
    write_disposition="WRITE_TRUNCATE",
)

for table, filename in FILES.items():
    with open(filename, "rb") as f:
        job = client.load_table_from_file(
            f, f"{PROJECT}.{DATASET}.{table}", job_config=config
        )
    job.result()
    print(f"Loaded {table}: {client.get_table(f'{PROJECT}.{DATASET}.{table}').num_rows} rows")