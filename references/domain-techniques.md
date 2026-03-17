# Domain-Adaptive Divergence Techniques

Reference for Phase 2. Load the technique set matching the detected or specified domain.
Apply all 8 techniques to the HMW question. Do not skip any technique.

---

## Domain: auto

**When domain=auto:** Analyze the problem statement and HMW question. Map to one of four domains using these signals:

| Signal | → Domain |
|--------|----------|
| Contains: screen, user, click, flow, onboarding, navigation, layout, interaction, accessibility | ui |
| Contains: API, database, latency, throughput, queue, service, infra, scale, reliability, deployment | backend |
| Contains: market, competitor, revenue, GTM, positioning, growth, acquisition, churn, pricing | strategy |
| Contains: feature, retention, activation, conversion, funnel, engagement, product-market fit | product |

If signals from 2+ domains appear, pick the domain with the most signal words and trigger E4 for user confirmation.

**Required output before Phase 2 begins:**
> "Auto-detected domain: [domain]. Signals found: [list 2–3 signal words from problem]. Loading [domain] technique set. To override: type the correct domain now or press Enter to continue."
> Wait one turn for override. If none, proceed.

---

## Domain: ui

**For:** UI/UX problems — interaction design, screen flows, onboarding, navigation, accessibility, visual hierarchy.

### Technique 1: Direct
**What it does:** Derive the most conventional UX solution from established design patterns and platform conventions.
Apply the interaction pattern that the target platform (web/mobile/desktop) already makes native. Look at: Material Design, HIG, WCAG, or the Nielsen heuristics most violated by the current state. Name the pattern and describe how it resolves the HMW.

### Technique 2: Inversion
**What it does:** Deliberately design the worst possible version of the UX, then invert every decision.
Write 3 specific design choices that would maximize confusion, friction, or abandonment. Then invert each: the inverted choices form a candidate idea. The value is in the specificity — vague "bad UX" produces vague ideas.

### Technique 3: Constraint Removal
**What it does:** Identify the constraint that most limits the current interaction, then design as if it does not exist.
Common UI constraints: screen size, platform capability, localization strings, accessibility compliance budget, design system token limits. Remove the most binding one. Describe the interaction that becomes possible.

### Technique 4: Constraint Addition
**What it does:** Design for 10× less screen real estate than currently assumed.
If the current design assumes a 390px wide screen, design for 39px (notification banner, Apple Watch, status bar). What survives? What must be rethought? The forced reduction reveals what is genuinely essential vs. accidental. Bring only the essential elements back into the full-size design.

### Technique 5: SCAMPER
**What it does:** Apply the SCAMPER operators to the existing UI element at the center of the problem.
Work through each operator against the specific UI element (not the whole screen):
- **Substitute:** Replace this element with a different interaction primitive (e.g., replace dropdown with inline search)
- **Combine:** Merge this element with an adjacent element to reduce steps
- **Adapt:** Borrow this interaction from a different app category (e.g., adapt a gaming HUD element)
- **Modify:** Change the size, timing, or feedback modality of this element
- **Eliminate:** Remove this element entirely — what task does the user now do without it?
- **Reverse:** Reverse the sequence (e.g., show results before filters, show output before input)
Name the most generative SCAMPER output as the idea.

### Technique 6: Analogy Import
**What it does:** Draw a structural analogy from one of four source domains and translate the mechanism.
Source domains to check:
- **Wayfinding** (airport signage, subway maps): progressive disclosure, landmark hierarchy
- **Gaming progression** (XP bars, unlocks, checkpoints): variable reward, visible progress
- **Physical tool design** (affordance, grip ergonomics, tactile feedback): direct manipulation metaphors
- **Theatrical staging** (focus of attention, entrance/exit, scene transitions): attention choreography
Pick the analogy that maps most directly to the HMW. Name the mechanism being imported and the translation.

### Technique 7: Six Thinking Hats
**What it does:** Run two hats sequentially — Green then Black — on the current design state.
- **Green hat (creative possibilities):** Generate 3 divergent directions for this UI with no constraints. Focus on what has not been tried in this product category.
- **Black hat (risks and failure modes):** For the current design (not the Green ideas), name 3 specific ways it will fail with real users within 30 days of launch.
Name the idea that emerges from the tension between the Green possibilities and the Black failure modes.

### Technique 8: Devil's Advocate
**What it does:** Argue, with specific evidence, why the obvious UX solution will fail in production.
State the obvious solution first. Then make the strongest case against it: cite a specific class of user it excludes, a specific edge case it breaks on, or a specific production constraint (i18n, a11y, state management) that invalidates it. The idea is whatever remains after the obvious solution is disqualified.

---

## Domain: backend

**For:** Systems, infrastructure, APIs, databases, distributed systems, reliability, performance.

### Technique 1: Direct
**What it does:** Derive the conventional engineering solution from established distributed systems patterns.
Apply the textbook approach for the problem class: if it is a consistency problem, apply the CAP theorem tradeoffs; if it is a latency problem, apply caching hierarchy; if it is a throughput problem, apply horizontal partitioning. Name the specific pattern and describe the implementation path.

### Technique 2: Inversion
**What it does:** Design the maximally unreliable version of the system, then invert every choice.
Write 3 specific architectural decisions that would guarantee failure: single point of failure, synchronous blocking calls in the critical path, no circuit breaker. Invert each. The inverted design is the candidate idea. Specificity matters — "use a message queue" only counts if you name which queue and why.

### Technique 3: Constraint Removal
**What it does:** Identify the primary technical constraint (consistency, latency, or cost) and design as if it is removed.
State which constraint you are removing. Then describe the architecture that becomes possible. Common candidates: strong consistency requirement, sub-100ms SLA, single-region deployment mandate, no-cache policy for compliance. After describing the unconstrained design, note which elements survive re-introducing the constraint at a relaxed level.

### Technique 4: Constraint Addition
**What it does:** Design for 10× less infrastructure budget than currently assumed.
If the current design assumes N instances + managed services, design for N/10 instances + zero managed services. What must be eliminated? What can be approximated? The forced reduction reveals which architectural decisions are load-bearing vs. cargo-culted.

### Technique 5: TRIZ Principles
**What it does:** Apply the 3 most relevant TRIZ Inventive Principles from the software-relevant set to the backend contradiction.
Use the contradiction identified in Phase 1.5. Map it to 3 principles from:
- **Segmentation:** Split the service into independently deployable components at the exact boundary where the contradiction occurs
- **Taking Out:** Extract the problematic property (e.g., extract the stateful part of a stateless service)
- **Prior Action:** Pre-compute or pre-fetch the result before the request arrives
- **Dynamics:** Make the configuration or topology adaptive at runtime (e.g., dynamic sharding)
- **Parameter Changes:** Change the unit of processing (e.g., batch instead of per-record, stream instead of batch)
For each principle, write the specific mechanism it suggests for this problem. Name the idea after the dominant principle.

### Technique 6: Analogy Import
**What it does:** Import a mechanism from one of four engineering domains and translate it to the backend problem.
Source domains:
- **Queuing theory** (Little's Law, M/M/1 queues): work shedding, backpressure, arrival rate modeling
- **Circuit breakers** (electrical engineering): fail-fast, state machine (closed/open/half-open), recovery probing
- **Supply chain** (inventory buffers, JIT, safety stock): read replicas as buffer stock, write-ahead log as work-in-progress inventory
- **Aviation reliability** (redundancy, checklists, crew resource management): N+2 redundancy, runbook-as-checklist, blast-radius containment
Translate the mechanism literally: name every component in the analogy and its software equivalent.

### Technique 7: Six Thinking Hats
**What it does:** Run White hat then Black hat on the current system design.
- **White hat (data and facts):** What does the observability data actually show? Name 3 specific metrics or traces that would tell you whether this system is failing. If you don't have these metrics, name the gap.
- **Black hat (failure modes):** Name 3 specific failure scenarios this system will experience in the first 90 days of production. Each must include: trigger condition, propagation path, blast radius.
The idea is a design that closes the gap between the White hat unknowns and eliminates the highest-probability Black hat failure.

### Technique 8: Devil's Advocate
**What it does:** Argue, with specific evidence, why this backend approach fails at 10× scale.
State the current approach. Then make the case against it at 10× current load: name the specific bottleneck that saturates first (CPU, lock contention, connection pool, memory, disk I/O). Name the time-to-failure at 10× load based on known capacity limits. The idea is the architecture that does not have this bottleneck.

---

## Domain: strategy

**For:** Business decisions, product-market positioning, competitive moves, go-to-market, pricing, partnerships.

### Technique 1: Direct
**What it does:** Derive the conventional strategic move from established business frameworks.
Apply the most applicable framework: Porter's Five Forces (if competitive positioning), Ansoff Matrix (if growth direction), BCG Matrix (if portfolio allocation), or Blue Ocean (if market creation). Name the framework, apply it to the specific situation, and state the move it recommends.

### Technique 2: Inversion
**What it does:** Design the move that would most reliably destroy the current market position, then invert it.
Write 3 specific decisions that would accelerate loss of market share or revenue: pricing wrong, targeting wrong segment, misaligned messaging. Invert each. The inverted strategy is the candidate idea.

### Technique 3: Constraint Removal
**What it does:** Identify the binding strategic constraint (resource, timeline, or regulatory) and design the strategy that becomes possible without it.
Common constraints: 12-month runway, geographic regulatory limit, partnership exclusivity clause, brand positioning box. Name the constraint. Describe the strategy possible without it. Identify which elements of that unconstrained strategy can be approximated within the actual constraint.

### Technique 4: Constraint Addition
**What it does:** Design the strategy for 10× less funding than currently assumed.
If the strategy requires $X in spend, design for $X/10. What must be done with distribution, pricing, or sequencing instead of capital? The resource-constrained version often reveals the genuine value hypothesis vs. the spend-to-acquire hypothesis.

### Technique 5: Analogy Import
**What it does:** Import a mechanism from one of four strategic domains and translate it to the current decision.
Source domains:
- **Game theory** (Nash equilibrium, prisoner's dilemma, Schelling points): model competitor responses as rational actors, find commitment devices
- **Military strategy** (interior lines, concentration of force, OODA loop): speed of decision as competitive advantage, sequencing of moves
- **Ecosystem dynamics** (keystone species, mutualism, invasive species): platform dynamics, two-sided market leverage, API as ecosystem foundation
- **Platform economics** (network effects, multi-homing costs, envelopment): when to open vs. close platform, how to increase switching costs
Translate the mechanism: name every element in the analogy and its business equivalent.

### Technique 6: Six Thinking Hats
**What it does:** Run Yellow hat then Black hat on the proposed strategic move.
- **Yellow hat (benefits and optimistic scenarios):** Name 3 specific positive outcomes if this strategy works, with named metrics and timelines.
- **Black hat (risks and pessimistic scenarios):** Name 3 specific ways this strategy fails, with named causes and 6-month timelines.
The idea is the strategy that maximizes Yellow outcomes while closing Black vulnerabilities.

### Technique 7: Jobs to Be Done
**What it does:** Identify the job the market is hiring this solution to do, then find the unmet outcome.
Write the market-level job statement: "When [market situation], buyers hire [product category] to [functional goal], so they can [progress metric]."
Identify the outcome that is currently underserved: the gap between what buyers want to achieve and what existing solutions provide. The idea is the strategic position that owns this unmet outcome.

### Technique 8: Devil's Advocate
**What it does:** Argue why this strategic move will be copied or countered within 6 months.
State the proposed move. Then: name the specific competitor most likely to respond, describe their response (price match, feature copy, channel block, acquisition), estimate the response timeline, and identify what moat (if any) delays the response. The idea is the version of the move that creates or deepens the moat.

---

## Domain: product

**For:** Feature design, user activation and retention, product-market fit, engagement, funnel optimization.

### Technique 1: Direct
**What it does:** Derive the conventional product solution from established product frameworks.
Apply the most applicable pattern: if activation, apply the "aha moment" framework (identify the action that correlates with retention, remove friction to reach it faster); if retention, apply habit loops (cue → routine → reward); if churn, apply exit interview synthesis. Name the framework and the specific action it prescribes.

### Technique 2: Inversion
**What it does:** Design the product experience that maximizes churn and abandonment, then invert every decision.
Write 3 specific product decisions that accelerate abandonment: bury the value, front-load complexity, delay the reward. Invert each. The inverted design is the candidate idea.

### Technique 3: Constraint Removal
**What it does:** Identify the binding constraint on the product experience (technical, timeline, or resource) and design the version without it.
Common product constraints: eng bandwidth, third-party API limits, platform policy, existing data model rigidity. Remove the most binding. Describe the product experience that becomes possible. Note which elements survive re-introducing the constraint.

### Technique 4: Constraint Addition
**What it does:** Design the feature for 10× less engineering bandwidth — no-code or minimal-code.
If the feature currently requires a full eng sprint, design the version that a PM can ship with Zapier, a Notion template, or a manual process. The no-code proxy tests the value hypothesis before the build. Describe the proxy mechanism and the metric it would validate.

### Technique 5: Jobs to Be Done
**What it does:** Write the JTBD job statement for this feature and identify the unmet outcome.
Job statement format: "When [situation], I want to [goal], so I can [outcome]."
After writing the job statement: identify the outcome metric the user cannot currently achieve. Name the current workaround users employ. The idea is the product decision that eliminates the workaround by directly serving the outcome.

### Technique 6: Analogy Import
**What it does:** Import a mechanism from one of three product-adjacent domains and translate it.
Source domains:
- **Games — onboarding and progression** (tutorial levels, XP, unlocks, leaderboards): variable reward schedules, visible progress, peer comparison
- **Habit loops** (cue, routine, reward — BJ Fogg behavior model): trigger identification, routine simplification, reward immediacy
- **Social dynamics** (social proof, reciprocity, commitment, scarcity): which social mechanism is missing from the current product experience?
Translate the mechanism: name every element in the analogy and its product equivalent.

### Technique 7: Six Thinking Hats
**What it does:** Run Red hat then Green hat on the product decision.
- **Red hat (user emotion):** What is the emotional state of the user at the moment this feature is encountered? What emotion does the current experience create? What emotion should it create?
- **Green hat (creative possibilities):** Generate 3 divergent ways to create the target emotion through product design. Each must be mechanistically different (not just variations of the same pattern).
The idea is the product design that most directly bridges the gap between current and target user emotion.

### Technique 8: Devil's Advocate
**What it does:** Argue why users will not adopt this feature even if it is technically well-built.
State the feature. Then make the case against adoption: identify the specific behavior change required (what must users do differently?), the switching cost from their current workaround, and the adoption barrier in the first 3 uses. The idea is the version of the feature that eliminates the highest-friction adoption barrier.

---

## Technique Application Notes

- Apply techniques to the **HMW question**, not to the raw problem statement.
- TRIZ seeds from Phase 1.5 should be woven into whichever techniques are most receptive (typically: Technique 5 for backend, Technique 6 for ui/product, Technique 7 for strategy).
- Do not skip a technique because it seems less relevant — constraint and inversion techniques often produce the most differentiated ideas precisely because they are uncomfortable.
- Each technique must produce exactly one named idea (3–6 word name). The name will be used in the score table.
