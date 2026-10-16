import importlib.util
from pathlib import Path
import sys

ROOT = Path(__file__).resolve().parents[1]
spec = importlib.util.spec_from_file_location("preprocessing", ROOT / "NLP" / "preprocessing.py")
preprocessing = importlib.util.module_from_spec(spec)
sys.modules[spec.name] = preprocessing
spec.loader.exec_module(preprocessing)


def test_normalize_text_collapses_whitespace():
    assert preprocessing.normalize_text("  Merhaba\u00a0 dünya  ") == "Merhaba dünya"


def test_tokenize_preserves_turkish_characters_and_apostrophe():
    assert preprocessing.tokenize("İstanbul'da NLP çalışıyorum!") == ["istanbul'da", "nlp", "çalışıyorum"]
