---
name: ideate
description: >
  Full-stack brainstorming skill. Runs structured ideation through 12 phases:
  problem framing, JTBD, TRIZ contradiction, stakeholder mapping, divergent
  generation (domain-adaptive), 6 perspective lenses, hybrid synthesis, MECE
  check, scored convergence (confidence ranges), Gary Klein pre-mortem, and a
  decision brief saved to Hive memory. Produces a ranked, risk-vetted idea set
  grounded in real user outcomes.
argument-hint: "<problem statement> [--quick] [--domain=ui|backend|strategy|product|auto] [--build-on=<slug>]"
---

# /ideate — Orchestration Script

## When to Invoke
- User has a design, engineering, strategy, or product problem requiring structured exploration
- User wants more than a list of ideas — they want ranked, risk-checked options with rationale
- User says: "ideate", "brainstorm", "help me think through", "what are my options for"

## When NOT to Invoke
- The answer is a lookup (use web search directly)
- The problem is fully defined and the user just needs implementation (use /scope or just build)
- The session is already mid-ideation — continue in context, don't restart phases

---

## Pre-Flight: Parse Arguments

Read the invocation string. Extract:

1. **Problem statement** — everything before flags. If <10 words after stripping flags, trigger Error E1.
2. **`--quick`** — boolean flag. Default: false (full mode).
3. **`--domain`** — one of: `ui`, `backend`, `strategy`, `product`, `auto`. Default: `auto`.
4. **`--build-on=<slug>`** — optional. If provided, load `docs/decisions/<slug>.md`. If file not found, trigger Error E3.

### Flag Parsing Rules
- Flags may appear anywhere in the argument string.
- If `--domain` is not specified, it defaults to `auto` (Phase 1 will detect it).
- If `--quick` is set, skip Phases 1.6, 1.7, 3, 3.5, 4 (MECE), 5 (Pre-Mortem); run Phases 0, 1, 1.5, 2, 4.5 (Scoring — retained), 6.

---

## Error Handling

**E1 — Vague Input** (handled by Discovery Phase — see below, not by word count).

**E2 — Tool Unavailable** (WebSearch fails in Phase 1.7):
> "Web research tool is unavailable. Skipping Phase 1.7 and proceeding with internal knowledge. Note this in the brief."
> Continue to Phase 2.

**E3 — Build-On File Not Found**:
> "Could not find docs/decisions/<slug>.md. Options: (a) provide the correct slug, (b) paste the prior decision context directly, (c) continue without build-on constraint."
> Wait for user choice.

**E4 — Domain Auto-Detect Ambiguous**:
> "I detected this problem spans multiple domains: [list]. I'll treat it as [primary]. Type the domain to override (ui/backend/strategy/product) or press Enter to continue."
> Wait up to one user turn; if no override, proceed with detected primary.

---

## Reference Files

Before starting any phase, confirm these files are loaded into context:

```
skills/ideate/references/domain-techniques.md
skills/ideate/references/stakeholder-map.md
skills/ideate/references/hybrid-synthesis.md
skills/ideate/references/premortem.md
skills/ideate/references/scoring-rubric.md
skills/ideate/references/perspective-lenses.md
skills/ideate/references/output-template.md
```

If any file is missing, note it and continue with the protocol described inline in this SKILL.md.

---

## LANGUAGE RULES (enforced globally)

**During Phases 2 and 3.5 (diverge phases):**
- FORBIDDEN words: good, bad, great, terrible, interesting, obvious, simple, complex, elegant, smart
- FORBIDDEN behavior: ranking, judging, dismissing any idea
- REQUIRED: describe what each idea does, not whether it is good
- Self-check after generation: scan your output for any evaluative adjective. If found, replace with neutral description.

**During Phases 4 and 4.5 (converge phases):**
- Evaluation language is permitted and required
- Must cite specific evidence from earlier phases (lens findings, pre-mortem, scores)

---

## PHASE 0 — Memory Load

**Action:**
```bash
bash "${HIVE_HOME:-${HOME}/.hive}/scripts/recall.sh" "<problem_statement_first_10_words>" --limit 5
```

Display results as:
```
## Hive Memory: Loaded Context
- [memory-id]: <summary> (type=<type>, importance=<n>)
```

If no memories found: "No relevant Hive memories found. Starting fresh."

If `--build-on` was specified and file exists, load it now:
> "## Build-On Constraint loaded from docs/decisions/<slug>.md"
> Summarize the prior decision in 3 bullets.
> Append: "All ideas in Phase 2 must be compatible with or explicitly supersede this prior decision."

---

## DISCOVERY PHASE (runs after Phase 0, before Phase 1 on every invocation)

**Goal:** Ensure the problem has enough signal before committing to 12 phases of analysis. Word count is not the signal — completeness is.

Analyze the problem statement against 5 dimensions. Mark each Present (✓) or Missing (?):

1. **Actor** — Is there a specific person, role, team, or system experiencing the problem?
2. **Current state** — Is there a description of what happens today (the status quo, workaround, or failure mode)?
3. **Success metric** — Is there a concrete outcome that would mean "solved" — something observable or measurable?
4. **Tried/ruled-out** — Is there any indication of what's already been attempted, considered, or excluded?
5. **Primary constraint** — Is there a limiting factor mentioned (time, budget, technical complexity, organizational, regulatory)?

**Rules:**
- If **3 or more** are Missing: ask the 3 highest-priority missing questions in a single message. Wait for response. Do not proceed to Phase 1 until answered. Do not loop — accept partial answers.
- If **1–2** are Missing: state your assumptions explicitly (`"Assuming: [X]"`), then proceed.
- If **0** are Missing: proceed immediately with no questions.

**Question bank — pick the highest-priority missing ones:**
- Missing actor → *"Who specifically experiences this problem — what is their role, and what are they trying to accomplish when they hit it?"*
- Missing current state → *"What happens today without a solution — what's the workaround or failure mode people are living with right now?"*
- Missing success metric → *"What does a successful outcome look like in concrete terms — what would you measure, observe, or be able to do that you can't today?"*
- Missing tried/ruled-out → *"What approaches have you already tried or ruled out, and why?"*
- Missing constraint → *"What's the primary constraint — time to ship, budget, technical complexity, or organizational buy-in?"*

Display the 5-dimension check visibly before asking, e.g.:
```
## Discovery Check
- Actor: ✓ / ?
- Current state: ✓ / ?
- Success metric: ✓ / ?
- Tried/ruled-out: ✓ / ?
- Primary constraint: ✓ / ?
```

---

## PHASE 1 — Problem Framing + JTBD Job Statement

**Output this section header:**
```
## Phase 1: Problem Framing
```

### Step 1.1 — Reframe as HMW
Convert the raw problem into a How Might We question.
Format: `HMW [verb] [outcome] for [actor] without [constraint]?`
Show 2 HMW variants. Ask user which resonates, or offer "auto" to pick the broader one.
Wait for user input. If user says "auto" or "continue", pick the broader HMW.

### Step 1.2 — JTBD Job Statement
Elicit or write the job statement:
Format: `"When [situation], I want to [goal], so I can [outcome]."`

Show your derived job statement. Ask: "Does this capture the real job? (yes / refine: <your version>)"
Wait for user input. If user confirms or says "auto", lock the job statement.

### Step 1.3 — Domain Detection (if --domain=auto)
Analyze the problem and HMW. State:
> "Detected domain: [domain]. Rationale: [1 sentence]. Proceeding with [domain] technique set."
If ambiguous, trigger E4.

---

## PHASE 1.5 — TRIZ Contradiction Elicitation

```
## Phase 1.5: TRIZ Contradiction
```

Ask (or if in auto mode, answer based on the problem):
> "What is the primary thing you're trying to improve?"
> "What degrades or gets worse when you improve that?"

State the contradiction explicitly:
> "TRIZ Contradiction: Improving [X] degrades [Y]."

Map to the most applicable TRIZ Inventive Principles from this set (software-relevant 8):
1. Segmentation — divide the system into independent parts
2. Taking Out — extract the interfering part or property
3. Prior Action — pre-arrange objects to act from convenient positions
4. The Other Way Round — invert the action or process
5. Dynamics — make an object adjustable or adaptive
6. Self-Service — make the object serve itself
7. Cheap Short-Living — replace expensive durable with cheap disposable copies
8. Parameter Changes — change concentration, flexibility, temperature, degree

State: "Applicable TRIZ principles: [2–3 principles]. These will seed Phase 2 idea generation."

No user checkpoint here — proceed automatically.

---

## PHASE 1.6 — Stakeholder Mapping

**(Skipped in --quick mode)**

```
## Phase 1.6: Stakeholder Map
```

Follow the protocol in `references/stakeholder-map.md`.

Output:
1. Primary stakeholder (name + role description)
2. Secondary stakeholders (list)
3. Hidden stakeholders (list)
4. One sentence on how primary stakeholder's needs will shape the User/Customer lens in Phase 3

**Checkpoint:** "Stakeholder map complete. Primary stakeholder is [X]. Proceed? (yes / adjust: <correction>)"
Wait for user input. If "yes" or "auto", continue.

---

## PHASE 1.7 — Web Research (Optional)

**(Skipped in --quick mode)**

```
## Phase 1.7: Web Research
```

Ask: "Run a quick web research pass on this problem domain? (yes / no / skip)"
- If yes: use WebSearch tool. Query: "[domain] + [core problem keyword] + best practices OR case studies"
  - Summarize findings in 3–5 bullets. Label each: [Research]
  - Note any finding that contradicts the current HMW framing — flag it.
- If no or skip, or if E2 triggers: note "Web research skipped." and continue.

---

## PHASE 2 — Divergent Generation

```
## Phase 2: Divergent Generation
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
LANGUAGE RULE ACTIVE: No evaluative language. Describe what each idea does.
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

Load the technique set for the detected domain from `references/domain-techniques.md`.

Apply all 8 techniques to the HMW question. For each technique:

```
### Technique [N]: [Technique Name]
**What this technique does:** [1 sentence]
**Idea:** [name the idea in 3–6 words]
[2–4 sentences describing the mechanism. No judgment.]
**TRIZ seed applied:** [principle name or "none"]
```

After all 8 ideas, perform self-check:
> "Self-check: scanning for evaluative language..."
> If evaluative words found: "Correcting: [original phrase] → [neutral rewrite]"
> If none found: "Self-check passed."

**Checkpoint:** "8 ideas generated. Select which to carry forward to evaluation: (all / list numbers / auto-select top 5)"
Wait for user input. If "auto" or "all", carry all 8.

---

## PHASE 3 — Perspective Injection

**(Skipped in --quick mode)**

```
## Phase 3: Perspective Lenses
```

Load lens definitions from `references/perspective-lenses.md`.

**Application rule:**
- Lenses 1–3 (Skeptic, User/Customer, Lazy Engineer): apply to ALL selected ideas
- Lenses 4–6 (Operator, Regulator, Competitor): apply to TOP 2 ideas only — follow the top-2 selection protocol in `references/perspective-lenses.md` (do not ask again here)

For each lens × idea combination:
```
### [Lens Name] on Idea [N]: [Idea Name]
[Lens-specific output per lens protocol in perspective-lenses.md]
```

**Operator lens skip rule:** If domain is purely internal tooling with no user PII — note skip.
**Regulator lens skip rule:** Same condition as Operator.

After all lenses: "Lens analysis complete. Key findings carried into hybrid synthesis."

---

## PHASE 3.5 — Hybrid Synthesis

**(Skipped in --quick mode)**

```
## Phase 3.5: Hybrid Synthesis
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
LANGUAGE RULE ACTIVE: No evaluative language during synthesis.
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

Follow the full protocol in `references/hybrid-synthesis.md`.

After synthesis: "Self-check: scanning hybrid descriptions for evaluative language..."
Apply same correction rule as Phase 2.

---

## PHASE 4 — MECE Completeness Check

**(Skipped in --quick mode)**

```
## Phase 4: MECE Check
```

Review the full idea set (original + hybrids). Check:
1. **Mutually Exclusive:** Are any two ideas functionally identical? If yes, merge them and explain why.
2. **Collectively Exhaustive:** Are there obvious solution categories not represented?
   - Use this heuristic: check across these axes: (a) timing [prevent vs. detect vs. repair], (b) ownership [user-controlled vs. system-controlled vs. third-party], (c) cost structure [upfront vs. marginal vs. subscription]
   - If a cell is empty and plausible, add a "Coverage idea" labeled [MECE-gap].

Output:
```
### MECE Analysis
Overlaps found: [none / list]
Gaps identified: [none / list with rationale]
Ideas added: [none / list]
Final idea set: [N] ideas proceeding to scoring.
```

---

## PHASE 4.5 — Convergence + Scoring

```
## Phase 4.5: Scoring
```

Load scoring protocol from `references/scoring-rubric.md`.

Auto-select weight profile from domain:
- ui → balanced
- backend → security
- strategy → balanced
- product → mvp
- Note selected profile.

Score all ideas using the confidence-range format. Output the score table.

After table: rank ideas by weighted total. In case of tie: prefer lower total spread.

State top recommendation:
```
**Recommended option:** [Idea Name]
**Rationale:** [2–3 sentences citing scores + lens findings]
**Runner-up:** [Idea Name] — [1 sentence on why it's second]
```

**Checkpoint:** "Scoring complete. Top recommendation is [X]. Continue to Pre-Mortem on this idea? (yes / change to idea N / skip pre-mortem)"
Wait for user input.

---

## PHASE 5 — Pre-Mortem

**(Skipped in --quick mode)**

```
## Phase 5: Pre-Mortem — [Recommended Idea Name]
```

Follow the full protocol in `references/premortem.md`.

Apply to the top-ranked idea from Phase 4.5.

After the risk table:
- If any row has Probability=High AND Pre-launch Mitigation=No:
  > "⚠ CRITICAL PRE-MORTEM FINDING: [Category] failure has High probability with no available pre-launch mitigation. Surfacing before brief: [narrative]. Recommend addressing this before committing resources."
  > Ask: "Acknowledged? Do you want to (a) continue with this idea, (b) promote runner-up, (c) revisit Phase 2?"
  > Wait for user input.

---

## PHASE 6 — Decision Brief + Memory Save

```
## Phase 6: Decision Brief
```

Render the full brief using `references/output-template.md`.

Populate every section. Do not skip sections. If data for a section is genuinely unavailable (e.g., web research was skipped), write "N/A — [reason]".

### Memory Save

After the brief, execute saves:

**Save chosen option:**
```bash
bash "${HIVE_HOME:-${HOME}/.hive}/scripts/save.sh" \
  --type decision \
  --content "DECISION: [problem slug] | Chosen: [idea name] | Rationale: [1 sentence] | Domain: [domain] | Date: $(date +%Y-%m-%d)" \
  --project "$(basename $(pwd))" \
  --importance 8
```

**Save each rejected option (one command per rejected idea):**
```bash
bash "${HIVE_HOME:-${HOME}/.hive}/scripts/save.sh" \
  --type decision \
  --content "REJECTED: [problem slug] | Idea: [idea name] | Reason: [1 sentence from scoring] | Domain: [domain]" \
  --project "$(basename $(pwd))" \
  --importance 4
```

**Save domain-general pre-mortem pattern:**
```bash
bash "${HIVE_HOME:-${HOME}/.hive}/scripts/save.sh" \
  --type pattern \
  --content "PREMORTEM PATTERN: [domain] | [the most domain-general failure narrative from Phase 5]" \
  --project "$(basename $(pwd))" \
  --importance 6
```

**Save non-obvious problem assumption:**
```bash
bash "${HIVE_HOME:-${HOME}/.hive}/scripts/save.sh" \
  --type fact \
  --content "ASSUMPTION: [problem slug] | [the most non-obvious assumption from Phase 1 framing]" \
  --project "$(basename $(pwd))" \
  --importance 6
```

Log each save attempt. If a save command fails (non-zero exit), note: "Hive save failed for [item]. Manual save recommended."

Display memory save summary:
```
## Memory Save Log
- [chosen idea]: saved as decision, importance 8 ✓
- [rejected idea 1]: saved as decision (rejected), importance 4 ✓
- [rejected idea 2]: saved as decision (rejected), importance 4 ✓
- Pre-mortem pattern: saved as pattern, importance 6 ✓
- Problem assumption: saved as fact, importance 6 ✓
```

---

## Quick Mode Phase Map

When `--quick` flag is set, execute only:
- Phase 0 (Memory Load)
- Phase 1 (Problem Framing + JTBD)
- Phase 1.5 (TRIZ Contradiction)
- Phase 2 (Divergent Generation — all 8 techniques)
- Phase 4.5 (Scoring — balanced profile regardless of domain)
- Phase 6 (Decision Brief — abbreviated: omit stakeholder table, hybrid section, MECE notes, pre-mortem table; note "Quick mode — full analysis available with /ideate without --quick")

Quick mode memory saves: chosen option only (importance 8). Skip rejected and pattern saves.

---

## End of SKILL.md
