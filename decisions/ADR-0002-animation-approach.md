# ADR-0002 - Animation approach

**Status:** Accepted 2026-06-08 - B (2D skeletal/cutout), 4-direction for v1 with a planned path to 8. Engine + specific tool is a separate decision (ADR-0001, Phase 3).
**Date:** 2026-06-08

## Context
The project's core goal is learning real character animation (limbs that move) on a painted chibi human, top-down, that walks and attacks, with a world that later needs 3 races x 2 callings + awakening (so reusable rigs and swappable parts matter). Dev machine is Linux. We must choose the *approach* (frame vs skeletal vs 3D-to-2D) and the *facing strategy* (4/8-direction). All facts below were verified live 2026-06-08 (sources in the Phase 2 chat turn).

## Candidates

### A. Frame-by-frame spritesheets (hand-painted frames, per direction)
- Every frame is a painted image. The v1 set (idle, walk, attack, hit_react, defeat) is roughly 25-30 frames PER direction; x4 dir ~ 100+, x8 ~ 200+ painted frames, multiplied again per race/calling/equipment.
- Teaches drawing/timing, NOT rigging/IK. Impractical for a solo painted-chibi project; worst roster scaling (new race = redraw everything; swappable parts very hard).

### B. 2D skeletal / cutout (bone rig with swappable skins) - RECOMMENDED
- Cut the painted character into parts, build one bone rig, keyframe poses. Top-down handled by the "Direction Bank": one rig, ~5 unique direction poses (S, SE, E, NE, N), mirror the west side for 8-direction.
- Teaches the transferable core: rigging, hierarchy, keyframing, IK, easing - exactly "limbs that move."
- Best roster scaling: new race/calling = re-skin the same rig, not re-animate.
- Linux-viable: Spine has a native 64-bit Linux editor (Essential $69 / Pro $379); Godot 4 has free built-in Skeleton2D + Bone2D + IK + mesh deform. (Tool pick = Phase 3.)
- Caveat: top-down skeletal is specialized vs the more common side-view; a poorly-cut rig can look papery. Mitigated by clean part-cutting + mesh deformation.

### C. 3D-to-2D pre-rendered directional sprites (Blender -> render 4/8 dir -> sheets)
- Model/rig/animate a chibi once in 3D, render each animation from 4/8 camera angles. Directional consistency comes free (camera rotates, not the art).
- Teaches 3D rigging/animation (deeper, transfers to 3D later) but adds a 3D-modeling + toon-shading + render-pipeline lift, and a style-drift risk vs the hand-painted reference. Output is frame-based (loses skeletal runtime flexibility).

## Facing strategy
Cost ladder: single-flip < 4-dir (3 unique with mirroring: S, N, side) < 8-dir (~5 unique with mirroring) < full rotation. 8-dir skeletal is ~1.6x the 4-dir work (pose-reposition, not redraw). Recommendation: lock 4-direction for v1 to nail the rig + the five states, with 8-direction as a planned extension once the workflow is owned (ties into Phase 4 learning path).

## Decision
LOCKED 2026-06-08: **B (2D skeletal/cutout), 4-direction for v1 with a planned path to 8-direction once the rig workflow is owned.** Frame-by-frame (A) rejected as impractical for a solo painted-chibi project and the wrong skill for the learning goal. 3D-to-2D (C) rejected for v1 as a 3D-modeling detour plus style-match risk; noted as a possible future option, not a v1 path.

## Consequences (if B is locked)
- The human.png reference must be re-authored as separated body parts (a cutout sheet); that becomes the first asset spec (asset-spec gate).
- The specific tool (Spine vs Godot bones vs other) is decided in Phase 3 and is coupled to the engine choice; both leading options are Linux-viable, so locking the approach is safe.
