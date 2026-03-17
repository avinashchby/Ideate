# Hybrid Synthesis Protocol

Reference for Phase 3.5. Hybrids are motivated combinations, not random merges.
Every hybrid must be traceable to a specific lens finding that motivated it.

---

## Governing Rules

**Rule 1: Lens-motivated only.**
A hybrid may only be formed if a lens finding from Phase 3 identified a specific strength in Idea A that compensates a specific weakness in Idea B (or vice versa). The lens finding must be named explicitly.

**Rule 2: Mechanism specificity.**
The hybrid must name the exact mechanism being merged — not the ideas at a high level. Vague: "combine Idea 3 and Idea 5." Correct: "Idea 3's circuit-breaker isolation mechanism + Idea 5's progressive-disclosure scope."

**Rule 3: No redundant hybrids.**
If the hybrid is functionally equivalent to one of its parent ideas with minor additions, reject it. A hybrid must be a genuinely new design option that neither parent represents.

**Rule 4: Hybrid naming format.**
`[Idea A Name]'s [specific mechanism] + [Idea B Name]'s [scope/constraint/property]`
Example: "Lazy Load's pre-fetch trigger + Offline-First's local-state contract"

**Rule 5: Maximum 3 hybrids per session.**
More than 3 signals that Phase 2 did not generate sufficiently distinct ideas. If the user asks for more, state this limit and explain why — then ask if they want to return to Phase 2.

---

## Hybrid Formation Process

### Step 1: Build the Strength-Weakness Grid

Before forming any hybrid, construct this grid from Phase 3 lens findings:

```
| Idea | Strongest lens finding | Weakest lens finding |
|------|----------------------|---------------------|
| 1    | [strength from lens X] | [weakness from lens Y] |
| 2    | [strength] | [weakness] |
| N    | [strength] | [weakness] |
```

This grid is the only valid source for hybrid motivations. If an idea had no lens analysis applied (because lenses 4–6 only covered the top 2), note this as a limitation.

### Step 2: Identify Valid Pairs

A valid pair satisfies this test:
> "Idea A's [strength] directly addresses Idea B's [weakness] without compromising Idea A's own core mechanism."

Test every candidate pair against this criterion. Write one sentence per candidate:
- Valid: "Idea A's [mechanism] addresses Idea B's [weakness] by [how]. Idea A's core mechanism is preserved because [reason]."
- Invalid: "Idea A and Idea B overlap in [area] — merging would produce a sum of both weaknesses, not a compensation."

Proceed only with valid pairs.

### Step 3: Write the Hybrid

For each valid hybrid, write:

```
### Hybrid: [Hybrid Name]
**Parent ideas:** Idea [A] + Idea [B]
**Motivating lens finding:** [Lens name] found that Idea [B] fails at [specific weakness]. Idea [A]'s [specific mechanism] addresses this because [1 sentence].
**Mechanism being merged:** [Exact description of what from A is combined with what from B]
**What the hybrid does:** [2–4 sentences. Neutral language — no evaluative adjectives.]
**What is explicitly NOT carried over from each parent:** [1 sentence per parent — what is left behind and why]
**New risk introduced by the merger:** [1 sentence — what does the combination create that neither parent had?]
```

### Step 4: Hybrid Rejection Criteria

Reject a hybrid candidate if any of the following are true:

1. **Functional equivalence:** The hybrid produces the same user-facing behavior as one parent idea with minor additions. Test: "If you described this hybrid to a user without naming its parents, would they recognize it as distinct?" If no, reject.

2. **Mechanism conflict:** The mechanisms from A and B operate on the same component in contradictory ways (e.g., one requires synchronous, one requires async on the same call path). State the conflict and reject.

3. **Complexity multiplication:** The hybrid requires N+M components where N and M are the component counts of each parent. Unless the merger eliminates at least one component from each parent, the hybrid adds complexity without subtraction. Reject and note.

4. **Unmotivated combination:** No specific lens finding can be cited as motivation. Do not form "interesting" hybrids — only motivated ones. Reject and state which lens finding is missing.

When rejecting, write:
> "Hybrid [A+B] rejected: [which criterion, 1 sentence explanation]. No hybrid formed from this pair."

---

## When No Valid Hybrid Can Be Motivated

If zero valid pairs exist after Step 2, write:

> "Hybrid Synthesis result: No valid hybrids. Reason: [one of the following]
> (a) Lens analysis found no compensating strength-weakness relationship between any pair of ideas.
> (b) All candidate pairs failed the mechanism specificity test.
> (c) All candidate pairs introduced mechanism conflicts.
>
> Proceeding to Phase 4 with the original [N] ideas. This is a valid outcome — it means the ideas are genuinely distinct and address different aspects of the problem."

Do not force a hybrid to fill this section.

---

## Hybrids in Phase 4 Scoring

- Hybrids enter the Phase 4.5 score table labeled `[Hybrid]` in the Idea column.
- Example: `Lazy Load + Offline-First [Hybrid]`
- Hybrids are scored on the same 4 dimensions (Impact, Effort, Novelty, Risk) with confidence ranges.
- The "New risk introduced by merger" from Step 3 is reflected in the Risk score: if the merger risk is non-trivial, the Risk spread must be ≥ 1.
- Hybrids are eligible for top recommendation. They are not given preferential treatment — they compete on scores alone.
- If a hybrid wins the top recommendation in Phase 4.5, the pre-mortem in Phase 5 applies to the hybrid, not to either parent idea individually.

---

## Output Summary Format

At the end of Phase 3.5, output:

```
### Hybrid Synthesis Summary
Pairs evaluated: [N]
Valid hybrids formed: [N] (or 0)
Rejected pairs: [N] — [brief reason per pair]

[Hybrid write-ups per Step 3, if any]

Proceeding to Phase 4 with [original ideas count + hybrid count] total ideas.
```
