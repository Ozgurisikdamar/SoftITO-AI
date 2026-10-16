# SQL Yol Haritası

## 1. SQL nedir?

SQL, ilişkisel veritabanlarında veriyi tanımlamak, sorgulamak ve değiştirmek için kullanılan dildir. Tablolar satır ve sütunlardan oluşur; ilişkiler primary key ve foreign key gibi anahtarlarla kurulur.

## 2. Komut grupları

- **DQL:** `SELECT` ile veriyi sorgulama.
- **DML:** `INSERT`, `UPDATE`, `DELETE` ile veriyi değiştirme.
- **DDL:** `CREATE`, `ALTER`, `DROP` ile şema yönetimi.
- **DCL:** `GRANT`, `REVOKE` ile yetkilendirme (veritabanı desteğine bağlı).
- **TCL:** `BEGIN`, `COMMIT`, `ROLLBACK` ile transaction yönetimi.

## 3. Önerilen öğrenme sırası

1. SELECT ve sütun seçimi
2. WHERE, NULL, AND/OR, IN, BETWEEN, LIKE
3. ORDER BY, LIMIT ve DISTINCT
4. INSERT, UPDATE, DELETE
5. Veri tipleri ve kısıtlar
6. JOIN ve ilişki modelleme
7. GROUP BY, HAVING ve aggregate fonksiyonlar
8. Alt sorgular ve CTE
9. Window functions
10. View, index, EXPLAIN
11. Transaction ve eşzamanlılık
12. Normalizasyon ve veri ambarı yaklaşımı

## 4. Önemli kavramlar

- SQL'de NULL, sıfır veya boş metin değildir. NULL kontrolü `IS NULL` ile yapılır.
- `WHERE` satırları gruplama öncesi, `HAVING` ise gruplama sonrası filtreler.
- `COUNT(*)` satırları sayar; `COUNT(column)` NULL olmayan değerleri sayar.
- JOIN sonucunda satır sayısı, ilişkinin kardinalitesine bağlı olarak artabilir.
- Sorgularda açık sütun listesi kullanmak, `SELECT *` kullanımından genellikle daha güvenlidir.
- İndeks okuma performansını artırabilir; yazma maliyeti ve disk kullanımı da getirir.

## 5. Pratik önerisi

Her dosyayı sırayla çalıştırın. Önce sorgunun tahmin ettiğiniz sonucunu yazın, sonra çalıştırıp karşılaştırın. UPDATE/DELETE örneklerini yalnızca deneme veritabanında çalıştırın.
