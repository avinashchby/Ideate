# Scoring Rubric with Confidence Ranges

Reference for Phase 4.5. Every score is `value ± spread`. Score all ideas in the final set.

---

## Score Format

Each dimension is scored: `value ± spread`

- **value**: 1–5 integer
- **spread**: 0–2 integer
  - 0 = high certainty (team has direct evidence or strong precedent)
  - 1 = moderate uncertainty (some unknowns remain, reasonable estimate)
  - 2 = high uncertainty (significant unknowns; investigate before building)

A spread of 2 on any dimension is a signal to add a discovery task to the next-actions section.

---

## Four Scoring Dimensions

### Dimension 1: Impact
**Question:** How significantly does this idea move the outcome metric from the JTBD job statement?

| Score | Meaning | Software example A | Software example B |
|-------|---------|-------------------|-------------------|
| 5 | Transforms the core job — the user achieves an outcome they could not before | Slack replacing email for async team coordination | GitHub Actions making CI/CD accessible to solo developers |
| 4 | Substantially improves the primary outcome metric (>50% improvement plausible) | Dark mode reducing eye strain for 3+ hour daily users | Autocomplete in VS Code reducing boilerplate time by ~30% |
| 3 | Improves the outcome metric measurably but not transformatively (10–50% range) | Keyboard shortcuts in a web app reducing power-user task time | Read receipts in messaging reducing follow-up ping frequency |
| 2 | Minor improvement; users notice but it does not change their workflow | Tooltip improvements reducing support tickets marginally | Slightly faster search index refresh in a CMS |
| 1 | Negligible impact on the job to be done; cosmetic or edge-case only | Changing a button color that is not on a conversion path | Adding a rarely-used export format |

### Dimension 2: Effort
**Question:** How much work (engineering + design + coordination) does this require? (Higher score = less effort)

| Score | Meaning | Software example A | Software example B |
|-------|---------|-------------------|-------------------|
| 5 | <1 engineer-week; no new infrastructure; no external dependencies | Adding a feature flag to an existing config system | Writing a SQL query for a new analytics dashboard |
| 4 | 1–3 engineer-weeks; uses existing infrastructure; 1 external dependency | Building a webhook delivery system on existing event bus | Adding a new OAuth provider using existing auth library |
| 3 | 1–2 engineer-months; requires new infrastructure component or service | Building a real-time notification system with WebSockets | Migrating a monolith endpoint to a separate microservice |
| 2 | 3–6 engineer-months; requires new infrastructure + significant coordination | Building an end-to-end encrypted messaging feature | Implementing a multi-region active-active database setup |
| 1 | >6 months; requires new infrastructure + external dependency + org coordination | Building a custom ML training pipeline from scratch | Replacing a core database engine under a live production system |

### Dimension 3: Novelty
**Question:** How differentiated is this from what already exists in the market or codebase?

| Score | Meaning | Software example A | Software example B |
|-------|---------|-------------------|-------------------|
| 5 | No direct equivalent exists; creates a new interaction or capability category | Figma's multiplayer canvas in 2016 | Linear's cycle-based project model vs. traditional backlog |
| 4 | Significant differentiation; existing solutions exist but are meaningfully worse | Vercel's zero-config deployments vs. Heroku in 2020 | Notion's block-based editor vs. Confluence pages |
| 3 | Meaningful improvement on existing approach; clearly better than incumbents | Better error messages in a CLI vs. competitors | A settings search feature that competitors lack |
| 2 | Incremental; similar to what competitors have; executional differences only | Adding inline editing to a table that others already have | Improving load time from 3s to 1.5s (parity with market) |
| 1 | Commodity; table stakes; users expect this as baseline | Adding dark mode in 2024 | Supporting CSV export in a data tool |

### Dimension 4: Risk
**Question:** How much technical, adoption, or business risk does this carry? (Higher score = lower risk)

| Score | Meaning | Software example A | Software example B |
|-------|---------|-------------------|-------------------|
| 5 | Minimal risk; well-understood domain; low blast radius; easy rollback | Adding a new filter option to an existing search UI | Adding pagination to an existing list endpoint |
| 4 | Low risk; one non-trivial dependency or assumption; rollback available | Integrating a third-party analytics SDK | Adding a new database index for query optimization |
| 3 | Moderate risk; 2–3 unknowns; rollback is possible but requires effort | Replacing a caching layer in a high-traffic service | Redesigning a checkout flow with A/B test gate |
| 2 | High risk; multiple unknowns; rollback is disruptive; compliance exposure possible | Migrating user data between storage formats at scale | Launching a new pricing tier that affects existing customers |
| 1 | Very high risk; unknowns dominate; no clean rollback; regulatory exposure or irreversible commitment | Changing the primary authentication mechanism for existing users | Shutting down a legacy API with unknown downstream consumers |

---

## Weight Profiles

Three profiles are available. Auto-select based on domain (SKILL.md specifies this).

| Profile | Impact | Effort | Novelty | Risk | When to use |
|---------|--------|--------|---------|------|-------------|
| balanced | 1× | 1× | 1× | 1× | ui, strategy — balanced tradeoffs |
| mvp | 1× | 2× | 1× | 1× | product — shipping speed matters most |
| security | 1× | 1× | 1× | 2× | backend — failure cost is highest |

**Domain → Profile mapping:**
- ui → balanced
- backend → security
- strategy → balanced
- product → mvp
- In quick mode: balanced regardless of domain

**Computing weighted total:**
`Total = (Impact × w_impact) + (Effort × w_effort) + (Novelty × w_novelty) + (Risk × w_risk)`

For balanced: max = 20. For mvp and security: max = 25 (one dimension doubled).
Normalize for comparison by dividing by max when comparing across profiles.

---

## Confidence Column

After computing the weighted total, compute a **Confidence** score:

`Confidence = Total Spread = sum of all four ± spread values`

- 0–2: High confidence — scores are well-supported
- 3–5: Moderate confidence — some investigation warranted
- 6–8: Low confidence — significant unknowns; do not commit without discovery

The idea with the **lower Confidence score wins all ties** on weighted total.

---

## Score Table Format

```
### Score Table (Weight profile: [profile])

| Idea | Impact (±) | Effort (±) | Novelty (±) | Risk (±) | Weighted Total | Confidence |
|------|-----------|-----------|------------|---------|----------------|------------|
| [Idea name] | 4 ± 1 | 3 ± 0 | 3 ± 1 | 4 ± 1 | 14 | 3 |
| [Idea name] [Hybrid] | 5 ± 1 | 2 ± 1 | 4 ± 0 | 3 ± 1 | 14 | 3 |
| [Idea name] | 3 ± 0 | 4 ± 0 | 2 ± 0 | 5 ± 0 | 14 | 0 |
```

In the above tie example: the third idea wins (Confidence = 0 beats 3).

---

## Score Interpretation

| Total (balanced) | Interpretation |
|-----------------|----------------|
| 16–20 | Strong — pursue with full commitment |
| 12–15 | Viable — pursue with defined discovery tasks to close spreads |
| 8–11 | Weak — significant rework needed or reconsider the approach |
| <8 | Reject — does not meet minimum threshold on key dimensions |

For mvp and security profiles: scale by 25/20 (multiply thresholds by 1.25).

**When total = Reject (<8):** Do not include in the recommendation. Note: "[Idea] scored [N] — below reject threshold. Excluded from recommendation." If all ideas are below 8, surface this to user: "All ideas scored below the viable threshold. Recommend returning to Phase 2 with a narrower HMW question or different constraint set."

---

## Spread Investigation Triggers

If any individual dimension has spread = 2:
Add a row to the Next Actions section:
> "Investigate [Idea name] [Dimension]: score spread = 2. Run [specific discovery action — user interview, load test, legal review, spike] to collapse uncertainty before committing."

This is mandatory — a spread-2 score means the actual value could be 3 levels different from the estimate. Building without closing this uncertainty is a known risk.
