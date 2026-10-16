"""Minimal, dependency-free CSV ETL example.

Usage:
  python python_etl.py input.csv clean.csv rejects.csv

Expected columns: customer_id,email,country,amount
"""
from __future__ import annotations

import csv
import sys
from decimal import Decimal, InvalidOperation


def transform(row: dict[str, str]) -> tuple[dict[str, str] | None, str | None]:
    customer_id = (row.get("customer_id") or "").strip()
    email = (row.get("email") or "").strip().lower()
    country = (row.get("country") or "").strip().upper()

    if not customer_id:
        return None, "missing_customer_id"
    if "@" not in email or email.startswith("@") or email.endswith("@"):
        return None, "invalid_email"
    try:
        amount = Decimal((row.get("amount") or "").strip())
    except InvalidOperation:
        return None, "invalid_amount"
    if not amount.is_finite() or amount < 0:
        return None, "amount_must_be_nonnegative"

    return {
        "customer_id": customer_id,
        "email": email,
        "country": country,
        "amount": str(amount.quantize(Decimal("0.01"))),
    }, None


def main(source: str, target: str, rejects_path: str) -> None:
    with open(source, newline="", encoding="utf-8-sig") as src, \
         open(target, "w", newline="", encoding="utf-8") as out, \
         open(rejects_path, "w", newline="", encoding="utf-8") as rejects:
        reader = csv.DictReader(src)
        fields = ["customer_id", "email", "country", "amount"]
        writer = csv.DictWriter(out, fieldnames=fields)
        reject_writer = csv.DictWriter(rejects, fieldnames=["reason", "row"])
        writer.writeheader()
        reject_writer.writeheader()

        for row in reader:
            cleaned, error = transform(row)
            if error:
                reject_writer.writerow({"reason": error, "row": repr(row)})
            else:
                writer.writerow(cleaned)


if __name__ == "__main__":
    if len(sys.argv) != 4:
        raise SystemExit("Usage: python python_etl.py input.csv clean.csv rejects.csv")
    main(*sys.argv[1:])
