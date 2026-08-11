# Learning Plan: LLMs & Embedded Firmware Engineering

*Prepared for: Telecom C++ developer (UDM/UDR 5G core) transitioning to firmware, while building deep LLM knowledge*

---

# Part 1: LLMs — From Math Foundations to Working Internals

## Phase 0 — Prerequisite Mathematics (4–6 weeks)

Don't do a full math degree — learn the *subset* that appears in ML papers.

| Topic | What to cover | Best resources |
|---|---|---|
| Linear Algebra | Vectors, dot products, matrices, matrix multiply, eigenvalues/SVD, norms | 3Blue1Brown "Essence of Linear Algebra"; Strang MIT 18.06 (Lectures 1–20) |
| Calculus | Derivatives, partial derivatives, chain rule, gradients, Jacobians | 3Blue1Brown "Essence of Calculus"; Karpathy's micrograd (this IS the chain rule) |
| Probability | Distributions, Bayes, expectation/variance, MLE, conditional probability | Deisenroth ch. 6 (math-first, ML-focused) · StatQuest playlist (intuition, distributions/Bayes/MLE) · Blitzstein Harvard **Stat 110** (free videos + "Introduction to Probability" — rigorous depth) · MIT 6.041 (Bertsekas & Tsitsiklis) notes for exercises |
| Information Theory | Entropy, cross-entropy, KL divergence, perplexity | Jurafsky & Martin ch. 3 · 3Blue1Brown "Coding Theory" series (entropy visualized) · MacKay "Information Theory, Inference, and Learning Algorithms" ch. 1–6 (free PDF — the classic ML↔info-theory bridge) |
| Optimization | Gradient descent, SGD, Adam, backprop | Karpathy "Neural Networks: Zero to Hero" videos 1–3 |

**Milestone:** Watch 3Blue1Brown's *Neural Networks* series end-to-end. Then implement backprop from scratch by coding along with Karpathy's `micrograd` (100 lines of Python).

## Phase 1 — History: The Problems That Drove LLMs (2–3 weeks)

This is the most underrated part — understanding *why* each architecture emerged explains the architecture itself. Build a mental timeline:

1. **1950s–60s** — Symbolic/rule-based NLP (Chomsky's grammars, ELIZA). Problem: hand-crafted rules don't scale; language resists formalization.
2. **1970s–90s** — Statistical NLP returns: n-grams, HMMs, IBM alignment models for MT. Problem: **data sparsity / curse of dimensionality** — most n-grams never appear in any corpus.
3. **2000s** — Discriminative models (log-linear, SVMs), and the *distributional hypothesis* ("you shall know a word by the company it keeps").
4. **2013–14** — `word2vec`/GloVe: dense embeddings. Problem solved: meaning as vectors instead of sparse counts. Problem created: embeddings are static, context-free.
5. **2014–15** — Seq2seq + LSTMs, then **attention** (Bahdanau 2015). Problem solved: fixed-length context bottleneck in RNNs; long-range dependencies (vanishing/exploding gradients).
6. **2017** — **Transformer** ("Attention Is All You Need"). Problem solved: RNNs can't parallelize over sequence length.
7. **2018–2020** — ELMo → BERT (encoder, bidirectional) → GPT (decoder, autoregressive). Pretrain-then-finetune paradigm.
8. **2020–2022** — GPT-3, scaling laws, InstructGPT/ChatGPT: **alignment** becomes the central problem (models know things but don't follow instructions; hallucinate).
9. **2023–now** — Alignment (RLHF/DPO), long context, multimodality, agents, inference efficiency (KV cache, quantization).

**Resources:** Jurafsky & Martin ch. 1–2; "The History of NLP" talks; Jay Alammar's blog timeline; the three landmark papers (Bahdanau 2015, Attention Is All You Need, Language Models are Unsupervised Multitask Learners).

## Phase 2 — How LLMs Work: Architecture (3–5 weeks)

**Conceptual layer:**
- Tokenization (BPE/WordPiece/SentencePiece) — why "token" ≠ "word"
- Embeddings + positional encodings (sinusoidal → RoPE → ALiBi)
- Attention: Q/K/V, scaled dot-product, multi-head; why it's "soft lookup"
- Transformer block: attention + FFN + residual connections + LayerNorm; encoder-decoder vs decoder-only
- Pre-training objective: next-token prediction, cross-entropy loss, perplexity

**Resources (in order):**
1. 3Blue1Brown "Deep Learning" + **"But what is a GPT?"** series (best conceptual intro, period)
2. Jay Alammar — "The Illustrated Transformer" and "How GPT3 Works"
3. Harvard NLP — "The Annotated Transformer"
4. The Transformer paper itself (read *after* the above)

**Milestone (do this — it's the single highest-value exercise):** Code along with Karpathy's **"Let's build GPT: from scratch"** video / `nanoGPT`. You'll implement attention, a transformer block, and train a small model. If you understand that 3-hour video, you understand how GPT works.

## Phase 3 — Training, Alignment, and Inference (3–5 weeks)

- **Pre-training:** data pipelines, batching, mixed precision, distributed training (DDP), scaling laws (Kaplan/Chinchilla), compute costs
- **Post-training:** instruction tuning (SFT), RLHF (reward model, PPO), DPO — and *why* alignment is needed
- **Inference:** autoregressive decoding, KV cache, sampling (temperature, top-k, top-p), quantization (GPTQ, AWQ, GGUF), speculative decoding
- **Using models:** prompt engineering, RAG, fine-tuning with LoRA, function calling / agents

**Milestones:**
1. Run a small open model locally (Llama-3.2-3B or Qwen-2.5) via `llama.cpp`/Ollama — inspect tokenization and sampling in real time
2. Fine-tune a model with LoRA on a small dataset (Hugging Face PEFT)
3. Build a RAG pipeline (chunking → embeddings → vector store → retrieval → generation)

**Ongoing reference:** Hugging Face NLP Course, Karpathy "Intro to LLMs" (1-hour survey), "Speech and Language Processing" ch. 11 (transformers).

## Overall LLM Track Timeline

| Phase | Duration | Output |
|---|---|---|
| Math | 4–6 wks | micrograd implemented |
| History | 2–3 wks | Timeline essay you could explain to a colleague |
| Architecture | 3–5 wks | nanoGPT trained from scratch |
| Training/Inference/Usage | 3–5 wks | LoRA fine-tune + RAG app |
| **Total** | **~4–5 months** (10–12 hrs/wk) | |

---

# Part 2: Embedded Firmware Engineering

## The Mindset Shift (read this first)

Your UDM/UDR work is: Linux servers, gigabytes of RAM, STL, dynamic allocation, high-level C++ abstractions, concurrency via OS threads, and "slow" real-time (ms tolerance on request handling).

Firmware is the inverse:
- **No OS or a tiny RTOS** — you are the OS
- **KBs–MBs of RAM**, static allocation, no STL/heap by default
- **Registers and memory-mapped I/O** instead of APIs — you configure hardware by writing bits
- **Hard real-time** — ISRs with microsecond deadlines
- **C, not C++** — most production firmware is C; embedded C++ exists but without exceptions, RTTI, or the STL

**What transfers from telecom:** strong C++/C fundamentals, debugging discipline, reading large codebases, version control, testing culture, and networking domain knowledge (useful if you target modem/RAN firmware, which leverages your 5G core experience).

**What you must learn new:** hardware interaction, bit manipulation, interrupt handling, memory maps, linker scripts, real-time scheduling, toolchains without an IDE crutch.

---

## Phase 1 — C for Embedded + Digital Basics (3–4 weeks)

- **C, not C++:** K&R or "21st Century C". Focus: pointers (pointer-to-pointer, function pointers, pointer arithmetic), `volatile`, bitwise ops, memory layout (stack/heap/static), structs + padding/alignment, `const` correctness
- **"Deep C"** (dunkels/pointers course) for the memory model
- **Digital fundamentals:** binary/hex, two's complement, fixed-point arithmetic, logic gates, flip-flops, clocks — "Code: The Hidden Language" (Petzold) if you want the fun version
- **Computer architecture:** "Computer Organization and Design" (Patterson & Hennessy) — you only need ch. 1–4 (CPU, memory hierarchy, buses); or Crash Course Computer Science (YouTube) episodes on CPU/memory

**Milestone:** Write a small C program using only static memory + bit manipulation (e.g., a software I2C bit-bang in C running on your laptop, or an emulated 8-bit CPU in C).

## Phase 2 — ARM Cortex-M Architecture & a Real Board (6–8 weeks)

Pick **STM32F4 Nucleo** (best docs/community) — or RP2040/ESP32 as alternatives.

- **Book:** "The Definitive Guide to ARM Cortex-M3 and M4" by Joseph Yiu — read ch. 1–9 (registers, memory map, interrupts/NVIC, SysTick). This is your bible.
- **Peripherals to master (in order):** GPIO → UART → SysTick/timers → interrupts → SPI → I2C → ADC → DMA
- **Learn to read datasheets & reference manuals** — this is a core skill; the STM32 reference manual will become your most-used document
- **Toolchain:** `arm-none-eabi-gcc`, OpenOCD + GDB, Makefiles, linker scripts, startup files

**Crucial advice:** do NOT start with the HAL (STM32Cube's hardware abstraction layer) — it hides everything you're trying to learn. First do **bare-metal register-level programming**: write your own startup file, blink an LED by setting `GPIOx->ODR` bits directly, then UART echo via interrupts, then timers.

**Resources:** Vivonomicon "Bare-Metal STM32" blog series; edX "Embedded Systems" (UT Austin); Udemy Fastbit STM32 courses (skip the HAL parts initially); "Programming Embedded Systems" (Barr).

**Milestones:**
1. Bare-metal LED blink (register access, no HAL) with custom linker script
2. UART TX/RX with interrupts (echo + command parsing)
3. I2C temperature sensor read → print over UART
4. Timer/PWM → servo or LED fade; ADC → read a potentiometer

## Phase 3 — RTOS & Real-Time Concepts (4–6 weeks)

- **Concepts:** tasks, scheduling (priorities, preemption), context switching, deadlines, latency, priority inversion, ISR vs task boundaries, blocking vs busy-wait
- **FreeRTOS** (the industry default): tasks, queues, semaphores, mutexes, event groups, ISR-safe APIs, software timers
- **Book:** "Mastering the FreeRTOS Real Time Kernel" (free official PDF) + Valvano's "Real-Time Interfacing to ARM Cortex-M"
- **Patterns:** producer-consumer (ISR → queue → task), watchdog design, state machines

**Milestone:** Multi-task system — ADC sampling task → queue → processing task → UART logger task, with a watchdog. Add a priority inversion scenario and fix it with mutexes — you'll now *feel* real-time in a way OS threads never taught you.

## Phase 4 — Your Telecom Superpower: Connectivity (4–6 weeks, optional but recommended)

Your 5G core background is a genuine differentiator here — modem/firmware teams struggle to find people who understand both L2/L3 protocol stacks *and* firmware.

- **Embedded networking:** lwIP (TCP/IP stack), mbedTLS, MQTT, AT-command modems
- **Cellular path:** NB-IoT/LTE-M modules (e.g., Quectel), then dig into LTE/5G **L1 PHY / L2 protocol stack** firmware roles — DSP, HARQ, scheduling. Your UDM/UDR knowledge maps directly to the "core side" of these products
- **Project:** ESP32 + lwIP/MQTT publishing sensor data; or an STM32 + Quectel modem doing a cellular publish

## Phase 5 — Industry Professionalism (ongoing)

- **MISRA C** — the embedded coding standard; run cppcheck/Clang-Tidy
- **Unit testing:** Unity + Ceedling (C test framework), mocks, CI pipeline — your telecom testing discipline is a huge asset
- **Bootloaders & OTA:** write a custom bootloader (flash layout, vector table relocation, jumping to app), then OTA update
- **Debugging at scale:** logic analyzers, oscilloscope basics, `coredump`/hard-fault handlers
- **Optional C++ in firmware:** embedded C++ guidelines (no exceptions/RTTI/STL, placement new) — "Embedded C++" (Sutter's guidelines)

---

## Overall Embedded Track Timeline

| Phase | Duration | Output |
|---|---|---|
| C + digital/arch basics | 3–4 wks | Bit-level C projects |
| Cortex-M + bare-metal | 6–8 wks | Register-level peripherals working |
| RTOS | 4–6 wks | Multi-task + queue system |
| Connectivity (optional) | 4–6 wks | lwIP/MQTT or cellular project |
| Industry practices | ongoing | MISRA, Ceedling CI, bootloader+OTA |
| **Total to job-ready** | **~6–8 months** (10–12 hrs/wk) | Portfolio of 6–8 hardware projects |

## Suggested First 90 Days (both tracks combined)

- **Weeks 1–4:** 3Blue1Brown math/neural nets + Karpathy micrograd (mornings); C pointers/bit-manip + ARM book ch. 1–4 (evenings)
- **Weeks 5–8:** Transformer concept layer (Alammar + Annotated Transformer); STM32 Nucleo + bare-metal register GPIO/UART
- **Weeks 9–12:** nanoGPT coding-along; interrupts + I2C/SPI sensors
