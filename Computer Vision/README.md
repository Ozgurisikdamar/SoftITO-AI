# Computer Vision (Görüntü İşleme)

Bu klasör, klasik görüntü işleme tekniklerinden derin öğrenme tabanlı görüntü analizine uzanan notebook çalışmalarını içerir.

## Çalışmalar

| Dosya | İçerik |
|---|---|
| [Görüntü İşleme — Giriş](goruntu_isleme_giris.ipynb) | Görüntü işleme temelleri ve başlangıç düzeyi uygulamalar. |
| [Görüntü İşleme — İleri](goruntu_isleme_ileri.ipynb) | İleri seviye görüntü işleme konuları ve uygulamaları. |
| [Derin Öğrenme ile Görüntü İşleme](derin_ogrenme_goruntu_isleme.ipynb) | PyTorch ile CNN sınıflandırma, U-Net semantik segmentasyon ve Mask R-CNN nesne tespiti/instance segmentation. |

## Kapsam

- Görüntü işleme temelleri ve dönüşümler
- Görüntü sınıflandırma
- Convolutional Neural Networks (CNN)
- Semantik segmentasyon: U-Net
- Nesne tespiti ve instance segmentation: Mask R-CNN
- PyTorch ve Torchvision ile model oluşturma, inference ve eğitim adımları

## Çalıştırma

Notebook'ları Jupyter veya Google Colab üzerinde açabilirsiniz. Derin öğrenme notebook'u PyTorch ve Torchvision kullanır:

```bash
pip install torch torchvision
```

GPU zorunlu değildir; notebook cihazı CUDA kullanılabilirliğine göre seçer. Bazı notebook'lar ek paket veya veri seti gerektirebilir; ilgili notebook içindeki kurulum ve veri yönergelerini kontrol edin.

> Eğitim amaçlı örneklerde sentetik veri veya hazır ağırlıklar kullanılabilir. Bu, gerçek veri setinde eğitilmiş ve üretime hazır model performansı anlamına gelmez.
