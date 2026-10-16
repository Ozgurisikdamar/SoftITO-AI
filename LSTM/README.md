# LSTM — Temelden Uygulamaya

Bu çalışma, Long Short-Term Memory (LSTM) ağlarının kapı mekanizmasını ve uzun dönemli bağımlılıkları nasıl modellediğini ele alır.

## İçerik
- Hücre durumu ve unutma, girdi, çıkış kapıları
- Küçük bir sayısal NumPy örneği
- Gürültülü sinüs dalgası için kayan pencere veri hazırlama
- PyTorch ile elle yazılmış hücre ve `nn.LSTM`
- Keras `layers.LSTM` ile eğitim ve değerlendirme
- RNN ve GRU ile kavramsal/sonuç karşılaştırması

## Görev
Son 20 zaman adımını kullanarak bir sonraki sinüs dalgası değerini tahmin etmek.

## Çalıştırma
Notebook'u Google Colab veya Jupyter Notebook ile açın. Gerekli paketler: NumPy, Matplotlib, PyTorch ve TensorFlow/Keras.
