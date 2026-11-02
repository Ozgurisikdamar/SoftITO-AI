# Fine-Tuning

> SoftITO · İleri Seviye Yapay Zekâ Mühendisliği

Bu modül, büyük dil modellerini PEFT yöntemleriyle görev ve davranışa uyarlamaya yönelik uygulamalı fine-tuning çalışmalarını içerir.

## Notebook

- [Qwen3-8B Chatbot — LoRA Fine-Tuning (Google Colab / H100)](Qwen3-8B-LoRA-Chatbot.ipynb)

Notebook; Hugging Face dataset indirme, Qwen3-8B yükleme, BF16 + LoRA konfigürasyonu, SFT eğitimi, adapter kaydı ve inference testini kapsar.

## Çalıştırma

1. Notebook'u Google Colab'de aç.
2. Runtime türünü H100 GPU olarak seç.
3. Gerekirse Hugging Face model erişim koşullarını kabul edip Colab Secrets'e HF_TOKEN ekle.
4. Hücreleri sırayla çalıştır veya Run all kullan.
5. Fine-tuned LoRA adapter'ını Google Drive'a kaydet.

## Öğrenme hedefleri

- Full fine-tuning, LoRA ve QLoRA farklarını anlamak.
- Instruction/chat dataset formatını hazırlamak.
- Chat template ve causal language model training akışını uygulamak.
- Train/validation loss ile eğitim sürecini takip etmek.
- LoRA adapter'ını kaydetmek ve inference sırasında kullanmak.

## Önemli

İlk notebook, pipeline'ı çalıştırmak için genel sohbet dataset'i kullanır. Dataset'in Türkçe oranı veya chatbot'un hedeflenen davranışını karşılama garantisi yoktur. Gerçek kullanım öncesi veri lisansını, örnek kalitesini, dil/alan kapsamını ve model çıktısını değerlendirmek; gerekiyorsa hedefe özel kaliteli instruction verisi hazırlamak gerekir. Notebook full model değil, LoRA adapter üretir.
