# Architecture Decision Records

One ADR per non-trivial decision, numbered sequentially. ADRs are never edited after sign-off; reverse a decision by writing a new ADR that supersedes the old. Check this index before re-asking a settled question.

| ADR | Topic | Status |
|-----|-------|--------|
| 0001 | Engine & rendering/animation pipeline choice | Accepted 2026-06-08 - Godot 4 (4.6.3), free built-in 2D bones; Spine deferred |
| 0002 | Animation approach (frame vs skeletal vs 3D-to-2D) + facing strategy | Accepted 2026-06-08 - 2D skeletal/cutout, 4-dir for v1 (path to 8) |

## Pending decisions (mapped to planning phases)

- **Phase 1 - Concept & v1 scope:** LOCKED 2026-06-08. Recorded as a living design doc, not an ADR (it is a scope lock, not an architecture decision): [../docs/design/v1-slice.md](../docs/design/v1-slice.md).
- **Phase 2 - Animation approach:** spritesheet vs 2D skeletal/cutout; facing strategy (4/8-dir). -> its own ADR.
- **Phase 3 - Engine & tooling:** ADR-0001 (engine + version + animation tool + Steam/distribution path).
- **Phase 4 - Animation learning path:** progression plan (may be a design doc rather than an ADR).
- **Phase 5 - Architecture & roadmap:** v1 architecture + milestone order + risk register.

No ADRs are signed off yet.
