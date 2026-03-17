# Stakeholder Mapping Protocol

Reference for Phase 1.6. Execute all steps. Output is required input for Phase 3 lens configuration.

---

## Step 1: Stakeholder Identification

For the given problem and HMW, identify stakeholders across three tiers.

### Tier 1: Primary Stakeholders
Definition: Directly affected by the outcome of the idea. Their behavior must change for the solution to work.

For each primary stakeholder, capture:
- **Role label** — job title or user archetype (e.g., "Mobile user, first-time signup", "Backend engineer on-call")
- **Core need** — what outcome they need from the solution (1 sentence)
- **Success metric** — how they would personally measure success (1 specific metric)
- **Failure signal** — what behavior indicates the solution failed for them (1 specific signal)

**Detection heuristic:** Ask "Who must do something differently for this to work?" Each answer is a primary stakeholder.

### Tier 2: Secondary Stakeholders
Definition: Indirectly affected — they receive outputs, fund decisions, or set constraints. Their behavior does not need to change but their approval or tolerance does.

For each secondary stakeholder, capture:
- **Role label**
- **Their stake** — what they care about in the outcome (1 sentence)
- **Veto power** — can they block the solution? (Yes / No / Conditional)

**Detection heuristic:** Ask "Who approves, funds, or operates downstream of this?" Each answer is a secondary stakeholder.

### Tier 3: Hidden Stakeholders
Definition: Not obviously connected but affected by side effects, data flows, or second-order consequences.

For each hidden stakeholder, capture:
- **Role label**
- **Why hidden** — why they are easy to overlook in this problem
- **Risk if ignored** — what goes wrong if their needs are not considered

**Detection heuristic:** Ask "Who handles the exception cases?", "Whose data does this touch?", "Who supports users when this breaks?", "Who is excluded by the design assumptions?"

---

## Step 2: Output Format

```
### Stakeholder Map

**Primary:**
| Role | Core Need | Success Metric | Failure Signal |
|------|-----------|----------------|----------------|
| [role] | [need] | [metric] | [signal] |

**Secondary:**
| Role | Their Stake | Veto Power |
|------|-------------|------------|
| [role] | [stake] | Yes/No/Conditional |

**Hidden:**
| Role | Why Hidden | Risk if Ignored |
|------|------------|-----------------|
| [role] | [reason] | [risk] |
```

---

## Step 3: Primary Stakeholder → Phase 3 Lens Handoff

The **first-listed primary stakeholder** becomes the persona for Lens 2 (User/Customer) in Phase 3.

Required handoff output:
```
### Lens 2 Persona (from stakeholder map)
Name/Role: [primary stakeholder role label]
Core need: [core need from map]
Success metric: [metric from map]
Failure signal: [failure signal from map]
Key context for lens: [1–2 sentences of any additional nuance — e.g., technical literacy level, access patterns, emotional context of use]
```

This handoff block must appear at the end of Phase 1.6 output and be referenced by the Perspective Lenses file when executing Lens 2.

---

## Step 4: Stakeholder × Idea Interaction Matrix

This matrix is populated in Phase 4.5 (after ideas are scored), not in Phase 1.6. Record it here as a format reference.

**Format:**

```
### Stakeholder × Idea Matrix
(+ = benefits, − = harmed, ~ = neutral, ? = unknown)

| Stakeholder | Idea 1 | Idea 2 | Idea 3 | Idea N |
|-------------|--------|--------|--------|--------|
| [Primary 1] |   +    |   ~    |   −    |   +    |
| [Primary N] |   ~    |   +    |   +    |   ~    |
| [Secondary] |   +    |   +    |   ~    |   ?    |
| [Hidden]    |   ?    |   −    |   +    |   ~    |
```

**Interpretation rules:**
- Any idea with a `−` for a primary stakeholder must have a mitigation noted in the decision brief.
- Any `?` for a hidden stakeholder is a research gap — flag it in the deferred items section of the brief.
- If all ideas score `−` for a particular stakeholder, flag this as a structural conflict and surface it to the user before final recommendation.

---

## Stakeholder Mapping Notes

- Minimum: 1 primary, 1 secondary, 1 hidden. If fewer are found, state why.
- For internal tooling problems with no end users: the primary stakeholder is the internal operator role (e.g., "data engineer running the pipeline"), and the Regulator lens in Phase 3 may be skipped.
- For B2B products: distinguish the buyer (economic decision-maker) from the user (daily operator). These are separate primary stakeholders with potentially conflicting success metrics.
- For platform/API products: the developer integrating the API is a primary stakeholder, not just the developer's end user.
