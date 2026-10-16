"""Small, runnable PySpark batch ETL example.

Input CSV columns: event_id,event_time,country,amount
Usage:
  spark-submit batch_etl.py input.csv output_dir
"""
from __future__ import annotations

import sys
from pyspark.sql import SparkSession, functions as F
from pyspark.sql.types import DoubleType, StringType, StructField, StructType

SCHEMA = StructType([
    StructField("event_id", StringType(), True),
    StructField("event_time", StringType(), True),
    StructField("country", StringType(), True),
    StructField("amount", DoubleType(), True),
])


def main(input_path: str, output_path: str) -> None:
    spark = SparkSession.builder.appName("SoftITo-Batch-ETL").getOrCreate()
    try:
        raw = (
            spark.read.option("header", True)
            .schema(SCHEMA)
            .csv(input_path)
        )

        cleaned = (
            raw.withColumn("event_time", F.to_timestamp("event_time"))
            .withColumn("country", F.upper(F.trim(F.col("country"))))
            .filter(F.col("event_id").isNotNull())
            .filter(F.col("event_time").isNotNull())
            .filter(F.col("amount").isNotNull() & (F.col("amount") >= 0))
            .dropDuplicates(["event_id"])
            .withColumn("event_date", F.to_date("event_time"))
        )

        # Curated, columnar output suitable for downstream analytics.
        (
            cleaned.write.mode("overwrite")
            .format("parquet")
            .partitionBy("event_date")
            .save(output_path)
        )

        summary = cleaned.groupBy("country").agg(
            F.count("*").alias("event_count"),
            F.round(F.sum("amount"), 2).alias("total_amount"),
            F.round(F.avg("amount"), 2).alias("average_amount"),
        )
        summary.orderBy(F.desc("total_amount")).show(truncate=False)
    finally:
        spark.stop()


if __name__ == "__main__":
    if len(sys.argv) != 3:
        raise SystemExit("Usage: spark-submit batch_etl.py <input.csv> <output_dir>")
    main(sys.argv[1], sys.argv[2])
