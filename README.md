# SoftITo-AI

SoftITo eğitim sürecindeki Python, veri analizi, istatistik, makine öğrenmesi ve veri mühendisliği çalışmalarını konu bazında düzenleyen uygulama deposu.

## Öğrenme alanları

| Alan | İçerik |
|---|---|
| [Python](Python/README.md) | Python temelleri, Pandas, CSV/Excel |
| [EDA](EDA/README.md) | Keşifçi veri analizi, veri kalitesi ve görselleştirme |
| [Statistics](Statistics/README.md) | Betimsel istatistik, güven aralıkları ve istatistiksel analiz |
| [ML](ML/README.md) | Regresyon, ensemble yöntemleri, model değerlendirme ve derin öğrenmeye giriş |
| [NLP](NLP/README.md) | Metin ön işleme ve metin sınıflandırma |
| [Big Data](Big%20Data/README.md) | Hadoop Streaming ve PySpark |
| [ETL-ELT](ETL-ELT/README.md) | Veri entegrasyonu ve dönüşüm desenleri |
| [RNN](RNN/README.md), [LSTM](LSTM/README.md), [GRU](GRU/README.md) | Tekrarlayan sinir ağı mimarileri |

## Kurulum

Her klasörde konuya özel `requirements.txt` bulunabilir. En güvenli yaklaşım, proje için sanal ortam oluşturup yalnızca çalıştıracağınız konuya ait bağımlılıkları kurmaktır.

```bash
python -m venv .venv
# Windows: .venv\Scripts\activate
# macOS/Linux: source .venv/bin/activate
python -m pip install -r EDA/requirements.txt
pytest -q
```

Notebook'lar Google Colab veya Jupyter ile açılabilir. Harici veri dosyası bekleyen hücrelerde ilgili dosya yolunu kendi ortamınıza göre güncelleyin.
