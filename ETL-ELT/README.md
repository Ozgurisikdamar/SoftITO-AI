# ETL & ELT

> **SoftITo · Data Engineering**

ETL (Extract, Transform, Load) veriyi hedef sisteme yüklemeden önce dönüştürür. ELT (Extract, Load, Transform) ise ham veriyi hedef platforma yükler ve dönüşümü hedef sistemde gerçekleştirir.

## Ne zaman hangisi?

| Konu | ETL | ELT |
|---|---|---|
| Dönüşüm nerede? | Kaynak/ara katman | Hedef veri platformu |
| Yaygın kullanım | Kontrollü entegrasyon, maskeleme, sınırlı hedefler | Cloud warehouse/lakehouse ve ölçeklenebilir analitik |
| Ham verinin korunması | Tasarıma bağlı | Genellikle raw katmanda korunur |
| Önemli risk | Ara katmanda darboğaz | Ham katmanda kalite ve erişim kontrolü |

## Önerilen katmanlar

- **Bronze / Raw:** kaynağa yakın, izlenebilir ham veri.
- **Silver / Clean:** tip, şema, kalite, deduplication ve standardizasyon.
- **Gold / Serving:** raporlama ve ürün ihtiyaçlarına göre modellenmiş veri.

## Uygulama örnekleri

- [Python ETL pipeline](python_etl.py): CSV oku, doğrula, normalize et ve temiz veriyi yaz.
- [SQL ELT örneği](sql_elt.sql): ham tablodan analitik tablo üret.

## Üretim kontrol listesi

- Şema ve veri sözleşmeleri
- Null, duplicate, aralık ve referans bütünlüğü kontrolleri
- Hata kayıtlarının karantinaya alınması
- Idempotency ve yeniden çalıştırma stratejisi
- Incremental load / watermark veya CDC
- Log, metrik, alarm ve lineage
- PII sınıflandırması, erişim kontrolü ve saklama politikası
- Kaynak-hedef satır sayısı ve kontrol toplamları
