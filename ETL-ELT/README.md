# ETL & ELT

> **SoftITo · Data Engineering**

ETL (Extract, Transform, Load) veriyi hedefe yüklemeden önce dönüştürür. ELT (Extract, Load, Transform) ise ham veriyi hedef platforma yükler ve dönüşümü orada gerçekleştirir.

## Katmanlı veri mimarisi

- **Bronze / Raw:** kaynağa yakın ham veri; kaynak bilgisi ve yükleme zamanı korunur.
- **Silver / Clean:** tip dönüşümü, standardizasyon, kalite kontrolleri ve deduplication.
- **Gold / Serving:** raporlama ve ürün ihtiyaçlarına göre modellenmiş veri.

## Örnekler

- [Python ETL](python_etl.py): CSV okur, alanları normalize eder, doğrular ve hatalı kayıtları ayrı dosyaya yazar.
- [PostgreSQL ELT](sql_elt.sql): raw tablodan analitik tabloya idempotent upsert.
- [Örnek müşteri verisi](../data/etl/customers.csv)

## Python ETL çalıştırma

Repository kök dizininden:

```bash
python "ETL-ELT/python_etl.py" data/etl/customers.csv data/processed/customers.csv data/processed/rejects.csv
```

## Testler

```bash
python -m pip install -r requirements.txt
pytest -q
```

## Üretim kontrol listesi

- Şema ve veri sözleşmeleri
- Null, duplicate, aralık ve referans bütünlüğü kontrolleri
- Hatalı kayıtların karantinaya alınması
- Idempotency ve yeniden çalıştırma stratejisi
- Incremental load / watermark veya CDC
- Log, metrik, alarm ve lineage
- PII sınıflandırması, erişim kontrolü ve saklama politikası
- Kaynak-hedef satır sayısı ve kontrol toplamları

> SQL örneği PostgreSQL içindir ve `raw_events` tablosunun önceden oluşturulmuş olduğunu varsayar.
