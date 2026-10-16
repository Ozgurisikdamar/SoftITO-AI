# SQL Öğrenme Merkezi

Bu bölüm, SQL'i temelden ileri seviyeye örneklerle öğretmek ve mevcut SQL çalışmalarını tek bir yerde toplamak için hazırlanmıştır.

## İçindekiler

| Dosya | Konu / veritabanı |
|---|---|
| [00 — SQL yol haritası](00_sql_roadmap.md) | SQL komut sınıfları, öğrenme sırası ve pratik önerileri |
| [01 — Temel sorgular](01_select_filter_sort.sql) | SELECT, WHERE, DISTINCT, ORDER BY, LIMIT, LIKE, IN, BETWEEN |
| [02 — DML ve DDL](02_ddl_dml_constraints.sql) | CREATE, INSERT, UPDATE, DELETE, ALTER, kısıtlar |
| [03 — JOIN](03_joins.sql) | INNER, LEFT, self join ve çoklu tablo ilişkileri |
| [04 — Gruplama ve fonksiyonlar](04_aggregations.sql) | COUNT, SUM, AVG, GROUP BY, HAVING, CASE |
| [05 — Alt sorgular ve CTE](05_subqueries_ctes.sql) | EXISTS, alt sorgu, WITH/CTE ve recursive CTE |
| [06 — Window functions](06_window_functions.sql) | ROW_NUMBER, RANK, LAG, LEAD, running total |
| [07 — View ve index](07_views_indexes.sql) | View, index, EXPLAIN ve indeksleme ilkeleri |
| [08 — Transaction](08_transactions.sql) | COMMIT, ROLLBACK, ACID ve güvenli güncelleme |
| [09 — Veri modelleme](09_data_modeling.sql) | Normalizasyon, primary/foreign key ve ilişki tasarımı |
| [10 — PostgreSQL ileri örnekler](10_postgresql_advanced.sql) | UPSERT, JSONB, tarih fonksiyonları ve window sorguları |
| [11 — SQLite kütüphane projesi](11_library_sqlite.sql) | Tablo tasarımı, ilişkiler, ödünç alma ve raporlar |
| [12 — SQLite oyuncak mağazası](12_toy_store_sqlite.sql) | CRUD, filtreleme ve tablo değişiklikleri |
| [13 — PostgreSQL ELT](13_postgresql_elt.sql) | Ham veriden analitik tabloya idempotent upsert |
| [Ödevler](exercises/README.md) | Başlangıç, orta ve ileri düzey SQL alıştırmaları |
| [Çözümler](exercises/solutions.sql) | Örnek çözüm sorguları |

## Veritabanı uyumluluğu

- **SQLite:** dosya adında `sqlite` yazan örnekler SQLite içindir. SQLite'ta yabancı anahtarları her bağlantıda `PRAGMA foreign_keys = ON;` ile etkinleştirin.
- **PostgreSQL:** `postgresql` yazan örnekler PostgreSQL içindir.
- Genel SQL sözdizimi veritabanları arasında değişebilir. Özellikle tarih fonksiyonları, otomatik artan kimlikler, JSON işlemleri ve upsert sözdizimi motor bazında farklılık gösterebilir.

## Hızlı başlangıç

SQLite örneği:

```bash
sqlite3 kutuphane.sqlite < SQL/11_library_sqlite.sql
```

PostgreSQL örnekleri için bir PostgreSQL veritabanına bağlanıp ilgili dosyayı çalıştırın. Dosyaları çalıştırmadan önce başlarındaki açıklamaları okuyun; bazı örnekler öğretim amacıyla tablo oluşturur veya veri günceller.

## Güvenli SQL alışkanlıkları

- UPDATE ve DELETE öncesinde aynı koşulla SELECT çalıştırın.
- Gerçek veride değişiklik yapmadan önce transaction ve yedek kullanın.
- Parametreli sorgular kullanın; kullanıcı girdisini SQL metnine birleştirmeyin.
- Büyük tablolarda indeksleri ölçerek ekleyin; her sütunu indekslemek performansı iyileştirmez.
- Sorgu performansını EXPLAIN/EXPLAIN ANALYZE ile değerlendirin; ANALYZE sorguyu gerçekten çalıştırır.
