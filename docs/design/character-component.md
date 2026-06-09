# Reusable character component

How one rig serves every character that shares the human body type and proportions (player, NPC, opponent now; the 3 races x 2 callings later). Consumes the parts from [../assets/human-cutout.md](../assets/human-cutout.md). Godot best practice: a scene is a reusable component; data (the skin) is swapped, not code.

## Three pieces

1. **`CharacterRig` (PackedScene)** - the visual rig: the part `Sprite2D`s parented in a joint hierarchy (head and limbs under the torso, each rotating about its joint) plus an `AnimationPlayer` holding the shared clips (`idle`, `walk`, later `attack`, `hit_react`, `defeat`). It exposes a small API and knows nothing about input or AI:
   - `play(anim: StringName)` - play a clip.
   - `set_facing(dir: Facing.Dir)` - select the facing (swaps to the down/up/side part-set and mirrors for the opposite side).
   - `apply_skin(skin: CharacterSkin)` - set the part textures + palette.
2. **`CharacterSkin` (Resource, `.tres`)** - pure data: the set of part textures (per facing) and an optional palette tint. This is the "swappable parts" mechanism (Godot's stand-in for Spine skins). One `.tres` per character: `human_default.tres`, recolours for the NPC/opponent now, distinct skins per race/calling later. Same rig, different skin.
3. **`Actor` (CharacterBody2D)** - movement + logic + the animation **state machine** (the single source of truth for motion state, per the animation discipline). It owns a `CharacterRig` child and drives it: the state machine decides the state, then calls `rig.play(...)` / `rig.set_facing(...)`. The Player is an Actor with player input; the NPC and opponent are Actors with AI or none. This decouples "how it moves/decides" from "how it looks."

```
Actor (CharacterBody2D)        # movement, state machine, input/AI
├─ CharacterRig (instance)     # the reusable visual rig + AnimationPlayer
│  ├─ Torso (Sprite2D)
│  │  ├─ Head, ArmLeft, ArmRight, LegLeft, LegRight (Sprite2D, each rotates at its joint)
│  └─ AnimationPlayer
├─ CollisionShape2D
└─ Camera2D (player only)
```

## Reuse rule
Same body type + proportions -> **one `CharacterRig`, many `CharacterSkin`s**. A genuinely different body type (if one ever appears) -> a new rig scene. The current M1 `player.gd` becomes the Player Actor; its placeholder shapes are replaced by a `CharacterRig` instance carrying the human skin.

## Rig technique (start simple, upgrade later)
- **Now:** `Sprite2D`-cutout with forward-kinematics - parts parented at joints, animated by keying rotation/position in the `AnimationPlayer`. Simplest path to a readable walk and the fastest way to learn keyframing.
- **Later (per ADR-0002's locked skeletal approach):** upgrade the parts to `Polygon2D` + `Skeleton2D`/`Bone2D` with mesh deformation + IK for squash/stretch and bendy limbs. The skin/animation/API design above does not change, so this is an in-place upgrade, not a rebuild.

## Build order once the parts land
1. `CharacterRig` scene with the six part Sprites wired to the `human/down` textures, pivots at the spec's joints.
2. `idle` clip (subtle breathing/weight-shift) - learning step 2; verify it reads top-down (the spike).
3. `walk` clip (down facing) - learning step 3.
4. Refactor `Player` into an Actor that hosts the rig; remove the placeholder block. Now it walks.
5. Add the NPC/opponent later by instancing the same rig with a recoloured skin.
