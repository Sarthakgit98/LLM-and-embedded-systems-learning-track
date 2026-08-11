# Learning Plan Progress Tracker

*Tick items off as you complete them. Suggested pace: 10–12 hrs/week.*

---

# 🧠 LLM Track

## Phase 0 — Prerequisite Mathematics (target: weeks 1–4)

**Linear Algebra**
- [x] 3Blue1Brown "Essence of Linear Algebra" (all videos)
- [x] Dot products, matrix multiplication — comfortable by hand *(practice set A–D done; SVD/duality/column-space deep-dives done)*
- [x] Eigenvalues / SVD — conceptual understanding *(incl. MᵀM trick, U/V recipe, applications)*
- [ ] Strang MIT 18.06 lectures 1–20 (optional deep-dive)

**Calculus**
- [ ] 3Blue1Brown "Essence of Calculus" (all videos) — *in progress: videos 1–4 done (derivative paradox, geometric formulas x²/1/x/√x/sin, product & chain rules). Summary page: `Calculus/calculus-phase0-summary.html` (interactive secant demo + worked examples). Next: video 5 (e)*
- [ ] Chain rule — can derive backprop by hand *(mechanics down: product rule = two strips, chain rule = nested zoom; examples incl. sin(x²) & √(x²+1) done)*

**Probability & Information Theory**
- [ ] Distributions, Bayes, expectation, MLE
- [ ] Entropy, cross-entropy, KL divergence, perplexity (Jurafsky & Martin ch. 3)

**Optimization**
- [ ] Gradient descent / SGD / Adam concepts

**🏁 Milestone: micrograd implemented** (Karpathy video 3, ~100 lines Python)
- [ ] `micrograd` coded from scratch and trained a tiny net

---

## 📋 Linear Algebra Review Checklist (tomorrow)

> Summary doc: `LinearAlgebra/linear-algebra-phase0-summary.html` — skim sections 1–9, then hit these:

**Quick re-derivations (by hand, no notes):**
- [ ] Matrix × vector: compute Av for [[1,2],[3,4]]·(5,6) both row-view and column-view — same answer?
- [ ] det(AB) = det(A)·det(B) on a 2×2 pair
- [ ] cos θ from a dot product (u=(1,2), v=(3,1) → 45°)
- [ ] Write the SVD recipe from memory (MᵀM → V & σ²; U = Mv/σ)

**Conceptual recall (explain out loud):**
- [ ] Why "basis" has many sets but one dimension; why unique representation matters
- [ ] Column space = range; Ax = b solvable ⟺ b ∈ column space; uniqueness ⟺ kernel
- [ ] Why det = 0 ⟺ squished (columns collinear ⟹ zero volume)
- [ ] Duality: why the vector (2,3) is perpendicular to level lines 2x+3y=c
- [ ] Why Vᵀ (not V) expresses a vector in V's frame (V moves it; Vᵀ re-describes it)
- [ ] Why MᵀM cancels U and why symmetry guarantees perpendicular SVD axes
- [ ] Why a shear's SVD axes are hidden (circle → tilted ellipse; perpendicularity preserved on V's/U's columns)

**Run (5 min, in Python):**
- [ ] `U, S, Vt = np.linalg.svd([[1,2],[2,4]])` → observe σ = (5, 0); connect zero σ to rank 1 & column space line y=2x

---

## Phase 1 — History of NLP & LLMs (target: weeks 5–6)

- [ ] Symbolic era: Chomsky grammars, ELIZA — why rules failed
- [ ] Statistical era: n-grams, HMMs — data sparsity problem
- [ ] word2vec / GloVe: distributional hypothesis
- [ ] Seq2seq + LSTMs: long-range dependency problem
- [ ] Bahdanau attention (2015) paper skim
- [ ] "Attention Is All You Need" (2017) paper — full read
- [ ] BERT vs GPT: encoder vs decoder paths
- [ ] Scaling laws + InstructGPT/ChatGPT: alignment problem

**🏁 Milestone: can explain the full timeline** (history of problems → solutions) to a colleague

---

## Phase 2 — Transformer Architecture (target: weeks 6–10)

**Conceptual layer**
- [ ] 3Blue1Brown "Deep Learning" + "But what is a GPT?" series
- [ ] Jay Alammar — "The Illustrated Transformer"
- [ ] Tokenization: BPE/WordPiece/SentencePiece — why token ≠ word
- [ ] Embeddings + positional encodings (sinusoidal, RoPE, ALiBi)
- [ ] Attention math: Q/K/V, scaled dot-product, multi-head
- [ ] Transformer block: attention + FFN + residual + LayerNorm
- [ ] Pre-training objective: next-token prediction, perplexity

**Implementation layer**
- [ ] Harvard NLP "Annotated Transformer" — worked through
- [ ] Karpathy "Let's build GPT" video — coded along
- [ ] 🏁 **MILESTONE: nanoGPT trained from scratch** (or equivalent from-scratch transformer)
- [ ] Inspect own model's attention patterns / generated samples

---

## Phase 3 — Training, Alignment & Inference (target: weeks 10–13)

**Pre-training internals**
- [ ] Data pipelines & batching
- [ ] Mixed precision training
- [ ] Distributed training (DDP) — conceptual
- [ ] Scaling laws (Kaplan/Chinchilla)

**Alignment**
- [ ] Instruction tuning (SFT)
- [ ] RLHF: reward model + PPO — conceptual
- [ ] DPO — conceptual

**Inference internals**
- [ ] Autoregressive decoding
- [ ] KV cache — deep dive (already know the layman version — now the math)
- [ ] Sampling: temperature, top-k, top-p
- [ ] Quantization: GPTQ / AWQ / GGUF

**Usage (review only — already familiar)**
- [ ] Run Llama-3.2-3B / Qwen-2.5 locally via Ollama or llama.cpp
- [ ] 🏁 **MILESTONE: LoRA fine-tune** on a small dataset (HF PEFT)
- [ ] 🏁 **MILESTONE: RAG pipeline** (chunking → embeddings → vector store → retrieval)

---

# 🔧 Embedded Firmware Track

## Phase 1 — C for Embedded + Digital Basics (target: weeks 1–4)

**C language depth**
- [ ] Pointers: pointer-to-pointer, function pointers, arithmetic
- [ ] `volatile` and `const` correctness
- [ ] Bitwise ops — fluent
- [ ] Memory layout: stack / heap / static, struct padding & alignment
- [ ] No STL / no dynamic allocation mindset

**Digital & architecture fundamentals**
- [ ] Binary/hex, two's complement, fixed-point arithmetic
- [ ] Logic gates, flip-flops, clocks (Petzold or Crash Course)
- [ ] Patterson & Hennessy ch. 1–4 (CPU, memory, buses) — or Crash Course episodes

**🏁 Milestone:** software I2C bit-bang in C on laptop, or emulated 8-bit CPU in C

---

## Phase 2 — ARM Cortex-M + Real Board (target: weeks 5–12)

- [ ] Buy STM32F4 Nucleo board (or RP2040/ESP32)
- [ ] Yiu "Definitive Guide to ARM Cortex-M3/M4" ch. 1–9
- [ ] ARM memory map & registers — comfortable
- [ ] NVIC interrupts — comfortable
- [ ] Toolchain: arm-none-eabi-gcc + OpenOCD + GDB + Makefile
- [ ] Linker script + startup file — write own

**Bare-metal milestones (NO HAL!)**
- [ ] 🏁 LED blink via direct register access (`GPIOx->ODR`), custom linker script
- [ ] 🏁 UART TX/RX with interrupts (echo + command parsing)
- [ ] 🏁 I2C temperature sensor → print over UART
- [ ] 🏁 Timer/PWM → servo or LED fade
- [ ] 🏁 ADC → read potentiometer
- [ ] DMA-based transfer (bonus)

**Reference skills**
- [ ] Read STM32 reference manual / datasheet fluently
- [ ] Logic analyzer basics (Saleae or cheap clone)

---

## Phase 3 — RTOS & Real-Time (target: weeks 13–18)

**Concepts**
- [ ] Tasks, scheduling, preemption, priorities
- [ ] Context switching, latency, deadlines
- [ ] ISR vs task boundaries; blocking vs busy-wait
- [ ] Priority inversion — understand & fix

**FreeRTOS**
- [ ] "Mastering the FreeRTOS Real Time Kernel" (free PDF) — read
- [ ] Tasks + queues
- [ ] Semaphores + mutexes
- [ ] ISR-safe APIs, event groups, software timers
- [ ] Watchdog design

**🏁 Milestone:** ADC sampling task → queue → processing task → UART logger, with watchdog
- [ ] Reproduce & fix a priority inversion scenario

---

## Phase 4 — Connectivity (telecom superpower, optional; target: weeks 19–24)

- [ ] lwIP TCP/IP stack — basic usage
- [ ] mbedTLS — basic usage
- [ ] MQTT publish/subscribe
- [ ] AT-command modem interaction (e.g., Quectel NB-IoT/LTE-M)

**🏁 Milestone (pick one):**
- [ ] ESP32 + lwIP/MQTT publishing sensor data
- [ ] STM32 + cellular modem publishing over MQTT
- [ ] Explore LTE/5G L1 PHY / L2 stack firmware roles (DSP, HARQ, scheduling)

---

## Phase 5 — Industry Practices (ongoing)

- [ ] MISRA C — read the guidelines, run cppcheck
- [ ] Unity + Ceedling unit tests + CI pipeline
- [ ] 🏁 Custom bootloader: flash layout, vector table relocation, jump to app
- [ ] 🏁 OTA update
- [ ] Hard-fault handler / coredump debugging
- [ ] Oscilloscope basics
- [ ] Embedded C++ constraints (no exceptions/RTTI/STL) — optional review

---

# 📅 First 90 Days Quick View

**Weeks 1–4**
- [ ] 3Blue1Brown math + micrograd
- [ ] C pointers/bit-manip + ARM book ch. 1–4
- [ ] micrograd ✅ / I2C bit-bang ✅

**Weeks 5–8**
- [ ] Transformer concept layer (Alammar + Annotated Transformer)
- [ ] STM32 Nucleo + bare-metal register GPIO/UART

**Weeks 9–12**
- [ ] nanoGPT coding-along
- [ ] Interrupts + I2C/SPI sensors

---

# ⏰ Daily Schedule Template (~1.5 hrs/day avg)

> Rule of thumb: **weekdays = theory/reading, weekends = hands-on milestones.**
> Hands-on work (nanoGPT, bare-metal, RTOS projects) needs 2+ hr uninterrupted blocks — schedule them on weekends.

## Weekday Evening Routine (Mon–Fri, ~1–1.5 hrs)

| Time | Activity | Notes |
|---|---|---|
| 20:00–20:15 | **Review yesterday** | 1-2 min skim of notes; re-run last code |
| 20:15–20:45 | **Primary study block** | Rotate per phase (see weekly rotation below) |
| 20:45–21:00 | **Practice / flashcards** | Write down 3 things learned; quiz yourself on yesterday's |
| 21:00–21:15 | **Plan tomorrow** | Pick 1 concrete goal (e.g., "finish ch. 4", "get UART RX working") |

## Weekend Deep-Work Blocks (Sat + Sun, 2–3 hrs each)

| Block | Activity | Notes |
|---|---|---|
| Sat 09:00–12:00 | **Hands-on milestone** | nanoGPT coding, bare-metal peripheral, RTOS task |
| Sat 16:00–17:00 | **Review + fix** | Debug leftover issues; update tracker checkboxes |
| Sun 09:00–11:00 | **Hands-on (continue)** | Finish Sat's milestone or start next |
| Sun 11:00–12:00 | **Theory catch-up** | Readings/videos you missed during the week |
| Sun 20:00–20:30 | **Weekly review** | Tick off tracker items; adjust next week's goals |

## Weekly Rotation (first 90 days)

| Week | Mon–Fri (weekday block) | Sat–Sun (deep work) |
|---|---|---|
| 1–4 | 3Blue1Brown math videos / C pointers + ARM book ch. 1–4 | micrograd implementation / I2C bit-bang project |
| 5–8 | Transformer concept layer (Alammar, Annotated Transformer) / ARM interrupts + peripheral theory | STM32 bare-metal GPIO → UART |
| 9–12 | nanoGPT theory + training/alignment readings / RTOS concepts | nanoGPT coding-along / interrupts + I2C/SPI sensors |

## ⚠️ Rules that keep this sustainable

1. **No zero days under 20 minutes** — even 20 min of review counts; momentum beats intensity.
2. **Hands-on tasks always on weekends** — never start a debugging session at 21:00 on a workday.
3. **One track per session** — don't mix LLM and embedded in the same 45-min block; context-switching kills retention.
4. **Bank overflow into Sunday review** — if a weekday block runs long, note it and move on.
5. **1 rest half-day minimum** — burnout is the #1 plan-killer; the timeline already assumes this.

---

*Last updated: 2025-08-09*
