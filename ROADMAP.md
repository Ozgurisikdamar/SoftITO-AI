# 🗺️ AI Engineering Yol Haritası (2026)

> **Bu rota nereden başlıyor:** [`Python`](Python/README.md), [`SQL`](SQL/README.md), [`EDA`](EDA/README.md), [`ML`](ML/README.md), [`NLP`](NLP/README.md), [`RNN`](RNN/README.md) / [`LSTM`](LSTM/README.md) / [`GRU`](GRU/README.md) ve [`ETL-ELT`](ETL-ELT/README.md) klasörlerindeki temeller.
> Buradan **LLM/RAG sistemleri, otonom ajanlar, model özelleştirme (LoRA/QLoRA), bilgisayarlı görü ve üretim deployment**'ına geçiyoruz.

Bu depodaki yaklaşım aynı kalıyor: **Öğren → Uygula → Ölç → İyileştir.**
Bu rotada *Ölç* adımı opsiyonel değil — her modülün ölçülebilir bir çıktısı var. "Daha iyi hissettirdi" bir sonuç değildir.

---

## 📍 Mevcut durum → hedef

| Konu | Depoda bugün | Bu rotada eklenecek |
|---|---|---|
| Veri entegrasyonu | [`ETL-ELT/`](ETL-ELT/README.md) — `python_etl.py`, `sql_elt.sql`, üretim kontrol listesi | `ETL-ELT/airflow/` — Airflow 3 ile orkestrasyon, backfill, idempotency |
| Vektör arama | — | `Vector-DB/` — embedding, HNSW/IVF, hybrid search, rerank |
| RAG | [`NLP/`](NLP/README.md) — TF-IDF, metin sınıflandırma | `RAG/` — chunking, contextual retrieval, GraphRAG, ColPali |
| Değerlendirme | [`ML/`](ML/README.md) — `model_evaluation_and_regression.ipynb` | `Evaluation/` — RAGAS, LLM-as-a-judge, golden set, CI eşiği |
| Ajanlar | — | `Agents/` — LangChain v1, LangGraph, LlamaIndex, MCP |
| Model özelleştirme | [`RNN/`](RNN/README.md) · [`LSTM/`](LSTM/README.md) · [`GRU/`](GRU/README.md) — sıfırdan eğitim | `Fine-Tuning/` — PEFT, LoRA, QLoRA, DPO |
| Görü | [`ML/`](ML/README.md) — `image_classification_cnn.ipynb` | `Computer-Vision/` — YOLO26, SAM 2/3, tracking |
| Akış işleme | [`Big Data/`](Big%20Data/README.md) — batch (Hadoop, Spark) | `Streaming/` — Kafka, RTSP, gerçek zamanlı analitik |
| Üretken görü | — | `Generative-Vision/` — Diffusion, ControlNet, LoRA |
| Yayın | `Dockerfile`, `docker-compose.yml` | `Deployment/` — FastAPI, vLLM, Kubernetes |

> `Big Data/` batch tarafını, `Streaming/` ise aynı verinin **akan** halini kapsar. İkisi birbirinin alternatifi değil, tamamlayıcısı.

---

## ⚠️ 2026 güncellik notları

Bu rota, eğitim başlıklarının yazıldığı tarihten sonra değişen noktaları dikkate alır:

| Başlıkta yazan | Bugünkü durum | Karar |
|---|---|---|
| **YOLOv10** | Ultralytics **YOLO26** ve **YOLO11** yayınladı | YOLOv10 makalesini *kavram* için oku (NMS-free, çift atama); uygulamayı YOLO26 ile yap |
| **SAM** | **SAM 2** (video segmentasyonu), **SAM 3** (metin promptlu segmentasyon) | SAM 3 + SAM 2 kullan |
| **TGI** | Hugging Face **maintenance mode**'a aldı; vLLM/SGLang öneriyor | Tanı, üretimde **vLLM** kullan |
| **LangChain** | **v1.0** — `create_agent` + LangGraph runtime, `create_react_agent` deprecated | Eski tutorial'ların çoğu v0 API'si; resmi dokümandan git |
| **Airflow** | **3.x** — event-driven scheduling, Data Assets, DAG versioning | Kavramlar aynı; 3.0 farklarını ayrıca oku |

**Genel kural:** önce resmi doküman, sonra video/blog. Blog yazıları 6–18 ay geriden gelir ve API'ler değişir.

---

## 🧱 Modüller

### M0 — Ön koşullar
- `async/await`, type hints, `pydantic`, `pytest`, `uv` ile ortam yönetimi
- Linux/CLI: `ssh`, `tmux`, `nvidia-smi`; GPU/VRAM hesabı
- Transformer seviyesinde LLM: tokenization, attention, **KV cache**, context window, quantization (int8/int4/GGUF/AWQ)
- Deney disiplini: seed, config, Git branch/PR

**Kaynak:** [Karpathy — Zero to Hero](https://karpathy.ai/zero-to-hero.html) · [HF LLM Course](https://huggingface.co/learn/llm-course)
**Çıktı:** "7B model fp16'da kaç GB VRAM ister?" sorusunu KV cache dahil hesaplayabilmek (~14 GB + cache).

---

### M1 — ETL/ELT + Airflow ile Pipeline Yönetimi
- **Idempotency & incremental load:** watermark, upsert/merge, late-arriving data, backfill
- **Airflow temelleri:** DAG, Task, Operator, Hook, XCom, Connection, TaskFlow API (`@task`)
- **Airflow 3:** API Server, DAG versioning, event-driven scheduling, **Data Assets**, React UI
- **Scheduling:** `catchup`, `max_active_runs`, SLA, pool/slot, `TriggerRule`, dynamic task mapping
- **Executor'lar:** Local → Celery → **KubernetesPodOperator**
- **Test & gözlemlenebilirlik:** DAG parse testi, `dag.test()`, retry/alert, OpenLineage, dbt test / Great Expectations
- **AI pipeline özelinde:** embedding job, index rebuild, "veri güncellendi → yeniden indeksle" tetikleme

**Kaynak:** [Airflow Tutorial](https://airflow.apache.org/docs/apache-airflow/stable/tutorial/) · [Airflow 3 duyurusu](https://airflow.apache.org/blog/airflow-three-point-oh-is-here/) · [DE Zoomcamp](https://github.com/DataTalksClub/data-engineering-zoomcamp) · [Ansh Lamba — Airflow Full Course](https://www.youtube.com/watch?v=IiczxlbQb8s)
**Çıktı:** `ingest → dbt transform → embed & upsert` hattı; cold run ile backfill aynı sonucu üretiyor, 2 kez çalıştırınca duplike yok.

---

### M2 — Vektör Veritabanları ve Semantic Search
- Embedding uzayı: cosine/dot/L2, normalizasyon, boyut–kalite ödünleşimi
- Model seçimi: monolingual vs multilingual, matryoshka, latency/maliyet
- Chunking: fixed, recursive, semantic, structure-aware (PDF/Markdown), overlap, parent-child
- ANN indeksleri: **HNSW** (`M`, `efConstruction`, `efSearch`), **IVF**, **PQ/SQ**, DiskANN
- **Milvus** (standalone/distributed, partition key, scalar filter) · **Chroma** · Qdrant · pgvector · FAISS
- **Hybrid search:** BM25 + dense, **RRF**, alpha ağırlığı
- **Reranking:** cross-encoder, iki aşamalı retrieval (20 getir → 5'e indir)
- Operasyon: upsert/delete, collection versioning, shard/replica, `load`/`release`

**Kaynak:** [Milvus Docs](https://milvus.io/docs/quickstart.md) · [Milvus Bootcamp](https://milvus.io/bootcamp) · [Chroma Docs](https://docs.trychroma.com) · [MTEB Leaderboard](https://huggingface.co/spaces/mteb/leaderboard) · [FAISS Wiki](https://github.com/facebookresearch/faiss/wiki)
**Model:** `BAAI/bge-m3` (çok dilli + sparse + colbert), `intfloat/multilingual-e5-large`, `BAAI/bge-reranker-v2-m3`
**Çıktı:** Aynı 5.000 dokümanda HNSW parametrelerini değiştirip **recall@10 – p95 latency – RAM** eğrisi; hybrid vs saf dense karşılaştırması.

---

### M3 — İleri RAG Mimarileri ve Kurumsal Veri Entegrasyonu
- Naive → Advanced → Modular RAG evrimi; her aşamada ne bozuluyor
- **Query tarafı:** rewriting, HyDE, multi-query, step-back, decomposition, routing
- **Retrieval tarafı:** hybrid + rerank, sentence-window, parent-document, auto-merging, **contextual retrieval**
- **İleri yapılar:** RAPTOR (özet ağacı), GraphRAG, Self-RAG / CRAG, agentic RAG
- **Kurumsal:** PDF/taranmış belge ayrıştırma (`docling`, OCR), tablo çıkarma, **ColPali**, ACL/izin filtreleri, PII redaksiyonu
- **Üretim katmanı:** zorunlu atıf, "bilmiyorum" davranışı, structured output, semantic cache
- **Güvenlik:** prompt injection (retrieved doküman içinden), data exfiltration

**Kaynak:** [RAG_Techniques (30+ notebook)](https://github.com/NirDiamant/RAG_Techniques) · [DeepLearning.AI — Advanced RAG](https://www.deeplearning.ai/courses/building-evaluating-advanced-rag) · [Anthropic — Contextual Retrieval](https://www.anthropic.com/news/contextual-retrieval) · [GraphRAG](https://microsoft.github.io/graphrag/) · [Docling](https://github.com/docling-project/docling)
**Çıktı:** 200+ karışık dokümanda atıflı yanıt veren asistan; HotpotQA tipi 20 multi-hop soruda naive RAG'e karşı kazanç tablosu.

---

### M4 — Model Değerlendirme ve RAGAS
- Retrieval metrikleri: recall@k, precision@k, **MRR**, **nDCG@k**
- Klasik üretim metrikleri: BLEU, ROUGE, BERTScore — ve neden zayıf kaldıkları
- **RAG üçlüsü:** faithfulness/groundedness, answer relevance, context precision & recall
- **RAGAS:** `TestsetGenerator`, `evaluate()`, `experiment()`, custom metric
- **LLM-as-a-judge:** rubric, pozisyon bias'ı, judge modeli seçimi, insan anlaşması
- Alternatifler: DeepEval, TruLens, Arize Phoenix, LangSmith, promptfoo
- **CI'da eval:** golden dataset, eşik kontrolü, regresyon dashboard'u, token maliyeti

**Kaynak:** [RAGAS Docs](https://docs.ragas.io) · [Metrik listesi](https://docs.ragas.io/en/stable/concepts/metrics/available_metrics/) · [DeepEval](https://deepeval.com/docs/metrics-introduction) · [Phoenix](https://docs.arize.com/phoenix)
**Çıktı:** 50 soruluk golden set; naive / +rerank / +hybrid üç konfigürasyonun tablosu; GitHub Actions'ta `faithfulness < 0.85 → fail`.

---

### M5 — LangChain ve LlamaIndex ile Otonom Ajanlar
- Agent = **LLM + tools + loop + memory + policy**; agent ile workflow farkı
- Desenler: prompt chaining, routing, parallelization, orchestrator-worker, evaluator-optimizer
- **LangChain v1:** `create_agent`, middleware (guardrails, summarization, human-in-the-loop)
- **LangGraph:** State/Node/Edge, reducer, **checkpointer & durable execution**, `interrupt`, streaming, subgraph
- **LlamaIndex:** ingestion pipeline, `QueryEngine`, **Workflows** (`@step`)
- Tool tasarımı: net docstring, idempotent tool, hata mesajının modele dönmesi, 3–5 tool sınırı
- **MCP** (Model Context Protocol): server/client, tool + resource + prompt
- Güvenilirlik: retry, fallback model, timeout, cost cap, sonsuz döngü koruması
- Ajan değerlendirmesi: task success, trajectory/tool-call doğruluğu, adım ve maliyet

**Kaynak:** [LangChain v1](https://docs.langchain.com/oss/python/langchain/overview) · [LangGraph](https://docs.langchain.com/oss/python/langgraph/overview) · [LangChain Academy](https://academy.langchain.com) · [HF Agents Course](https://huggingface.co/learn/agents-course) · [Anthropic — Building Effective Agents](https://www.anthropic.com/research/building-effective-agents) · [MCP](https://modelcontextprotocol.io)
**Çıktı:** RAG + 2 tool + onay adımı (`interrupt`) olan ajan; 15 görevde **task success ≥ %70**, ≤ 6 adım, maliyet kaydı. Tek-agent vs multi-agent karşılaştırması.

---

### M6 — Fine-Tuning: PEFT, LoRA ve QLoRA
- Karar sırası: prompt → RAG → fine-tune → pretrain. Fine-tuning neyi **çözmez** (bilgi güncelleme, halüsinasyon)
- **LoRA** matematiği: ΔW = BA, `r`, `alpha`, `dropout`, hedef modüller
- **QLoRA:** NF4, double quantization, paged optimizer — 7B'yi 24 GB'da eğitmek
- Veri: chat template, kalite > miktar, dedup, contamination, **sentetik veri üretimi**
- Eğitim: LR schedule, effective batch, gradient checkpointing, packing, early stopping
- Araçlar: `trl` (`SFTTrainer`), **Unsloth** (2× hız), Axolotl, DeepSpeed/FSDP
- Alignment: SFT → **DPO** (ORPO/KTO) → GRPO; reward hacking
- Yayın: adapter merge, AWQ/GPTQ/GGUF, model card, vLLM'de multi-LoRA

**Kaynak:** [PEFT](https://huggingface.co/docs/peft) · [TRL](https://huggingface.co/docs/trl) · [smol-course](https://huggingface.co/learn/smol-course) · [Raschka — Practical Tips for LoRA](https://magazine.sebastianraschka.com/p/practical-tips-for-finetuning-llms) · [Unsloth notebooks](https://github.com/unslothai/notebooks) · [LoRA](https://arxiv.org/abs/2106.09685) · [QLoRA](https://arxiv.org/abs/2305.14314)
**Model:** `Qwen/Qwen3-4B-Instruct-2507`, `Qwen/Qwen3-8B`, `meta-llama/Llama-3.2-3B-Instruct`, `google/gemma-3-4b-it`
**Çıktı:** 4B model QLoRA ile alan verisinde eğitilir → merge → AWQ → vLLM'de servis; base vs FT blind eval; `r=8` vs `r=64` ablasyonu.

---

### M7 — Bilgisayarlı Görü: YOLO ve SAM
- Görev ayrımı: detection / instance seg / semantic seg / pose / OBB / tracking
- YOLO evrimi: v8 → v10 (NMS-free) → v11 → **YOLO26**; label assignment, decoupled head
- Eğitim: `data.yaml`, mosaic/mixup, `imgsz`, AMP, EMA, transfer learning
- Metrikler: IoU, mAP50, **mAP50-95**, PR eğrisi, per-class hata analizi
- Küçük nesne, sınıf dengesizliği, hard negative mining
- Export: ONNX, TensorRT, OpenVINO — FP16/INT8 latency vs mAP
- **SAM 3 / SAM 2:** point/box/text prompt, zero-shot, video mask propagation
- **YOLO + SAM birlikte:** kutu → hassas maske (auto-labeling)

**Kaynak:** [Ultralytics Docs](https://docs.ultralytics.com/) · [YOLO26](https://docs.ultralytics.com/models/yolo26) · [SAM 3](https://docs.ultralytics.com/models/sam-3) · [YOLOv10 makalesi](https://arxiv.org/abs/2405.14458) · [SAM 2 repo](https://github.com/facebookresearch/sam2) · [Roboflow Universe](https://universe.roboflow.com)
**Çıktı:** 500–1000 görüntülük kendi veri setin; YOLO26n eğitimi; mAP50-95 baseline+%10; TensorRT latency tablosu; YOLO kutularıyla SAM maske IoU karşılaştırması.

---

### M8 — Gerçek Zamanlı Video Analitiği
- Video I/O: RTSP/RTMP/HLS, GStreamer, frame dropping, buffer yönetimi
- Tracking: **ByteTrack**, **BoT-SORT**, Kalman + Hungarian, ID switch
- Zone/line logic: polygon zone, line crossing, dwell time, heatmap ([`supervision`](https://github.com/roboflow/supervision))
- Streaming mimarisi: Kafka/Redpanda → consumer → inference → sink; backpressure
- Performans: batch inference, NVDEC, half precision, frame sampling
- NVIDIA **DeepStream** pipeline (`nvstreammux → nvinfer → nvtracker`)
- Olay üretimi: rule engine, alert throttling, N-of-M filtresi, kamera bazlı shard
- Edge vs cloud: Jetson, ONNX Runtime, bant genişliği

**Kaynak:** [Ultralytics Track](https://docs.ultralytics.com/modes/track) · [ByteTrack](https://github.com/ifzhang/ByteTrack) · [DeepStream SDK](https://developer.nvidia.com/deepstream-sdk) · [Confluent Kafka Courses](https://developer.confluent.io/courses/)
**Çıktı:** 2 kamera simülasyonu → Kafka → YOLO+ByteTrack → zone event → Postgres + WebSocket dashboard; **≥ 25 FPS**, p95 < 200 ms, event dedup.

---

### M9 — Generative Vision: Diffusion ve Kontrol Teknikleri
- Diffusion temelleri: forward/reverse, noise schedule, DDPM → DDIM → DPM-Solver
- Latent diffusion & VAE; text encoder (CLIP/T5), **CFG**, negative prompt
- Modeller: SD 1.5, SDXL, **SD 3.5**, **FLUX.1** (rectified flow) — VRAM farkları
- **ControlNet:** canny, depth, openpose, segmentation, lineart + Union modelleri
- **IP-Adapter**, reference-only, inpainting/outpainting, img2img + denoise
- **LoRA / DreamBooth:** stil, karakter, konsept; captioning kalitesi
- Hızlandırma: LCM/Turbo/Lightning, distillation, `torch.compile`
- Değerlendirme: FID, CLIPScore, prompt adherence; lisans (FLUX dev non-commercial)

**Kaynak:** [HF Diffusion Course](https://huggingface.co/learn/diffusion-course) · [Diffusers](https://huggingface.co/docs/diffusers) · [ControlNet rehberi](https://huggingface.co/docs/diffusers/using-diffusers/controlnet) · [ControlNet](https://github.com/lllyasviel/ControlNet) · [ComfyUI](https://github.com/comfyanonymous/ComfyUI) · [ControlNet makalesi](https://arxiv.org/abs/2302.05543)
**Çıktı:** Ürün fotoğrafı → OpenPose/Canny ControlNet → 4 farklı sahnede tutarlı görsel; 25 görselli karakter LoRA'sı; ComfyUI workflow'unun API'leştirilmesi.

---

### M10 — Konteynerizasyon: Docker ve Kubernetes
- Docker: image/layer, multi-stage build, `.dockerignore`, cache
- GPU container: `nvidia-container-toolkit`, `--gpus all`, CUDA base image seçimi
- Compose: api + vektör DB + redis + worker, healthcheck, volume, network
- K8s: Pod, Deployment, Service, Ingress, ConfigMap, Secret
- Kaynak: requests/limits, **GPU scheduling** (`nvidia.com/gpu`), node selector/taint
- Scale: HPA, liveness/readiness/startup probe, rolling update, PDB
- State: PVC, StatefulSet, Helm; Job/CronJob (batch embedding, model export)
- Serving: **KServe**, Ray Serve, BentoML; Prometheus/Grafana

**Kaynak:** [Docker Get Started](https://docs.docker.com/get-started/) · [Kubernetes Tutorials](https://kubernetes.io/docs/tutorials/) · [MLOps Zoomcamp](https://github.com/DataTalksClub/mlops-zoomcamp) · [NVIDIA device plugin](https://github.com/NVIDIA/k8s-device-plugin) · [KServe](https://kserve.github.io/website/)
**Çıktı:** `docker compose up` ile API + Milvus + Redis + worker; kind/minikube'a deploy; HPA 2→5; GPU pod schedule; image boyutu %50 küçültme.

---

### M11 — FastAPI ile Yüksek Performanslı Inference Servisleri
- FastAPI: routing, Pydantic v2, dependency injection, `async def` vs `def` (threadpool tuzağı)
- **Streaming:** `StreamingResponse`, SSE, WebSocket
- Model yükleme: lifespan, singleton, `torch.no_grad()`, `bfloat16`, `torch.compile`
- **Dynamic batching:** queue, `max_batch_size` / `max_wait_ms`, GPU utilization
- Performans: `uvicorn --workers`, uvloop, orjson, connection pooling, `locust`/`k6`
- Güvenlik: input validation, max token, rate limit, API key/JWT, timeout
- Güvenilirlik: circuit breaker, graceful shutdown, health/readiness
- Gözlemlenebilirlik: structured log, OpenTelemetry, Prometheus (latency, queue, GPU util)
- API tasarımı: `/v1` versiyonlama, OpenAI-uyumlu şema, `429` + `Retry-After`

**Kaynak:** [FastAPI Tutorial](https://fastapi.tiangolo.com/tutorial/) · [Async/concurrency](https://fastapi.tiangolo.com/async/) · [Deployment](https://fastapi.tiangolo.com/deployment/) · [OpenTelemetry Python](https://opentelemetry.io/docs/languages/python/) · [Locust](https://docs.locust.io)
**Çıktı:** `/v1/chat` (SSE), `/v1/embed` (batch), `/v1/detect`; 50 RPS'te p95 < 500 ms; batching açık/kapalı throughput farkı tablosu.

---

### M12 — Model Deployment: vLLM ve TGI
- Problem: KV cache patlaması, memory fragmentation, değişken uzunlukta batch
- **vLLM:** **PagedAttention**, continuous batching, prefix caching, chunked prefill, speculative decoding
- `vllm serve`: `--tensor-parallel-size`, `--max-model-len`, `--gpu-memory-utilization`, `--quantization`
- **LoRA serving:** `--enable-lora`, `--lora-modules`, çoklu adapter
- Structured output: guided decoding / JSON schema / grammar
- Alternatifler: **SGLang** (RadixAttention), TGI (maintenance mode), TensorRT-LLM, llama.cpp
- Kapasite planlama: VRAM, eşzamanlı istek, tokens/sec, **TTFT** vs **TPOT**
- K8s'te serving: model cache PVC, KEDA queue-based autoscaling, warm-up
- Maliyet: model router (küçük → büyük), semantic cache, FP8/AWQ
- Benchmark: `vllm bench serve`, concurrency sweep

**Kaynak:** [vLLM Docs](https://docs.vllm.ai) · [OpenAI-uyumlu server](https://docs.vllm.ai/en/stable/serving/online_serving/) · [LoRA](https://docs.vllm.ai/en/stable/features/lora/) · [PagedAttention makalesi](https://arxiv.org/abs/2309.06180) · [SGLang](https://docs.sglang.ai) · [TGI (maintenance)](https://huggingface.co/docs/text-generation-inference)
**Çıktı:** Fine-tune modeli vLLM'de; concurrency 1/8/32/64 için throughput + TTFT + TPOT tablosu; AWQ vs fp16; 2 adapter'lı multi-LoRA servisi.

---

### M13 — Capstone: uçtan uca sistem
Tek bir ürün seç; modül listesi değil, **çalışan sistem** teslim et.

```text
Airflow (ingest + reindex) → ayrıştırma (docling/OCR) → chunking → bge-m3 → Milvus (hybrid)
  → rerank → LangGraph agent (RAG + SQL + web tool) → FastAPI (SSE)
  → vLLM (Qwen3-8B + LoRA) → Docker → K8s → RAGAS eval + trace
```

**Teslim:** mimari diyagram, ölçüm tabloları (latency / kalite / maliyet), `docker compose up` ile çalışan repo, karar günlüğü ("neden Milvus, neden bge-m3, neden vLLM").

---

## 📅 16 haftalık takvim

| Hafta | Modül | Odak | Çıktı |
|---|---|---|---|
| 1 | M0 | Python/async, transformer, VRAM hesabı | Ortam + mini GPT notebook |
| 2 | M1 | Airflow 3 temelleri | 3 DAG'lık hat |
| 3 | M1 | dbt, backfill, K8s executor | Incremental + test |
| 4 | M2 | Embedding + HNSW | Recall/latency eğrisi |
| 5 | M2 | Milvus vs Chroma, hybrid + RRF | Karşılaştırma raporu |
| 6 | M3 | Chunking, rerank, query rewriting | RAG v1 |
| 7 | M3 | GraphRAG/RAPTOR, ColPali, ACL | RAG v1.5 |
| 8 | M4 | RAGAS, LLM-judge, golden set | Eval pipeline + CI gate |
| 9 | M5 | LangChain v1 + LangGraph | Tool'lu ajan |
| 10 | M5 | LlamaIndex, MCP, multi-agent | Ajan değerlendirmesi |
| 11 | M6 | LoRA/QLoRA teorisi + ilk eğitim | Adapter v1 |
| 12 | M6 | DPO, merge, quantize, vLLM | Yayınlanmış model |
| 13 | M7 | YOLO26 + SAM 3 | Kendi detector'ın |
| 14 | M8 | Tracking + Kafka + zone logic | Canlı demo |
| 15 | M9 | Diffusion + ControlNet + LoRA | Görsel pipeline |
| 16 | M10–M12 | Docker, K8s, FastAPI, vLLM bench | Uçtan uca deploy |

> Sıkıştırmak gerekirse: M1 ve M9 ertelenebilir. **M2 → M3 → M4 → M5 → M6 → M12** omurgası atlanmaz.

---

## 🖥️ Donanım planı

| Modül | GPU | Not |
|---|---|---|
| M0–M5 (RAG, ajan) | Gerekmez | Colab free / lokal CPU + API modelleri yeter |
| M6 (QLoRA 4B) | 16–24 GB | A10 / L4 sınıfı, 1–2 saat |
| M6 (QLoRA 7B) | 24–48 GB | Grad checkpointing + 4-bit şart |
| M7 (YOLO eğitimi) | 16–24 GB | Küçük model, ~100 epoch |
| M9 (SDXL LoRA) | 24 GB | FLUX için 40 GB+ |
| M12 (vLLM bench) | 24 GB+ | 8B fp16 ≈ 16 GB + KV cache |

**Kurallar:** spot/preemptible kullan · checkpoint'ı persistent volume'a yaz · `tmux`/`nohup` · iş bitince instance'ı kapat · her deneyi config + seed ile kaydet · model indirmeyi bir kez yapıp cache'le (`HF_HOME`).

---

## 📚 Kaynak kütüphanesi

**Kurslar (ücretsiz):** [HF LLM](https://huggingface.co/learn/llm-course) · [HF Agents](https://huggingface.co/learn/agents-course) · [HF smol-course](https://huggingface.co/learn/smol-course) · [HF Diffusion](https://huggingface.co/learn/diffusion-course) · [HF Computer Vision](https://huggingface.co/learn/computer-vision-course) · [DE Zoomcamp](https://github.com/DataTalksClub/data-engineering-zoomcamp) · [MLOps Zoomcamp](https://github.com/DataTalksClub/mlops-zoomcamp) · [LangChain Academy](https://academy.langchain.com) · [DeepLearning.AI short courses](https://www.deeplearning.ai/short-courses/)

**Blog / newsletter:** [Anthropic Engineering](https://www.anthropic.com/engineering) · [Lilian Weng](https://lilianweng.github.io) · [Ahead of AI (Raschka)](https://magazine.sebastianraschka.com) · [vLLM Blog](https://blog.vllm.ai) · [Pinecone Learn](https://www.pinecone.io/learn/)

**YouTube:** Karpathy (LLM sıfırdan) · TechWorld with Nana (Docker/K8s) · Darshil Parmar (data engineering) · Roboflow (CV) · Ultralytics (YOLO) · LangChain / LlamaIndex (agent) · Hugging Face (yeni modeller)

**Veri setleri:** SQuAD 2.0, MS MARCO, HotpotQA (multi-hop) · CUAD, FinanceBench (kurumsal doküman) · COCO, VisDrone, MOT17 (görü) · Dolly-15k, UltraChat-200k (fine-tuning) · Turkish Wikipedia, Trendyol yorumları (Türkçe)

---

## 🇹🇷 Türkçe'ye özel notlar

1. **Embedding seçimi kritik.** İngilizce modellerle (`bge-small-en` vb.) Türkçe RAG kurulmaz. `BAAI/bge-m3` veya `intfloat/multilingual-e5-large` ile başla; kaliteyi [TR-MTEB](https://aclanthology.org/2025.findings-emnlp.471/) ile doğrula.
2. **Token maliyeti.** Türkçe aglütinatif olduğu için aynı metin İngilizce'ye göre ~%30–50 daha fazla token harcar. Context ve maliyet hesaplarını buna göre yap.
3. **Chunking.** Ekler yüzünden kelime tabanlı chunk'lar bozulur; noktalama + markdown yapısına dayalı bölme kullan.
4. **Sentetik veri.** Türkçe instruction verisi az; kendi alanında Qwen3/Llama ile 5–10k sentetik QA üret, insanla filtrele. Fine-tuning'de en büyük kazanç buradan gelir.
5. **Uyum / KVKK.** Veri yurt dışına çıkmayacaksa **on-prem vLLM + self-hosted Milvus**; PII redaksiyonu (`presidio`) ve audit log zorunlu.

---

## 🚫 Sık yapılan hatalar

1. **Fine-tuning ile başlamak.** Bilgi eklemek istiyorsan cevap RAG'dir; fine-tuning *davranış/format* değiştirir.
2. **Chunking'i önemsememek.** RAG kalitesinin büyük kısmı chunking + retrieval'da. Reranker olmadan ileri mimariye geçmemek.
3. **Eval seti olmadan iyileştirme yapmak.** 50 soruluk golden set ilk hafta kurulur.
4. **Yüksek `top_k`.** Gürültü, maliyet ve "lost in the middle" artar. 20 getir, 5'e indir.
5. **Ajan'a 15 tool vermek.** 3–5 tool + net açıklama neredeyse her zaman daha iyi.
6. **`async def` içinde bloklayan model çağrısı.** FastAPI'yi tek istekte kilitlersin.
7. **vLLM'de `--gpu-memory-utilization 0.98` + uzun `--max-model-len`.** OOM. KV cache'e pay bırak.
8. **K8s'e `nvidia.com/gpu: 1` yazmadan GPU pod'u göndermek.** Schedule olmaz.
9. **Spot instance'ta checkpoint'ı diske yazmamak.** Saatlerce emek gider.
10. **Sadece tutorial takip etmek.** Her modülde kendi verinle bir varyant yap.

---

## 🤝 Bu dosya nasıl güncellenir

- Bu dosya **üst harita**; her modül kendi klasörünün `README.md` dosyasında ayrıntılanır (mevcut klasörlerdeki düzenle aynı).
- Bir modül tamamlandığında `📍 Mevcut durum → hedef` tablosundaki satırı **eklendi** olarak işaretle ve klasör bağlantısını ver.
- Kaynak seçerken **resmi dokümanı** öncele; blog/video ikincil kalsın.
- Ölçüm çıktısı olmayan modül "tamamlandı" sayılmaz.

---

<sub>Son güncelleme: 2026-10 · Kapsam: AI Engineering (RAG · Agents · Fine-Tuning · CV · Deployment)</sub>
