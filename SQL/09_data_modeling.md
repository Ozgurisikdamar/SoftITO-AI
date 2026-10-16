# İlişkisel Veri Modelleme ve Normalizasyon

## Anahtarlar ve kısıtlar
- **PRIMARY KEY:** satırı benzersiz tanımlar; NULL olamaz.
- **FOREIGN KEY:** tablolar arasındaki referans bütünlüğünü korur.
- **UNIQUE:** sütun veya sütun kombinasyonunun tekrarını engeller.
- **CHECK:** değerlerin koşula uymasını sağlar.
- **NOT NULL:** zorunlu alanı tanımlar.

## İlişkiler
- **1:1:** bir kişi ve tek profil.
- **1:N:** bir departman ve çok çalışan.
- **N:M:** öğrenciler ve dersler; arada ilişki tablosu gerekir.

## Normalizasyon
- **1NF:** alanlar atomik olmalı, tekrar eden sütun grupları olmamalı.
- **2NF:** 1NF ve bileşik anahtarın yalnızca bir bölümüne bağlı kısmi bağımlılık olmamalı.
- **3NF:** 2NF ve anahtar olmayan alanlar arasında geçişli bağımlılık olmamalı.

Normalizasyon tekrarları ve güncelleme anomalilerini azaltır. Analitik veri ambarlarında sorgu performansı için kontrollü denormalizasyon gerekebilir.

```sql
CREATE TABLE students (student_id INTEGER PRIMARY KEY, full_name TEXT NOT NULL);
CREATE TABLE courses (course_id INTEGER PRIMARY KEY, course_name TEXT NOT NULL UNIQUE);
CREATE TABLE enrollments (
  student_id INTEGER NOT NULL REFERENCES students(student_id),
  course_id INTEGER NOT NULL REFERENCES courses(course_id),
  enrolled_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY(student_id, course_id)
);
```
Bileşik anahtar aynı öğrencinin aynı derse iki kez kaydolmasını önler.
