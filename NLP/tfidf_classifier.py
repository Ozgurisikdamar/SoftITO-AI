"""Tiny sentiment-classification baseline using scikit-learn.

Run: python tfidf_classifier.py
Install: python -m pip install scikit-learn
The embedded data is illustrative only; do not interpret metrics as benchmark results.
"""
from __future__ import annotations

from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.linear_model import LogisticRegression
from sklearn.metrics import classification_report
from sklearn.model_selection import train_test_split
from sklearn.pipeline import Pipeline

TEXTS = [
    "I love this product", "Excellent quality and fast delivery",
    "This works perfectly", "Very happy with the purchase",
    "Amazing experience", "The product is wonderful",
    "I hate this product", "Terrible quality and slow delivery",
    "This does not work", "Very disappointed with the purchase",
    "Awful experience", "The product is broken",
    "Great value for money", "Really useful and reliable",
    "Waste of money", "Poor and frustrating experience",
    "Fantastic result", "I would recommend it",
    "Not worth buying", "Completely useless",
]
LABELS = [
    "positive", "positive", "positive", "positive", "positive", "positive",
    "negative", "negative", "negative", "negative", "negative", "negative",
    "positive", "positive", "negative", "negative", "positive", "positive",
    "negative", "negative",
]


def main() -> None:
    x_train, x_test, y_train, y_test = train_test_split(
        TEXTS, LABELS, test_size=0.3, random_state=42, stratify=LABELS
    )
    model = Pipeline([
        ("tfidf", TfidfVectorizer(ngram_range=(1, 2), min_df=1)),
        ("classifier", LogisticRegression(max_iter=1000, random_state=42)),
    ])
    model.fit(x_train, y_train)
    predictions = model.predict(x_test)
    print(classification_report(y_test, predictions, zero_division=0))

    for text in ["I love it", "This is awful"]:
        print(f"{text!r} -> {model.predict([text])[0]}")


if __name__ == "__main__":
    main()
