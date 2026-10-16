# SoftITo-AI

SoftITo eğitim sürecindeki Python, veri analizi, istatistik, makine öğrenmesi ve veri mühendisliği çalışmalarını konu bazında düzenleyen uygulama deposu.

## Öğrenme alanları

| Alan | İçerik |
|---|---|
| [Python](Python/README.md) | Python temelleri, Pandas, CSV/Excel |
| [EDA](EDA/README.md) | Keşifçi veri analizi, veri kalitesi ve görselleştirme |
| [Statistics](Statistics/README.md) | Betimsel istatistik ve istatistiksel analiz |
| [ML](ML/README.md) | Regresyon, ensemble yöntemleri, sınıflandırma ve derin öğrenmeye giriş |
| [SQL](SQL/README.md) | SQL temelleri, JOIN, CTE, window functions, index, transaction, veri modelleme ve örnek projeler |
| [NLP](NLP/README.md) | Metin ön işleme ve metin sınıflandırma |
| [Big Data](Big%20Data/README.md) | Hadoop Streaming ve PySpark |
| [ETL-ELT](ETL-ELT/README.md) | Veri entegrasyonu ve dönüşüm desenleri |
| [RNN](RNN/README.md), [LSTM](LSTM/README.md), [GRU](GRU/README.md) | Tekrarlayan sinir ağı mimarileri |

## SQL

SQL çalışmaları tek yerde toplandı: [SQL öğrenme merkezi](SQL/README.md). SQLite ve PostgreSQL örnekleri ayrı belirtilmiştir. Başlamadan önce ilgili dosyanın veritabanı uyumluluğu notunu okuyun.

## Kurulum

Her konu klasöründe konuya özel `requirements.txt` bulunabilir. Örneğin:

```bash
python -m venv .venv
# Windows: .venv\Scripts\activate
# macOS/Linux: source .venv/bin/activate
python -m pip install -r EDA/requirements.txt
```

Notebook'lar Google Colab veya Jupyter ile açılabilir. Harici veri dosyası bekleyen hücrelerde dosya yolunu kendi ortamınıza göre güncelleyin.

> Örnek kodlar eğitim amaçlıdır. Gerçek sistemlerde güvenlik, veri gizliliği, test ve operasyonel gereksinimleri ayrıca ele alınmalıdır.
