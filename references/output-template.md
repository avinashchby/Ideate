# Decision Brief Output Template

Reference for Phase 6. Populate every section. No section may be omitted.
If data is unavailable for a section, write: `N/A — [specific reason]`

---

## Brief Header

```
# Decision Brief: [Problem slug — 3–5 words]
Date: [YYYY-MM-DD]
Domain: [ui / backend / strategy / product]
Mode: [Full / Quick]
HMW: [the locked HMW question from Phase 1]
Recommendation: [Idea name — 3–6 words]
```

---

## Section 1: Memory Context

Purpose: Show what prior knowledge informed this session.

```
### Memory Context
Loaded memories:
- [memory-id]: [summary] (type=[type], importance=[n])
- [memory-id]: [summary] (type=[type], importance=[n])
[or: "No relevant Hive memories found."]

Build-on constraint: [slug and 3-bullet summary, or "None"]

Prior knowledge gaps: [any area where no memory existed and external research was also unavailable — 1 sentence or "None identified"]
```

---

## Section 2: Problem Frame

```
### Problem Frame
**HMW Question:** [the locked HMW from Phase 1]
**JTBD Job Statement:** "When [situation], I want to [goal], so I can [outcome]."
**TRIZ Contradiction:** Improving [X] degrades [Y].
**TRIZ Principles applied:** [2–3 principle names]
**Non-obvious assumption in framing:** [the assumption surfaced in Phase 1 that was not stated in the original problem — 1 sentence]
```

---

## Section 3: Stakeholder Impact

*(Omit in quick mode — note "Quick mode: stakeholder mapping skipped.")*

```
### Stakeholder Impact Table

| Stakeholder | Role | Idea Impact | Notes |
|-------------|------|-------------|-------|
| [Primary 1] | [role] | + / − / ~ | [1 sentence] |
| [Primary N] | [role] | + / − / ~ | [1 sentence] |
| [Secondary] | [role] | + / − / ~ | [1 sentence] |
| [Hidden] | [role] | + / − / ~ | [1 sentence] |

Stakeholder conflicts: [any stakeholder scored − for the recommended idea + mitigation, or "None"]
Unknown impacts (?): [any ? cells + what would resolve the unknown]
```

---

## Section 4: Ideas Evaluated

```
### Ideas Evaluated

| # | Idea Name | Technique | [Hybrid]? | Carried to scoring? |
|---|-----------|-----------|-----------|---------------------|
| 1 | [name] | [technique] | — | Yes |
| 2 | [name] | [technique] | — | Yes |
| H1 | [name] | Hybrid: [A+B] | [Hybrid] | Yes |
| X | [name] | [technique] | — | No — [reason: below reject threshold / user excluded] |

Total ideas generated: [N]
Total ideas scored: [N]
Total ideas excluded: [N]
```

---

## Section 5: Hybrid Ideas

*(Omit in quick mode — note "Quick mode: hybrid synthesis skipped.")*

```
### Hybrid Ideas

[For each hybrid:]
**[Hybrid Name]**
- Parent ideas: Idea [A] ([name]) + Idea [B] ([name])
- Motivating lens finding: [Lens] found [specific strength/weakness]
- Mechanism merged: [Idea A]'s [mechanism] + [Idea B]'s [scope/constraint]
- New risk introduced: [1 sentence]

[Or: "No hybrids formed. Reason: [from hybrid synthesis protocol]"]
```

---

## Section 6: MECE Completeness

*(Omit in quick mode — note "Quick mode: MECE check skipped.")*

```
### MECE Analysis
Overlaps merged: [list or "None"]
Gaps identified and addressed: [list with rationale or "None"]
Coverage ideas added [MECE-gap]: [list or "None"]
Assessment: The idea set [is / is not] collectively exhaustive across: timing (prevent/detect/repair), ownership (user/system/third-party), and cost structure (upfront/marginal/subscription).
```

---

## Section 7: Score Table

```
### Score Table
Weight profile: [balanced / mvp / security] (auto-selected from domain: [domain])

| Idea | Impact (±) | Effort (±) | Novelty (±) | Risk (±) | Weighted Total | Confidence |
|------|-----------|-----------|------------|---------|----------------|------------|
| [name] | [v ± s] | [v ± s] | [v ± s] | [v ± s] | [total] | [sum of spreads] |
| [name] [Hybrid] | [v ± s] | [v ± s] | [v ± s] | [v ± s] | [total] | [sum of spreads] |

Interpretation: [Strong / Viable / Weak / Reject] per rubric thresholds.
Tie-breaking applied: [yes — lower confidence won / no ties]

Ideas below reject threshold (<[8 or scaled]): [list or "None"]
Spread-2 alerts: [list dimensions requiring investigation, or "None"]
```

---

## Section 8: Lens Summary

*(Abbreviated in quick mode: "Quick mode — lenses 4–6 not applied.")*

```
### Perspective Lens Summary

**[Idea name] — Recommended:**
- Skeptic: [verdict + key condition if any]
- User/Customer ([persona]): [verdict + key friction if any]
- Lazy Engineer: [verdict + maintenance note]
- Operator: [operability verdict] *(top 2 only)*
- Regulator: [compliance flags or "No flags"] *(top 2 only, or skipped)*
- Competitor: [durability rating] *(top 2 only)*

**[Runner-up idea name]:**
- Skeptic: [verdict]
- User/Customer: [verdict]
- Lazy Engineer: [verdict]
- Operator: [operability verdict] *(top 2 only)*
- Regulator: [compliance flags] *(top 2 only)*
- Competitor: [durability rating] *(top 2 only)*

**Remaining ideas:** [1-line summary per idea — dominant lens finding only]
```

---

## Section 9: Pre-Mortem Risk Table

*(Omit in quick mode — note "Quick mode: pre-mortem skipped.")*

```
### Pre-Mortem: [Recommended Idea Name]

| Category | Failure Narrative | Probability | Pre-launch Mitigation? |
|----------|-------------------|-------------|------------------------|
| Assumption | [specific narrative] | High/Med/Low | Yes/No/Partial |
| Execution | [specific narrative] | High/Med/Low | Yes/No/Partial |
| Adoption | [specific narrative] | High/Med/Low | Yes/No/Partial |
| Scale | [specific narrative] | High/Med/Low | Yes/No/Partial |
| External Shock | [specific narrative] | High/Med/Low | Yes/No/Partial |

Critical findings (High probability + No mitigation): [list or "None — cleared to proceed"]
```

---

## Section 10: Recommendation

```
### Recommendation

**Primary recommendation:** [Idea Name]
**Score:** [weighted total] / [max] — [Strong/Viable/Weak]
**Confidence:** [sum of spreads] — [High/Moderate/Low confidence]

**Why this idea:**
[3–5 sentences. Each sentence must cite a specific finding from an earlier phase:
e.g., "The Skeptic lens found no precedent for failure in this configuration (Phase 3)."
e.g., "JTBD analysis confirmed this closes the job in 3 fewer steps than the current workaround (Phase 3 User lens)."
e.g., "Pre-mortem found all failure modes have partial or full pre-launch mitigation (Phase 5)."]

**Why not the runner-up:**
[2–3 sentences citing specific scores, lens findings, or pre-mortem findings that place it second]

**Conditions on recommendation:** [any Skeptic/Lazy conditions that must be met, or "None — unconditional"]
```

---

## Section 11: Next Actions

```
### Next Actions

| # | Action | Owner | Due | What completing this tells you |
|---|--------|-------|-----|-------------------------------|
| 1 | [specific action] | [role] | [date or sprint] | [what you learn or unlock] |
| 2 | [specific action] | [role] | [date or sprint] | [what you learn or unlock] |
| 3 | [specific action] | [role] | [date or sprint] | [what you learn or unlock] |
| 4 | [specific action] | [role] | [date or sprint] | [what you learn or unlock] |
| 5 | [specific action] | [role] | [date or sprint] | [what you learn or unlock] |
```

Action sourcing rules:
- Action 1: Always the highest-spread score investigation (if any spread=2 exists).
- Action 2: Always the primary Skeptic condition (if conditional verdict).
- Action 3: Always the Operator "needs adding" item (if applicable) or Lazy Engineer prerequisite.
- Action 4: Always the top pre-mortem mitigation task (if Partial or Yes mitigation identified).
- Action 5: Always a re-evaluation trigger: "If [specific metric] is not met by [date], return to Phase 2."

If fewer than 5 sources exist, fill remaining rows from lens findings or MECE gaps.

---

## Section 12: Deferred Items

```
### Deferred Items
Ideas not pursued this session and why:
- [Idea name]: [1 sentence reason — below threshold / MECE overlap / out of scope]

Open questions not resolved:
- [Question]: [what information would resolve it]

Stakeholder unknowns (?-cells from Section 3):
- [stakeholder]: [what needs investigation]

Suggested follow-on sessions:
- [If the MECE check found a coverage gap worth its own /ideate session, name it here]
```

---

## Section 13: Memory Save Log

```
### Memory Save Log

| Item | Type | Importance | Status |
|------|------|------------|--------|
| Chosen: [idea name] — [1-line rationale] | decision | 8 | saved / FAILED |
| Rejected: [idea name] — [1-line reason] | decision | 4 | saved / FAILED |
| Rejected: [idea name] — [1-line reason] | decision | 4 | saved / FAILED |
| Pattern: [pre-mortem domain-general finding] | pattern | 6 | saved / FAILED |
| Assumption: [non-obvious framing assumption] | fact | 6 | saved / FAILED |

[For any FAILED: "Manual save recommended: [content to save]"]
```

---

## Template Usage Notes

- Every section must appear in the output, even in quick mode (with "Quick mode: [section] skipped" where applicable).
- Sections must appear in the order defined here. Do not reorder.
- Do not add sections not defined here. Use "Deferred Items" for anything additional.
- The brief is the permanent record. Write it as if someone who was not present in the session will read it in 6 months.
- Avoid back-references like "as discussed above" — each section must be self-contained enough to be read independently.
