# Gary Klein Pre-Mortem Protocol

Reference for Phase 5. Apply to the top-ranked idea from Phase 4.5 only.
Based on Gary Klein's prospective hindsight method — research shows this increases failure-reason identification by ~30% vs. standard risk analysis.

---

## Framing Script

Read this framing aloud (in the output) before beginning:

> "It is 90 days from now. [Idea Name] shipped on schedule. The team executed well technically. And it has failed completely — not partially, not underperformed, but failed. The thing we were trying to achieve has not happened. Users/stakeholders have rejected it, or the system has broken down, or the market did not respond. You are sitting in the post-mortem meeting.
>
> Your job now is not to assess whether failure is likely. It is already a fact. Your job is to explain **what happened** — as specifically as possible, as if you were there."

This framing is mandatory. Prospective hindsight (imagining failure as fact, not hypothesis) is what generates the 30% improvement. Hedged language ("it might fail because...") is forbidden in the narrative column.

---

## Five Mandatory Failure Categories

For each category, write a specific failure narrative — not a generic risk statement.

**Narrative quality standard:** The narrative must name a specific mechanism, a specific actor or component, and a specific consequence. "The API was slow" fails the standard. "The third-party payment API's 99.5% uptime SLA meant 4.4 hours/month of downtime, which fell during the EU business day window and caused 23% checkout abandonment on day 14, triggering stakeholder escalation" meets the standard.

---

### Category 1: Assumption Failure

**Definition:** A core assumption baked into the design turned out to be false.

**Probes to answer in the narrative:**
- What did the team assume about user behavior, technical environment, or market condition?
- When was this assumption discovered to be false?
- How did the team discover it (user complaint, monitoring alert, sales call)?
- What had already been built or committed that depended on this assumption?

**Example narrative structure:** "We assumed [specific assumption]. By day [N], [specific evidence] showed this was false. At that point, [specific sunk cost] meant we could not reverse the decision without [specific consequence]."

---

### Category 2: Execution Failure

**Definition:** The implementation was technically sound but the execution process broke down.

**Probes:**
- Which team, handoff, or communication gap created the failure?
- Was it a missing owner, an ambiguous spec, a dependency that slipped, or a coordination failure between teams?
- What was the visible symptom and when did it first appear?
- What was the actual root cause three levels deeper?

**Example narrative structure:** "The [specific team] was responsible for [specific deliverable]. By week [N], [specific bottleneck] had not resolved because [root cause]. The integration had already been announced to [stakeholder], creating a forcing function that caused [specific shortcut] to be taken, which resulted in [specific failure mode]."

---

### Category 3: Adoption Failure

**Definition:** The technical solution shipped and worked, but users or the target market did not adopt it.

**Probes:**
- What behavior change did adoption require from users?
- What was the switching cost from their current behavior?
- What was the first session / first 3 uses experience, and where did users exit?
- Was there a specific user segment that drove the failure, or was it universal?

**Example narrative structure:** "The feature required users to [specific behavior change]. In session recordings from the first 2 weeks, [specific exit point] had a [specific dropout rate]. The users who dropped were [specific segment] — the same segment the feature was designed for. Post-session interviews revealed they were [specific misunderstanding or unmet expectation]."

---

### Category 4: Scale Failure

**Definition:** The solution worked at the tested load but broke when traffic or data volume increased.

**Probes:**
- At what specific scale threshold did it break?
- Which component was the bottleneck (database, network, memory, lock contention, external API rate limit)?
- What assumptions about scale were made in the design?
- What was the user-facing impact and the timeline from first signal to user-visible failure?

**Example narrative structure:** "The solution performed under load testing at [N] concurrent users. On day [X], usage reached [Y] concurrent users — [Z]× the tested load — because [specific growth trigger]. The [specific component] became the bottleneck at [specific metric threshold], causing [specific failure mode] for [specific percentage] of users over [specific time window]."

---

### Category 5: External Shock

**Definition:** A factor outside the team's control invalidated the solution or the timing.

**Probes:**
- What regulatory, competitive, economic, or environmental change occurred?
- Was this change foreseeable? (Foreseeable = existed as a known risk in the industry but was not planned for)
- How did the timing interact with the shipping schedule?
- What would have needed to be true for the team to have survived this shock?

**Example narrative structure:** "On [specific date], [specific external event — competitor launch / regulatory ruling / platform policy change] changed the landscape. Our solution depended on [specific condition that changed]. We had [specific time window] of warning before impact. Because [specific dependency], we could not respond within that window."

---

## Output Format: Pre-Mortem Risk Table

After writing all five narratives, distill them into this table:

```
### Pre-Mortem Risk Table: [Idea Name]

| Category | Failure Narrative (specific) | Probability | Pre-launch Mitigation Available? |
|----------|------------------------------|-------------|----------------------------------|
| Assumption | [2–3 sentence specific narrative] | High / Medium / Low | Yes / No / Partial |
| Execution | [2–3 sentence specific narrative] | High / Medium / Low | Yes / No / Partial |
| Adoption | [2–3 sentence specific narrative] | High / Medium / Low | Yes / No / Partial |
| Scale | [2–3 sentence specific narrative] | High / Medium / Low | Yes / No / Partial |
| External Shock | [2–3 sentence specific narrative] | High / Medium / Low | Yes / No / Partial |
```

**Probability calibration:**
- High: This failure mode applies to >50% of similar solutions shipped in this domain. Historical precedent exists.
- Medium: This failure mode applies to 20–50% of similar solutions. Some precedent exists.
- Low: This failure mode is possible but applies to <20% of similar solutions. Minimal precedent.

**Pre-launch Mitigation:**
- Yes: A specific, feasible action exists that can be taken before launch to reduce this risk to Low.
- Partial: A specific action can reduce the probability but not eliminate it, or requires resources not yet confirmed.
- No: No action available pre-launch. The failure would only become visible post-launch, or the mitigation requires resources or information not available within the launch timeline.

---

## Critical Escalation Rule

After the risk table, check every row:

**If Probability = High AND Pre-launch Mitigation = No:**

Output this block before writing the decision brief:

```
⚠ CRITICAL PRE-MORTEM FINDING

Category: [category]
Narrative: [full narrative from table]
Why this cannot be mitigated pre-launch: [1 sentence]

This failure has High probability and no available pre-launch mitigation. Options:
(a) Continue with [Idea Name] — accept this risk and plan post-launch response
(b) Promote runner-up [Runner-up name] to primary recommendation
(c) Return to Phase 2 and generate ideas that avoid this failure mode

Please choose (a), (b), or (c):
```

Wait for user input before proceeding to Phase 6.

If there are multiple High/No rows, stack each as a separate ⚠ block and present all before asking for a decision.

If no High/No rows exist, proceed to Phase 6 without a checkpoint.

---

## Pre-Mortem Scope

- Apply only to the **top-ranked idea** from Phase 4.5.
- Do not apply to runners-up or rejected ideas.
- If the top-ranked idea is a hybrid, the pre-mortem applies to the hybrid as designed — not to either parent idea independently.
- If the user promotes the runner-up (option b above), run the pre-mortem on the runner-up before writing the brief. Reuse any narrative elements that apply.
