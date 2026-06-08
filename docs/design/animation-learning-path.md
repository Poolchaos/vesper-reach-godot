# Animation learning path (locked 2026-06-08)

The deliberate progression for learning skeletal animation on Godot 4's built-in 2D bones, on the v1 Human. Each step is a real v1 deliverable (learn in-project, no throwaway) with an observable success check. Locked in Phase 4.

| # | Step | What you learn | Right when |
|---|------|----------------|-----------|
| 0 | **Cutout prep** - separate human.png into parts (head, torso, upper/lower arm, hand, upper/lower leg, foot, hair) | Character decomposition; pivots; draw order; what cutout demands of the art | Parts reassemble into the reference pose, correct overlap, clean pivots. Becomes the first asset spec. |
| 1 | **Rig** - Skeleton2D + Bone2D hierarchy, bind parts, one IK chain | Bone hierarchy, rest pose, parenting, binding, inverse kinematics | Drag the hand -> arm follows via IK; rotate hip/torso -> everything above follows; nothing detaches or tears |
| 2 | **Idle** (heaviest effort) - breathing/weight-shift loop | Keyframing, easing curves, seamless looping, holds, secondary motion, timing, deltaTime playback | Reads as alive at a glance, loops with no pop, passes silhouette test, holds up in slow-motion |
| 3 | **Walk** (4-direction) - S/N/side, mirror side | Four key poses (contact/down/passing/up), weight transfer, foot-plant, mirroring as a flip flag, per-direction posing | Feet plant at real move speed (no skating), loops clean, all 4 facings read, frame-rate independent |
| 4 | **Attack** (one-shot + frame event) - single swing | Anticipation/strike/follow-through/recovery, non-looping one-shots, animation events on a frame (not a timer), recovery windows, return-to-idle | In slow-motion the hit fires on the intended frame, anticipation reads, returns cleanly to idle, reads in silhouette |
| 5 | **Generalize** - state machine + reuse | Animation state machine (AnimationTree), declared transitions + blend windows, one source of truth for state, rig reuse by recolour, wiring hit_react + defeat | Every transition in/out of each state fires correctly (trace all), no flag-soup, recoloured NPC/opponent reuse the one rig, whole v1 set reachable in gameplay |

Notes: idle is placed early and weighted heaviest because it is the most-seen animation. Success is verified by eye (silhouette, slow-motion, foot-plant, frame-accurate events), not by automated tests. The character-animation pipeline (this path) is the spine of the Phase 5 roadmap; gameplay systems hang off specific steps.
