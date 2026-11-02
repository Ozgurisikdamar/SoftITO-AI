# RAG — Retrieval-Augmented Generation

> SoftITO · İleri Seviye Yapay Zekâ Mühendisliği

Bu modül, gelişmiş bir RAG (Retrieval-Augmented Generation) pipeline'ını içerir. Notebook'ta belge yükleme, metadata, sentence-aware chunking, Türkçe BM25, multilingual dense retrieval, FAISS, RRF, cross-encoder reranking, MMR, multi-query, HyDE, chat memory, kaynaklı cevap üretimi ve Hit@k/MRR/faithfulness değerlendirmesi işlenir.

## Notebook

- **[Advanced_RAG.ipynb.gz](Advanced_RAG.ipynb.gz)** — yüklenen notebook'un temizlenmiş (çıktıları ve notebook widget metadata'sı kaldırılmış) gzip sıkıştırılmış kopyası.

### Notebook'u açma

1. GitHub'dan `Advanced_RAG.ipynb.gz` dosyasını indir.
2. Gzip'ten çıkar; `Advanced_RAG.ipynb` dosyasını elde et.
3. Google Colab veya Jupyter Notebook'a yükle.

## Kapsam

- TXT, Markdown, PDF ve DOCX yükleme
- Metadata ile filtreleme
- Sentence-aware chunking ve overlap
- Türkçe BM25 / sparse retrieval
- Multilingual embeddings ve dense retrieval
- FAISS / NumPy vector index
- Reciprocal Rank Fusion (RRF)
- Cross-encoder reranking
- Maximal Marginal Relevance (MMR)
- Multi-query, query condensation ve HyDE
- Yerel LLM entegrasyonu (Ollama / Transformers)
- Kaynak gösterimi ve abstention davranışı
- Conversation memory
- İndeks kaydetme / yeniden yükleme
- Hit@k, MRR ve LLM-as-judge faithfulness değerlendirmesi

## Dependencies

Notebook kurulum hücresi `sentence-transformers`, `faiss-cpu`, `scikit-learn`, `pypdf`, `python-docx`, `pandas`, `requests`, `transformers` ve `accelerate` paketlerini kurar.

> Demo bilgi tabanı kurgusaldır. Gerçek dokümanlarla çalışırken kaynak lisanslarını, gizlilik ve erişim kontrollerini gözetin.
