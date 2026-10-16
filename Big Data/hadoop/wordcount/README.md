# Hadoop Streaming: Word Count

Bu örnek, Hadoop Streaming ile Python mapper/reducer çalıştırarak kelime frekanslarını hesaplar.

## Yerelde deneme

```bash
cat input.txt | python mapper.py | sort | python reducer.py
```

## Hadoop üzerinde

Hadoop kurulumu ve Streaming JAR yolu yapılandırıldıktan sonra örnek komut:

```bash
hadoop jar "$HADOOP_STREAMING_JAR" \
  -input /data/input.txt \
  -output /results/wordcount \
  -mapper "python3 mapper.py" \
  -reducer "python3 reducer.py" \
  -files mapper.py,reducer.py
```

Çıktı dizini daha önce mevcut olmamalıdır. Hadoop sürümüne göre Streaming JAR konumu değişebilir.
