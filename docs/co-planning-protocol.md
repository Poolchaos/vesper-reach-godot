# Co-planning protocol

The phase-by-phase planning discipline. The v1 planning phases are all locked (see status below); this doc is kept for reuse if a new planning effort is ever opened (a new feature, the later races/callings, etc.). CLAUDE.md carries only a pointer + the locked-status summary.

## How it works
Planning happens **before** work, one phase at a time. **Do not advance until Phillip-Juan explicitly locks the current phase** ("lock it" / "confirmed" / "next"). Do not bundle phases.

**Per-turn structure:** each phase opens with a **candidate-variants turn** (2-4 distinct directions in a comparison table; Phillip-Juan picks or specifies a hybrid). After he picks, locked turns use:
```
<session_state>  Current phase; locked decisions carried forward; this phase's status.
<recommendation> Committed, specific, defensible position. No hedging.
<rationale>      Why, grounded in design principles or verified engine/market facts. Flag weak grounding.
<trade_offs>     What is given up; what the alternative offered. Honest.
<open_questions> 1-3 max (prefer 1). If none: "No open questions. Confirm to lock and advance to [next]."
```

**Gating rules:** explicit lock before a new phase; max 3 questions/turn (prefer 1); answer out-of-phase questions only if they unblock the current one, else defer (park genuinely-out-of-phase ideas in [parking-lot.md](parking-lot.md)); do not capitulate on pushback without a substantive counter-argument (and state what changed your mind); if new info contradicts a locked decision, surface it immediately rather than silently revising. Candidates and locks are recorded in `decisions/` (ADRs) or `docs/design/`. Check the ADR index before re-asking a settled question.

## v1 planning track (all LOCKED 2026-06-08)
1. **Concept & v1 scope** - LOCKED. [design/v1-slice.md](design/v1-slice.md).
2. **Animation approach** - LOCKED 2D skeletal/cutout, 4-dir. [../decisions/ADR-0002-animation-approach.md](../decisions/ADR-0002-animation-approach.md).
3. **Engine & tooling** - LOCKED Godot 4.6.3, free built-in bones, Spine deferred. [../decisions/ADR-0001-engine-choice.md](../decisions/ADR-0001-engine-choice.md).
4. **Animation learning path** - LOCKED 6-step in-project progression. [design/animation-learning-path.md](design/animation-learning-path.md).
5. **Architecture & roadmap** - LOCKED v1 architecture + movement-first roadmap M0-M7. [design/v1-architecture-and-roadmap.md](design/v1-architecture-and-roadmap.md).
