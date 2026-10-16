# Natural Language Processing (NLP)

> **SoftITo · İleri Seviye Yapay Zekâ Mühendisliği**

Bu bölüm, metin verisini temizleme ve temsil etmeden model değerlendirmesine kadar NLP iş akışını uygulamalı örneklerle kapsar.

## Öğrenme haritası

1. **Metin ön işleme:** Unicode, boşluk, normalizasyon ve dil farkları.
2. **Tokenization:** metni kelime veya alt-kelime birimlerine ayırma.
3. **Temsil:** Bag of Words, TF-IDF, n-gram ve embedding.
4. **Klasik NLP:** Naive Bayes, Logistic Regression ve metin sınıflandırma.
5. **Derin öğrenme:** RNN, LSTM, GRU, attention ve Transformer.
6. **Değerlendirme:** train/test ayrımı, precision, recall, F1 ve confusion matrix.
7. **Üretim:** veri sızıntısı, class imbalance, model sürümleme ve izleme.

## Kod örnekleri

- [Metin ön işleme](preprocessing.py): dil bağımsız temel temizlik ve tokenizasyon.
- [TF-IDF sınıflandırma](tfidf_classifier.py): scikit-learn Pipeline ile örnek duygu sınıflandırma.

## Kurulum

```bash
python -m pip install scikit-learn
```

Ön işleme örneği Python standart kütüphanesiyle çalışır. Sınıflandırma örneği küçük, sentetik bir veri kümesi kullanır; gerçek bir projede temsilî ve dengeli bir veri setiyle değerlendirilmelidir.

## Önemli notlar

- Türkçe için apostrof, ekler, büyük/küçük harf ve karakter normalizasyonunu görev bağlamında ele alın.
- Stop-word kaldırma her görevde doğru değildir; olumsuzluk belirten kelimeleri yanlışlıkla silmeyin.
- TF-IDF güçlü bir baseline'dır; Transformer modelleriyle karşılaştırırken aynı veri bölünmesi ve metrikleri kullanın.
- Test verisini model seçimi veya hiperparametre ayarı için kullanmayın.
