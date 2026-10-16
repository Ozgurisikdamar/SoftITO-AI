import importlib.util
from pathlib import Path
import sys

ROOT = Path(__file__).resolve().parents[1]
spec = importlib.util.spec_from_file_location("python_etl", ROOT / "ETL-ELT" / "python_etl.py")
etl = importlib.util.module_from_spec(spec)
sys.modules[spec.name] = etl
spec.loader.exec_module(etl)


def test_transform_normalizes_valid_row():
    cleaned, error = etl.transform({
        "customer_id": " C-1 ", "email": "USER@Example.COM",
        "country": " tr ", "amount": "12.5"
    })
    assert error is None
    assert cleaned == {
        "customer_id": "C-1", "email": "user@example.com",
        "country": "TR", "amount": "12.50"
    }


def test_transform_rejects_missing_customer_id():
    cleaned, error = etl.transform({
        "customer_id": " ", "email": "a@b.com", "country": "tr", "amount": "1"
    })
    assert cleaned is None
    assert error == "missing_customer_id"


def test_transform_rejects_invalid_email():
    cleaned, error = etl.transform({
        "customer_id": "C-2", "email": "not-an-email", "country": "tr", "amount": "1"
    })
    assert cleaned is None
    assert error == "invalid_email"


def test_transform_rejects_negative_amount():
    cleaned, error = etl.transform({
        "customer_id": "C-3", "email": "a@b.com", "country": "tr", "amount": "-1"
    })
    assert cleaned is None
    assert error == "amount_must_be_nonnegative"
