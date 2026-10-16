# Big Data Engineering

> **SoftITo · İleri Seviye Yapay Zekâ Mühendisliği**

Büyük veri ekosistemini Hadoop/HDFS, MapReduce ve Apache Spark üzerinden uygulamalı öğrenme alanı. Örnekler küçük yerel dosyalarla geliştirilebilir; üretim ortamında dağıtık depolama, kaynak yönetimi, izleme ve veri kalite kontrolleri ayrıca yapılandırılmalıdır.

## Öğrenme yolu

1. **Hadoop HDFS:** dağıtık dosya sistemi kavramları, bloklar ve replikasyon.
2. **MapReduce:** mapper/reducer iş akışı ve key-value yaklaşımı.
3. **Apache Spark:** DataFrame, dönüşümler, aksiyonlar, partition ve lazy evaluation.
4. **Data engineering:** şema, veri kalitesi, Parquet, partitioning ve idempotent işler.

## Örnekler

- [Hadoop Streaming — Word Count](hadoop/wordcount/)
- [PySpark — Batch ETL](spark/batch_etl.py)

## Gereksinimler

- Python 3.10+
- Spark örneği için Java uyumlu bir Spark kurulumu ve `pyspark`
- Hadoop örneği için Hadoop kurulumu ve `HADOOP_HOME`/Streaming JAR yapılandırması

## Tasarım ilkeleri

- Kaynak veriyi değiştirmeden ham katmanda koru.
- Şemayı ve veri kalitesini doğrula.
- Yeniden çalıştırılabilir (idempotent) işler tasarla.
- Büyük veri hacminde tüm veriyi sürücü belleğine alma; dağıtık dönüşümleri tercih et.
