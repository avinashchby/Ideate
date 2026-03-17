# Perspective Lenses

Reference for Phase 3. Six evaluator personas with distinct probes and output formats.

## Application Rules

**Full mode:**
- Lenses 1–3: Apply to ALL ideas selected in Phase 2.
- Lenses 4–6: Apply to TOP 2 ideas only.
  - Before applying lenses 4–6, ask: "Which 2 ideas feel most promising for deep lens analysis? (list 2 numbers or 'auto')"
  - If "auto": use the 2 highest-rated ideas from the Phase 2 gut-ranking discussion, or simply ideas 1 and 2 if no ranking was established.

**Quick mode:** Lenses 1–3 only, applied to all ideas. Lenses 4–6 skipped.

**Skip rules:**
- Regulator lens (Lens 5): Skip if domain is purely internal tooling with no user PII and no payment data. When skipping, write: "Regulator lens skipped: internal tooling, no PII or payment surface."
- Operator lens (Lens 4): Skip under the same conditions as Regulator when the idea has no production deployment surface (e.g., a pure strategy idea with no technical implementation). Note the skip.

**Output format per lens:**
Each lens produces a structured block. Do not merge lenses or skip the format.

---

## Lens 1: The Skeptic

**Persona:** Principal engineer with 15 years of production experience who has watched 200 ideas die between whiteboard and launch. Carries visible scar tissue. Not a pessimist — a realist who asks the hard questions first and cares about shipping things that actually work.

**Mindset:** "I've seen this exact idea fail three times. I'm not saying it's wrong. I'm saying show me that this time is different."

**Probes (apply all 4):**

1. **Precedent probe:** Has this idea (or a structurally identical one) been tried before in this domain? What was the outcome? If it failed, what is different this time?

2. **Assumption probe:** What is the single assumption this idea cannot survive being wrong about? State it explicitly. How would you validate it before building?

3. **Complexity creep probe:** What is the thing this idea adds that will grow in complexity over time — the thing that seems small now but will own 20% of the eng team's maintenance budget in 18 months?

4. **Integration probe:** What existing system, process, or behavior does this idea have to replace or coexist with? What is the migration or coexistence cost?

**Output format:**
```
#### Skeptic on Idea [N]: [Name]
- Precedent: [finding or "no precedent found — new territory"]
- Critical assumption: [the assumption + validation path]
- Complexity trap: [the specific thing that will grow]
- Integration cost: [the specific system + migration estimate]
- Skeptic verdict: Proceed / Proceed with conditions ([condition]) / Do not proceed without validating ([assumption])
```

---

## Lens 2: The User/Customer

**Persona:** Derived from Phase 1.6 stakeholder map. This is not a generic "user" — it is the specific primary stakeholder identified in the stakeholder map, with their stated core need, success metric, and failure signal.

**Required:** Read the "Lens 2 Persona" handoff block from Phase 1.6 before applying this lens.

**Quick-mode / no-stakeholder-map fallback:** If Phase 1.6 was skipped or produced no output, derive the Lens 2 persona directly from the JTBD job statement (Phase 1.2). State: "Lens 2 persona (Phase 1.6 not run): [actor from job statement] — someone who wants to [goal from job statement]." Proceed with that persona.

**Mindset:** "I do not care about the technical architecture. I care about whether this helps me accomplish [core need from stakeholder map] faster and with less friction than what I do today."

**Probes (apply all 4):**

1. **First-use probe:** What does the user's first encounter with this idea look like? Walk through the first 3 interactions in sequence. Where is the first moment of confusion?

2. **Job completion probe:** Does this idea let the user complete their job statement in fewer steps than today? Name the current workaround and count the steps. Name the new path and count the steps.

3. **Failure experience probe:** When this idea breaks (not if), what does the user experience? Do they know something broke? Do they know what to do? Does it degrade gracefully?

4. **Trust probe:** Is there a moment in this idea's interaction where the user must trust the system to act correctly without visible feedback? Name it. Is that trust earned or assumed?

**Output format:**
```
#### User/Customer ([persona role from stakeholder map]) on Idea [N]: [Name]
- First use: [step 1 → step 2 → step 3 — where confusion first occurs]
- Job completion: Current path = [N] steps. New path = [N] steps. Net change: [delta]
- Failure experience: [what the user sees when it breaks]
- Trust moment: [the specific interaction requiring blind trust + earned/assumed]
- User verdict: Serves the job / Serves with friction ([friction point]) / Does not serve the job ([reason])
```

---

## Lens 3: The Lazy Engineer

**Persona:** A senior engineer who values their time above most things. Not incompetent — actually very competent, which is precisely why they have zero patience for unnecessary complexity, unclear ownership, and maintenance burdens with no payoff. They ask: "Will I regret building this in 6 months?"

**Mindset:** "I will build anything that is worth building. Show me it is worth the maintenance cost I am about to take on forever."

**Probes (apply all 4):**

1. **Maintenance surface probe:** What ongoing maintenance does this idea require once shipped? Name the specific tasks: cron jobs, dependency updates, config drift, data migration scripts, on-call runbook entries.

2. **Ownership clarity probe:** Who owns this when it breaks at 2am? Is that owner defined? Is the on-call runbook written? If not, who will write it, and is that time budgeted?

3. **Reversibility probe:** Can this be undone if it turns out to be wrong? What is the removal cost — in engineer-hours and in user impact?

4. **Simpler alternative probe:** Is there a version of this that achieves 80% of the value with 20% of the complexity? Name it specifically. If yes, why is the full version being proposed instead?

**Output format:**
```
#### Lazy Engineer on Idea [N]: [Name]
- Maintenance surface: [list of specific ongoing tasks]
- Ownership: [who owns it + runbook status]
- Reversibility: [undo cost in engineer-hours + user impact]
- Simpler alternative: [name it or "none identified"]
- Lazy Engineer verdict: Ship it / Ship with scope reduction ([what to cut]) / Do not ship without [specific prerequisite]
```

---

## Lens 4: The Operator

**Persona:** SRE or on-call engineer, 2am on a Saturday, paged because this idea's production instance is behaving unexpectedly. They have a laptop, a VPN connection, and a 15-minute SLA to understand what happened and start recovery. They have never worked on this code before.

**Mindset:** "I do not care about the product vision. I care about: can I understand what this thing is doing right now, can I stop the bleeding, and can I hand it off to the right team in the morning."

**Probes (apply all 5):**

1. **Alerting surface:** What metrics or logs does this idea emit that would cause a page? Are those alert thresholds defined? Is there a risk of alert storms (too many) or silent failures (too few)?

2. **Runbook existence:** Is there a runbook for this idea's failure modes? Who is responsible for writing it? Can an on-call engineer who did not build it follow it under pressure?

3. **Rollback procedure:** How is this rolled back if it causes user-visible harm? Is rollback a) instant (feature flag), b) fast (<30 min, revert deploy), c) slow (>30 min, data migration required), or d) impossible (irreversible side effects)?

4. **Blast radius:** If this idea's configuration is wrong (wrong feature flag value, wrong env var, wrong threshold), what is the maximum number of users affected and the maximum severity of impact?

5. **MTTR estimate:** How long does it take to go from "page fired" to "system restored to last-known-good state"? Name each step and its estimated duration.

**Output format:**
```
#### Operator on Idea [N]: [Name]
- Alerting: [metrics that would page + gaps in alerting coverage]
- Runbook: [exists / needs to be written / not applicable — reason]
- Rollback: [instant / fast / slow / impossible — specific mechanism]
- Blast radius: [max users affected × max severity]
- MTTR estimate: [step 1 (Xmin) → step 2 (Xmin) → total]
- Operability verdict: Operable as-spec'd / Operable with additions ([what needs adding]) / Not operable without rework ([what must change])
```

---

## Lens 5: The Regulator

**Persona:** Compliance or legal counsel reviewing this implementation before it touches production. Not adversarial — their job is to find the exposure before a regulator or plaintiff does. They think in frameworks: GDPR, CCPA, HIPAA, PCI-DSS, SOC2.

**Mindset:** "My job is to find the thing that will become a problem in 18 months when this system is running at scale and something goes wrong. The time to fix it is now, not then."

**Skip rule:** If the domain is internal tooling with no user PII, no payment data, and no external-facing API, skip this lens and write: "Regulator lens skipped: internal tooling scope — no PII, payment, or external API surface identified."

**Probes (apply all 5):**

1. **Data residency:** Does this idea store, process, or transmit personal data? If yes, where? Does the storage location comply with the data residency requirements of the user's operating geography?

2. **Consent surface:** Does this idea collect or use data in a way that requires explicit user consent? Is that consent mechanism present and auditable?

3. **Audit trail:** If a regulator asks "what did this system do with user X's data between date A and date B," can you answer? Is the audit log tamper-evident?

4. **GDPR/CCPA exposure:** Does this idea create a new right-to-erasure surface? Can user data be deleted from all stores (including backups and derived datasets) on request?

5. **PCI scope:** If the idea touches payment flows, does it expand PCI DSS scope? Does it store, process, or transmit cardholder data? Is that minimized?

**Output format:**
```
#### Regulator on Idea [N]: [Name]
- Data residency: [where PII is stored + compliance status]
- Consent: [consent surface present / absent / not required]
- Audit trail: [answerable / partially answerable / not answerable]
- GDPR/CCPA: [erasure surface exists / manageable / no exposure]
- PCI scope: [expanded / unchanged / not applicable]
- Compliance flags: [bulleted list of specific flags, or "No flags identified"]
```

---

## Lens 6: The Competitor

**Persona:** CPO at a well-funded competitor who just read the product spec for this idea and is in a meeting with their engineering lead deciding whether to copy it, counter it, or ignore it. They know your market, your customers, and your constraints better than you might assume.

**Mindset:** "If this creates real value, we can copy it in 3 months. If it creates a moat, we need to either acquire them or build something better. Let me figure out which it is."

**Probes (apply all 4):**

1. **Copyability timeline:** How long would it take a well-resourced competitor to ship a functionally equivalent version of this idea? What is the barrier — is it technical complexity, data network effects, distribution, or brand trust?

2. **Moat assessment:** What, if anything, makes this idea hard to copy even after the initial version is public? Is the moat deepening over time (compounding data, network effects, switching costs) or static (first-mover awareness only)?

3. **First-mover window:** How long does the first-mover advantage last before the market converges? What must be achieved during that window to make the moat durable?

4. **Existing competitor coverage:** Does a well-funded competitor already have something similar? Name the closest equivalent product or feature. What is the gap between their version and this idea?

**Output format:**
```
#### Competitor on Idea [N]: [Name]
- Copyability: [timeline + primary barrier]
- Moat: [type of moat + compounding or static]
- First-mover window: [duration + what to achieve during it]
- Existing coverage: [closest competitor equivalent or "none identified"]
- Competitive durability: Durable (>12 months) / Window (3–12 months) / Commodity (copyable in weeks)
```

---

## Phase 3 Summary Block

After all lenses, output:

```
### Phase 3 Summary

**Ideas with all-pass verdicts (Skeptic: Proceed, User: Serves the job, Lazy: Ship it):**
[list]

**Ideas with conditional verdicts:**
[list with conditions]

**Ideas with blocking verdicts from any lens:**
[list with blocking lens + reason]

**Key findings for hybrid synthesis (Phase 3.5):**
[2–4 bullet points: specific strengths and weaknesses that motivate potential hybrids]
```
