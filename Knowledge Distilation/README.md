# Knowledge Distillation — Qwen2.5

Bu klasörde, büyük bir **teacher** modelin davranışını daha küçük bir **student** modele aktarmayı amaçlayan LLM Knowledge Distillation çalışması bulunur.

## Notebook

[**distil_qwen_colab.ipynb — Google Colab notebook'u**](distil_qwen_colab.ipynb)

Notebook, Google Colab GPU ortamında çalıştırılmak üzere hazırlanmıştır. Öğretmen modelin token düzeyindeki çıktı dağılımları kullanılarak öğrenci model eğitilir.

### Teacher → Student

| Rol | Model | Parametre |
|---|---|---:|
| Teacher | `Qwen/Qwen2.5-7B-Instruct` | 7B |
| Student | `Qwen/Qwen2.5-0.5B-Instruct` | 0.5B |

Student, teacher'a göre çok daha küçük ve inference açısından daha hafif bir modeldir.

## Dataset

- **Dataset:** [yahma/alpaca-cleaned](https://huggingface.co/datasets/yahma/alpaca-cleaned)
- **Train sample üst sınırı:** 20.000
- **Evaluation sample üst sınırı:** 300
- **Maximum sequence length:** 512 token
- Veriler instruction/input/output alanlarından sohbet biçimine dönüştürülür.
- Prompt token'ları loss hesaplamasında maskelenir; loss yalnızca cevap token'larında hesaplanır.

## Distillation yöntemi

Notebook, soft teacher hedefleri ve ground-truth cevapları birlikte kullanır:

```text
Loss = alpha * T² * KL(teacher || student) + (1 - alpha) * CE(student, labels)
```

- **KL divergence:** Student'ın teacher'ın yumuşatılmış olasılık dağılımını taklit etmesini sağlar.
- **Temperature (T):** Dağılımı yumuşatır; varsayılan değer `2.0`.
- **Alpha:** Distillation loss ağırlığı; varsayılan `0.7`.
- **Cross-Entropy (CE):** Student'ın gerçek cevap token'larını öğrenmesini destekler.
- Teacher forward pass gradyanssız çalışır; optimizer yalnızca student parametrelerini günceller.

## Eğitim yapılandırması

Notebook'taki varsayılanlar:

- 1 epoch
- Learning rate: `5e-5`
- AdamW optimizer
- Cosine learning-rate scheduler + %3 warmup
- Effective batch size: 32 (gradient accumulation ile)
- BF16 destekleniyorsa BF16, aksi durumda FP16
- GPU bellek kapasitesine göre teacher için 4-bit quantization seçimi
- Checkpoint ve tokenizer kaydı; isteğe bağlı Google Drive kullanımı

## Notebook akışı

1. GPU ve CUDA kontrolü
2. Gerekli paketlerin kurulumu
3. İsteğe bağlı Google Drive bağlantısı
4. GPU'ya göre eğitim ayarlarının seçilmesi
5. Teacher ve student modellerinin yüklenmesi
6. Dataset hazırlama, chat template ve prompt masking
7. KL + CE distillation loss
8. Student eğitimi ve evaluation
9. Loss eğrilerinin çizilmesi
10. Orijinal student, distilled student ve teacher çıktılarının karşılaştırılması
11. İsteğe bağlı Hugging Face Hub'a yükleme

## Değerlendirme

Notebook, eğitim öncesi ve sonrası student metriklerini (loss, KL, CE ve perplexity) izler. Ayrıca aynı test prompt'ları üzerinde şu modellerin ürettiği cevapları karşılaştırır:

- Orijinal Qwen2.5-0.5B-Instruct
- Damıtılmış Qwen2.5-0.5B-Instruct
- Qwen2.5-7B-Instruct teacher

Bu karşılaştırma nitel bir değerlendirmedir; tek başına kapsamlı benchmark veya model kalitesinin genel kanıtı olarak değerlendirilmemelidir.

## Çalıştırma

1. Notebook'u Google Colab'da aç.
2. GPU runtime seç (Colab Pro/Pro+ veya uygun GPU erişimi önerilir).
3. Hücreleri sırayla çalıştır.
4. Checkpoint'leri korumak için Google Drive seçeneğini açık tut.
5. GPU belleği yetersizse batch size'ı azalt, gradient accumulation'ı artır veya sequence length'i düşür.

> Teacher ve student'ın aynı tokenizer/vocabulary yapısıyla uyumlu olması gerekir. Farklı model aileleriyle denemeden önce tokenizer ve logits boyutlarının uyumunu kontrol et.

## Dosyalar

- `distil_qwen_colab.ipynb` — açıklamalı uçtan uca distillation notebook'u
