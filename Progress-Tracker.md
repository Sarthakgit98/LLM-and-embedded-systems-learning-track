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
- [x] 3Blue1Brown "Essence of Calculus" (all videos) — *complete 2026-08-11: videos 1–11 incl. e, implicit differentiation, limits/ε-δ, integration & FTC, area↔slope, higher derivatives, Taylor series + radius of convergence. Full summary: `Calculus/calculus-phase0-summary.html` (17 sections)*
- [ ] Chain rule — can derive backprop by hand *(rule mechanics done — product = two strips, chain = nested zoom; but "derive backprop" deferred until after neural-network basics, since backprop needs a net to backprop through — revisit at Phase 2)*

**Probability & Information Theory**
- [ ] Distributions, Bayes, expectation, MLE *(sources: Deisenroth ch. 6 · StatQuest playlist · Blitzstein Harvard Stat 110)* — *StatQuest intuition layer done 2026-08-11 (5 distributions, Bayes, prob vs likelihood, MLE — summary: `Probability/probability-phase0-summary.html`); Deisenroth math backbone + Blitzstein pending*
- [ ] Entropy, cross-entropy, KL divergence, perplexity *(sources: Jurafsky & Martin ch. 3 · 3Blue1Brown "coding theory" series · MacKay "Information Theory, Inference, and Learning Algorithms" ch. 1–6)*

**Optimization**
- [ ] Gradient descent / SGD / Adam concepts

**🏁 Milestone: micrograd implemented** (Karpathy video 3, ~100 lines Python)
- [ ] `micrograd` coded from scratch and trained a tiny net

---

## 📋 Probability I Review Checklist

> Summary doc: `Probability/probability-phase0-summary.html` — skim sections 01–08, then hit these. (The old Calculus checklist is implicitly retired — you've moved well past it; calculus retention now lives in the 5-min daily flashbacks and resurfaces in optimization/micrograd. Its re-derivations are all in `Calculus/calculus-phase0-summary.html`.)

**Quick re-derivations (by hand, no notes):**
- [ ] Coin: P(7 heads in 10 flips, fair) = C(10,7)·0.5¹⁰ ≈ 0.117 — and the general binomial PMF C(n,k)·p^k·(1−p)^(n−k)
- [ ] Bayes in symbols: P(A|B) = P(B|A)·P(A)/P(B), with P(B) expanded as P(B|A)P(A) + P(B|¬A)P(¬A)
- [ ] Mammogram: from the tree counts, recompute P(sick | +) = 99/198 = 50% without looking — and say *why* the base rate decides it
- [ ] Likelihood peak: show L(p) = p⁷(1−p)³ peaks at p = 0.7 (ln → differentiate → solve) — the MLE recipe
- [ ] Poisson: P(X=2) for λ=3 by hand = 9e⁻³/2 ≈ 0.224; recall mean = variance = λ
- [ ] Exponential: E[T] = ∫₀^∞ λt·e^(−λt)dt = 1/λ and P(T > 1/λ) = e⁻¹ ≈ 0.368
- [ ] Normal: inflection points at μ±σ — the shoulders; 68-95-99.7 rule
- [ ] Binomial limits: why large n → normal (bell) and tiny p → Poisson (λ = np)

**Conceptual recall (explain out loud):**
- [ ] Bayes in ≤ 3 sentences: evidence updates belief; you flip the conditioning (P(B|A) → P(A|B)); the base rate is the trap
- [ ] Probability vs likelihood: columns vs rows of the table — probability sums to 1 over data; likelihood's absolute height is meaningless, only the peak matters
- [ ] Why MLE is NOT normal-only, and why the family must be chosen BEFORE MLE (data type → family; MLE only tunes within it)
- [ ] Why taking ln L is legal: monotonic ⟹ the peak doesn't move; products become sums
- [ ] Same MLE recipe, different mechanics: Bernoulli/Poisson → mean; Exponential → 1/x̄; Normal → (x̄, s²)
- [ ] The n−1 story: MLE's σ̂² divides by n; the unbiased estimator divides by n−1
- [ ] Memorylessness of the exponential — in one sentence, why the process "forgets" the wait so far
- [ ] When to pick each family: counts → Poisson · yes/no in n trials → Binomial · durations → Exponential · symmetric noise → Normal · total ignorance → Uniform

**Run (5 min, in Python):**
- [ ] `math.comb(10,7)*0.5**10` ≈ 0.117 — binomial PMF check
- [ ] `np.random.binomial(10, 0.5, 100000).mean()` ≈ 5 and `.var()` ≈ 2.5 — mean np, var np(1−p)
- [ ] `np.random.poisson(4, 100000).mean()` and `.var()` both ≈ 4 — the mean=var fingerprint
- [ ] `1/np.mean(np.random.exponential(scale=1/2, size=100000))` ≈ 2 — MLE of λ = 1/x̄
- [ ] Mammogram simulation: 10,000 people, 1% sick, 99% sensitive test → fraction of test+ who are sick ≈ 0.5

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

# 📅 Progress Reality Check (2026-08-11)

> The math phase compressed dramatically: **Linear Algebra + the full Essence of Calculus were completed in 3 days (Sun Aug 9 → Tue Aug 11)**, not 4 weeks. The 90-day plan is a ceiling, not a floor. What's left of Phase 0: probability, info theory, optimization, and the micrograd milestone — see the 5-day plan below.

**Weeks 1–4 content (actual state)**
- [x] 3Blue1Brown math — linear algebra ✅ + calculus ✅ (3 days)
- [ ] micrograd (scheduled: 5-day plan, day 5)
- [ ] C pointers / bit-manip + ARM book ch. 1–4 — not started (embedded begins in parallel from day 3 of the plan)
- [ ] I2C bit-bang / 8-bit CPU — not started

**Weeks 5–8**
- [ ] Transformer concept layer (Alammar + Annotated Transformer) — after Phase 1 history
- [ ] STM32 Nucleo + bare-metal register GPIO/UART — after C foundations

**Weeks 9–12**
- [ ] nanoGPT coding-along
- [ ] Interrupts + I2C/SPI sensors

---

# ⏰ Schedule — 3-Day Reality + 5-Day Sprint (max retention)

> The original weekday/weekend template assumed 10–12 hrs/wk. You've proven you can move far faster — the risk is now **forgetting**, not pace. The plan below closes Phase 0 and opens the other tracks, with a built-in daily review loop and one-track-per-session discipline.

## 📅 Next 5 Days — Close Phase 0, Open the Other Tracks

| Day | Primary block (LLM math, ~1–1.5 h) | Retention booster (10 min) | Secondary session (30–45 min, separate slot) |
|---|---|---|---|
| Wed 12 | Probability I — distributions, expectation, variance (Deisenroth ch. 6; StatQuest) — **✅ StatQuest layer done (2026-08-11)** | 5-min calculus flashback: re-derive chain rule on sin(x²) | — |
| Thu 13 | Probability II — Bayes, MLE, conditional (StatQuest; Blitzstein Stat 110) | Re-derive E[X] = ∫x·p(x)dx from memory | — |
| Fri 14 | Info theory — entropy, cross-entropy, KL, perplexity (Jurafsky ch. 3; 3B1B coding theory) | Explain entropy in ≤ 3 sentences out loud | Embedded C I: pointers + memory layout (K&R ch. 5) |
| Sat 15 | Optimization — gradient descent / SGD / Adam (Karpathy Zero-to-Hero 1–3) | Link GD to Taylor: "linearize the loss, step downhill" | — |
| Sun 16 | 🏁 **micrograd from scratch** (2 h, hands-on) — Phase 0 complete | After coding it, re-derive backprop by hand, no notes | Phase 1 kickoff: history of NLP timeline (first 3 eras) |

**Why this order (retention-first):** probability builds directly on integration (expectation = ∫x·p(x)dx, CDF = antiderivative) — fresh calculus, immediate payoff; info theory builds on probability (entropy = −Σp·ln p); optimization is just Taylor/linearization + the chain rule; micrograd then *uses* every piece. Each day's booster re-activates the previous day, and the two tracks stay in separate sessions.

## 🧪 TEMPORARY — Detailed Source Watchlist (compress into day rows or delete later)

> Purpose: full breakdown of the probability & info-theory sources referenced in the sprint above. Once internalized (or when the sprint ends), compress this into the day rows above and delete this section.

**Probability I & II (Wed–Thu) — exact sources:**

1. **Deisenroth ch. 6 — "Probability and Distributions"** (*Mathematics for Machine Learning*, free PDF at mml-book.github.io) — the math backbone: probability spaces, sum & product rules, Bayes' theorem, expectation/variance, ML-relevant distributions (Bernoulli, Binomial, Categorical, Gaussian, Exponential, Laplace).
2. **StatQuest** (YouTube, Josh Starmer) — ⚠️ *NOT* the "Statistics Fundamentals" playlist (that's frequentist hypothesis testing — p-values, t-tests, ANOVA — irrelevant to this block). Watch these specific videos instead (search by exact title):
   - *Bayes Theorem*
   - *Probability vs Likelihood*
   - *Maximum Likelihood, clearly explained*
   - *The Normal (Gaussian) Distribution* · *The Binomial Distribution* · *The Poisson Distribution* · *The Exponential Distribution* · *The Uniform Distribution*
   - Order: watch first for intuition → then Deisenroth for the math (~90 min total)
3. **Blitzstein — Harvard Stat 110** (free YouTube lectures; book: *Introduction to Probability*, Blitzstein & Hwang) — watch 3–5 lectures only (random variables, expectation, Bayes); gold standard for depth, the rest is reference.
4. **MIT 6.041 (Tsitsiklis)** — *Introduction to Probability* (Bertsekas & Tsitsiklis), free PDF via MIT OCW — role: **exercises** (the highest-value part; turns "watched a video" into "can derive it").

**Info theory (Fri) — exact sources:**

1. **3Blue1Brown** — coding-theory / error-correcting-codes videos (search "3Blue1Brown coding theory"; Hamming/Shannon videos) — conceptual primer on *why* entropy & information are defined as they are; not the meat.
2. **Jurafsky & Martin ch. 3** — *Speech and Language Processing* 3rd ed. draft, free at web.stanford.edu/~jurafsky/slp3/ — entropy + **perplexity** in the NLP context (the LLM-flavored payoff).
3. **MacKay — *Information Theory, Inference, and Learning Algorithms*** — free PDF at inference.org.uk/mackay/itila/ — ch. 1–6 as reference; later chapters bridge to ML (neural nets, Bayesian inference).

**Usage order per day:**

| Day | Watch/read order |
|---|---|
| Wed — Probability I | StatQuest distributions → Deisenroth ch. 6 (distributions, expectation, variance) |
| Thu — Probability II | StatQuest Bayes + MLE → Blitzstein Stat 110 lectures (Bayes, expectation) → MIT 6.041 exercises |
| Fri — Info theory | 3B1B coding theory (primer) → Jurafsky ch. 3 (perplexity) → MacKay ch. 1–6 as reference |

## ⚠️ Sprint rules that keep retention high

1. **5-minute daily flashback** — before each primary block, re-derive yesterday's key result from memory (no notes). Highest-leverage habit; 10 minutes/day of this beats 2 hours of re-reading later.
2. **Explain-out-loud checkpoint** — after each topic, explain it to an imaginary colleague in ≤ 3 sentences; the sentences you stumble on are what to re-read.
3. **One track per session** — LLM math in the primary block; embedded/history only in the separate secondary slot. Never mix within a block.
4. **Hands-on on the weekend** — micrograd lands on Sun. If it slips, protect it as the next available 2-h block; don't squeeze it into a weeknight.
5. **Bank overflow, don't binge** — if a block runs long, note it and move on; the plan absorbs one slip per topic without collapse.
6. **Rest** — you've done 3 consecutive days; take one half-day off somewhere in the 5 days.

---

*Last updated: 2026-08-11*
