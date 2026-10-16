# GRU — Temelden Uygulamaya

> **SoftITo · İleri Seviye Yapay Zekâ Mühendisliği**

Gated Recurrent Unit (GRU), reset ve update kapılarıyla geçmiş bilgiyi ve yeni girdiyi dengeleyen, LSTM'e göre daha sade bir tekrarlayan sinir ağı mimarisidir.

## İçerik
- Reset (`r_t`) ve update (`z_t`) kapıları
- NumPy ile küçük sayısal örnek
- Gürültülü sinüs zaman serisi ve kayan pencere yaklaşımı
- PyTorch: elle yazılmış hücre ve `nn.GRU`
- Keras: `layers.GRU`
- Eğitim, test ve RNN/LSTM/GRU karşılaştırması

## Uygulama görevi
Önceki **20 zaman adımını** kullanarak bir sonraki sinüs dalgası değerini tahmin etmek.

## Çalıştırma
`gru_pytorch_keras.ipynb` dosyasını Google Colab veya Jupyter Notebook ile açın. Gerekli paketler: NumPy, Matplotlib, PyTorch ve TensorFlow/Keras.

---

[← SoftITo-AI ana deposu](../README.md) · [RNN](../RNN/) · [LSTM](../LSTM/)
