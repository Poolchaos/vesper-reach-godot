# v1 architecture & roadmap (locked 2026-06-08)

Godot 4 architecture for the v1 Human sparring slice, the dependency-ordered build roadmap, and the risk register. Locked in Phase 5. Godot API names are the plan; each is verified against the installed 4.6.3 at build time (dev workflow step 2).

## Architecture

Scene tree:
```
TestScene (the room)
├─ Camera2D
├─ Player        (CharacterBody2D + Skeleton2D rig + AnimationTree + input script)
├─ NPC           (instance of HumanRig, recoloured; idle + InteractionArea)
├─ Opponent      (instance of HumanRig, recoloured; simple AI + combat)
└─ UI (CanvasLayer)
   └─ DialogueBox
```

**HumanRig** is one reusable PackedScene (cutout + Skeleton2D/Bone2D + AnimationTree state machine). Player, NPC, and Opponent are instances differing only by recolour and the control script that drives them. This is the rig reuse the later roster depends on.

Core systems, one responsibility each:
1. **Animation state machine** (AnimationTree / AnimationNodeStateMachine) - the single source of truth for motion state. Renderer reads it; input drives transitions; gameplay reads it.
2. **Movement + input** - top-down `move_and_slide`; an InputMap layer binds the same actions to KB+M and controller, so gameplay never branches on device.
3. **Facing resolution** - movement vector -> one of 4 facings -> animation direction param. Pure logic, unit-tested.
4. **Combat** - attack fires a hitbox (Area2D) via an animation event on a frame (not a timer); opponent detects overlap, plays hit_react, hp decremented, defeat at 0. Resolution math unit-tested.
5. **Interaction + dialogue** - InteractionArea + interact-in-range -> DialogueBox shows 1-2 lines.

Testable logic (facing resolution, input mapping, combat math, legal-transition rules) gets unit tests (GUT or GdUnit4, pinned at setup). Animation is verified by eye.

## Roadmap (dependency-ordered; movement-first per Phillip-Juan)

| M | Milestone | Depends on |
|---|-----------|-----------|
| 0 | **Setup** - install Godot 4.6.3 (pinned), `git init`, project skeleton, InputMap (KB+M + controller), empty TestScene, test framework | - |
| 1 | **Movement win** - top-down movement + input with a placeholder visual, 4-dir facing resolution (tested). The "it moves" win. | M0 |
| 2 | **Readability spike** - cutout + rig + idle + hardest facing (front/down) reading well (learning steps 0-2). Kept early to de-risk top-down cutout. | M1 |
| 3 | **Idle + walk** - real clips, 4-dir, driven by movement state (learning step 3) | M2 |
| 4 | **Attack + combat** - attack clip, hitbox-on-frame, opponent hp/hit_react/defeat, combat math (tested) (learning step 4) | M3 |
| 5 | **NPC + dialogue** - NPC idle instance, interaction, dialogue box | M2 |
| 6 | **State machine + reuse** - AnimationTree ties the set together; recolour NPC/opponent (learning step 5) | M3, M4 |
| 7 | **Integration + polish + verify** - full slice playable; silhouette/slow-mo/transition trace; 60 FPS check; Phillip-Juan playtest | M5, M6 |

## Risk register (ranked)

1. **Top-down cutout readability** (biggest unknown). Cutout rigs are mostly side-view; top-down 4-dir can look papery, especially front/down where limbs overlap the torso. Mitigation: the M2 spike proves one convincing idle on the hardest facing before systems depend on it; movement-first (M1) uses a placeholder so nothing real is built on an unproven rig. If it cannot read, adjust early (3/4 camera angle, or a little per-direction art).
2. **Foot-sliding** - walk timing vs move speed. Caught by the step-3 success check.
3. **Frame-accurate hit event** - hit on the right frame via animation method tracks, not timers. Caught by slow-mo verification.
4. **Scope creep** - recolour reuse makes a real second enemy / more attacks tempting; parked items stay parked (parking-lot.md).
5. **New-engine ramp** - Godot/GDScript is new; low risk for a senior dev, mitigated by the incremental path.
