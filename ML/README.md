# Machine Learning

Bu klasör, klasik makine öğrenmesi algoritmalarını, model değerlendirmesini ve derin öğrenmeye giriş çalışmalarını konu bazında toplar.

## Notebook haritası
- `model_evaluation_and_regression.ipynb` — Diabetes veri seti, regresyon başlangıcı, keşif ve train/test ayrımı.
- `ensemble_classification.ipynb` — Random Forest, AdaBoost, Gradient Boosting ve çapraz doğrulamayla karşılaştırma.
- `keras_pytorch_binary_classification.ipynb` — Keras ve PyTorch ile tabular ikili sınıflandırmaya giriş.
- `image_classification_cnn.ipynb` — CIFAR-10/MNIST benzeri görüntü veri setleri için CNN eğitim hattı.
- `keras_tabular_classification.ipynb` — Tabular veri için ölçekleme, train/validation/test ayrımı ve Keras modeli.

## Değerlendirme ilkeleri
- Veri sızıntısını önlemek için scaler yalnızca eğitim verisine fit edilmelidir.
- Sınıflandırmada accuracy yanında precision, recall, F1 ve ROC-AUC incelenmelidir.
- Model seçimi validation/CV ile yapılmalı; test kümesi nihai değerlendirme için saklanmalıdır.
- Sentetik veya küçük örneklerdeki skorlar gerçek dünya performansı olarak yorumlanmamalıdır.
