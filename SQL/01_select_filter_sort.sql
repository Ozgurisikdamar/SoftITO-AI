-- SQL SELECT, FILTERING AND SORTING
-- SQLite/PostgreSQL genel sözdizimi; LIMIT her ikisinde de desteklenir.

CREATE TABLE IF NOT EXISTS customers_demo (
    customer_id INTEGER PRIMARY KEY,
    full_name TEXT NOT NULL,
    city TEXT,
    age INTEGER,
    email TEXT,
    is_active INTEGER NOT NULL DEFAULT 1
);

INSERT INTO customers_demo (customer_id, full_name, city, age, email, is_active) VALUES
(1, 'Ayşe Yılmaz', 'İstanbul', 29, 'ayse@example.com', 1),
(2, 'Mehmet Demir', 'Ankara', 35, 'mehmet@example.com', 1),
(3, 'Ece Kaya', 'İzmir', 24, 'ece@example.com', 0),
(4, 'Can Arslan', 'İstanbul', 41, 'can@example.com', 1),
(5, 'Deniz Aydın', NULL, 31, NULL, 1)
ON CONFLICT (customer_id) DO NOTHING;

-- 1) Sütun seçme ve alias
SELECT customer_id, full_name AS customer_name, city FROM customers_demo;

-- 2) Mantıksal filtreler
SELECT full_name, age FROM customers_demo WHERE age >= 30 AND is_active = 1;
SELECT full_name, city FROM customers_demo WHERE city = 'İstanbul' OR city = 'Ankara';

-- 3) IN, BETWEEN, LIKE
SELECT * FROM customers_demo WHERE city IN ('İstanbul', 'İzmir');
SELECT * FROM customers_demo WHERE age BETWEEN 25 AND 40;
SELECT * FROM customers_demo WHERE full_name LIKE 'A%';

-- 4) NULL doğru kontrol edilir; = NULL kullanılmaz
SELECT * FROM customers_demo WHERE city IS NULL;
SELECT * FROM customers_demo WHERE email IS NOT NULL;

-- 5) DISTINCT ve sıralama
SELECT DISTINCT city FROM customers_demo WHERE city IS NOT NULL ORDER BY city;
SELECT full_name, age FROM customers_demo ORDER BY age DESC LIMIT 3;

-- 6) CASE ile kategorileştirme
SELECT full_name, age,
       CASE WHEN age < 25 THEN 'young'
            WHEN age < 40 THEN 'adult'
            ELSE 'senior'
       END AS age_group
FROM customers_demo
ORDER BY age;

-- Öğretim notu: bu dosyayı tekrar çalıştırmak için örnek INSERT'lerdeki
-- ON CONFLICT ifadesi SQLite ve PostgreSQL'de desteklenir.
