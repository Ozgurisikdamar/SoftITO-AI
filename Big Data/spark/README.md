# PySpark Batch ETL

Reads CSV events, validates required fields, removes duplicate event IDs, normalizes country codes, and writes partitioned Parquet output.

## Run locally

Install Java compatible with your PySpark version, then:

```bash
python -m pip install -r ../../requirements.txt
spark-submit batch_etl.py ../../data/big-data/events.csv ./output/events
```

The output is partitioned by `event_date`. The job uses overwrite mode for a repeatable full refresh; use a merge/upsert strategy for incremental production pipelines.
