"""Simple, language-aware text normalization and tokenization baseline.

This is intentionally lightweight; it is not a replacement for a language-specific
morphological analyzer or a production tokenizer.
"""
from __future__ import annotations

import re
import unicodedata

TOKEN_PATTERN = re.compile(r"[^\W_]+(?:['’][^\W_]+)?", flags=re.UNICODE)


def normalize_text(text: str) -> str:
    """Normalize Unicode and whitespace while preserving word characters."""
    text = unicodedata.normalize("NFKC", text)
    text = text.replace("\u00a0", " ")
    return re.sub(r"\s+", " ", text).strip()


def tokenize(text: str, lowercase: bool = True) -> list[str]:
    """Return basic word tokens; keep apostrophes inside tokens."""
    normalized = normalize_text(text)
    if lowercase:
        normalized = normalized.lower()
    return TOKEN_PATTERN.findall(normalized)


if __name__ == "__main__":
    sample = "İstanbul'da NLP çalışıyorum — RNN, LSTM ve GRU!"
    print("Normalized:", normalize_text(sample))
    print("Tokens:", tokenize(sample))
