# Ideate

Full-stack brainstorming that produces ranked, risk-vetted ideas grounded in real user outcomes — not just a list.

![License](https://img.shields.io/badge/license-MIT-blue) ![Agent Compatible](https://img.shields.io/badge/agents-Claude%20Code%20%7C%20Cursor%20%7C%20Codex%20%7C%20Gemini%20CLI%20%7C%20Copilot-green)

## What It Does

Most brainstorming sessions produce a flat list of options with no way to choose between them. Ideate runs a structured 12-phase pipeline — from problem framing and JTBD analysis through domain-adaptive divergent generation, six evaluator lenses, hybrid synthesis, MECE coverage checking, and a Gary Klein pre-mortem — before converging on a scored recommendation. Every idea is evaluated on Impact, Effort, Novelty, and Risk with explicit confidence ranges, so you know not just which idea ranked first, but how certain that ranking is. The session ends with a structured decision brief saved to Hive memory so future sessions can build on prior decisions rather than starting from scratch.

## When to Use This

- You have a design, engineering, strategy, or product problem and need more than a gut-feel list of options
- You want ranked choices with rationale, not just raw ideas — options scored on impact, effort, novelty, and risk
- You said "ideate", "brainstorm", "help me think through", or "what are my options for"
- You're building on a previous decision and want the new exploration constrained by what was already committed
- You want failure modes identified before you commit resources, not after
- You need a written decision brief you can share with stakeholders or revisit six months later

## Key Features

- **Domain-adaptive divergence** — 8 domain-specific techniques per domain (ui, backend, strategy, product) applied to your HMW question, not generic prompts
- **Discovery pre-check** — validates 5 problem dimensions (actor, current state, success metric, tried/ruled-out, constraint) before starting; asks only what is missing
- **TRIZ contradiction analysis** — maps your core engineering trade-off to software-relevant inventive principles that seed idea generation
- **Six evaluator lenses** — Skeptic, User/Customer, Lazy Engineer, Operator, Regulator, Competitor — each with structured probes and explicit verdicts
- **Motivated hybrid synthesis** — combines ideas only when a specific lens finding justifies the merger; rejects unmotivated or complexity-multiplying combinations
- **Confidence-range scoring** — every score is `value ± spread`; a spread of 2 mandates a discovery action before building
- **Gary Klein pre-mortem** — prospective hindsight across 5 failure categories (Assumption, Execution, Adoption, Scale, External Shock) on the top-ranked idea
- **Hive memory integration** — loads prior relevant decisions at start; saves chosen option, rejected options, pre-mortem pattern, and framing assumption at end

## Quick Start

### Install (copy to your agent's skills directory)

```bash
# Claude Code
cp -r ~/Claude\ Code\ Skills/Ideate ~/.claude/skills/

# Or symlink for auto-updates
ln -s ~/Claude\ Code\ Skills/Ideate ~/.claude/skills/Ideate
```

### For other agents
```bash
# Cursor
cp -r ~/Claude\ Code\ Skills/Ideate .cursor/skills/

# Codex CLI
cp -r ~/Claude\ Code\ Skills/Ideate .codex/skills/

# Gemini CLI
cp -r ~/Claude\ Code\ Skills/Ideate .gemini/skills/
```

## Usage Examples

```
/ideate Our onboarding flow has a 60% drop-off after the account creation step and we don't know why
```

```
/ideate --domain=backend How do we reduce p99 API latency below 200ms without adding read replicas
```

```
/ideate --quick What are my options for pricing a B2B SaaS product targeting solo developers
```

```
/ideate --domain=strategy How do we respond to a competitor that just launched a free tier of our core feature --build-on=pricing-2024-q3
```

```
/ideate --domain=product We need to increase day-7 retention for users who complete onboarding but never invite a teammate
```

## Skill Structure

```
Ideate/
├── SKILL.md                          (474 lines — orchestration script: 12-phase pipeline, flag parsing, error handling, memory save protocol)
└── references/
    ├── domain-techniques.md          (226 lines — 8 divergence techniques per domain: ui, backend, strategy, product)
    ├── output-template.md            (283 lines — 13-section decision brief template with field-level instructions)
    ├── perspective-lenses.md         (222 lines — 6 evaluator personas with structured probes and verdict formats)
    ├── scoring-rubric.md             (145 lines — 4-dimension scoring with confidence ranges, weight profiles, reject thresholds)
    ├── premortem.md                  (162 lines — Gary Klein pre-mortem: 5 failure categories, narrative quality standard, escalation rule)
    ├── hybrid-synthesis.md           (125 lines — lens-motivated hybrid formation rules, rejection criteria, strength-weakness grid)
    └── stakeholder-map.md            (115 lines — 3-tier stakeholder identification with Lens 2 handoff protocol)
```

Total: 1,752 lines across 8 files.

## Part of Forge Skills

This skill is part of the [Forge Skills](../README.md) collection — 23 production-grade agent skills for modern development.

## License

MIT
