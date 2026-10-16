# LSTM — Temelden Uygulamaya

> **SoftITo · İleri Seviye Yapay Zekâ Mühendisliği**

Long Short-Term Memory (LSTM), standart RNN'lerdeki uzun dönemli bağımlılık sorununu kapı mekanizması ve hücre durumu üzerinden ele alan bir tekrarlayan sinir ağı mimarisidir.

## İçerik
- Hücre durumu (`c_t`) ve gizli durum (`h_t`)
- Unutma, girdi ve çıkış kapıları
- NumPy ile sayısal örnek
- Gürültülü sinüs zaman serisinin hazırlanması
- PyTorch: manuel hücre ve `nn.LSTM`
- Keras: `layers.LSTM`
- Eğitim, test ve tahmin karşılaştırmaları

## Uygulama görevi
Önceki **20 zaman adımını** kullanarak bir sonraki sinüs dalgası değerini tahmin etmek.

## Çalıştırma
`lstm_pytorch_keras.ipynb` dosyasını Google Colab veya Jupyter Notebook ile açın. Gerekli paketler: NumPy, Matplotlib, PyTorch ve TensorFlow/Keras.

---

[← SoftITo-AI ana deposu](../README.md) · [RNN](../RNN/) · [GRU](../GRU/)
