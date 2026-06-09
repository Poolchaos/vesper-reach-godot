# Asset spec - human cutout (v1 rig)

The art contract for the first character's rig. This is what to create so the reusable rig can be built. Asset-spec gate: no rig/animation code is written until this exists. The rig that consumes these parts: [../design/character-component.md](../design/character-component.md).

**Source:** AI-generated, true-chibi full-body Human in a rig-friendly A-pose, per the prompt in [../image-prompts.md](../image-prompts.md), then cut into the parts below. (The old [human.png](../../legacy/vesper-reach/src/assets/characters/races/human.png) is a loose identity reference only; the new true-chibi generation supersedes it.)

## View and facings
The game is a 3/4 top-down RPG: characters are seen from the front, slightly above (human.png's straight-on front view is essentially the **down** facing). A 4-direction character needs three part-sets:
- **down** (front view) - build this FIRST. Generate the true-chibi full-body in an A-pose (prompt in image-prompts.md), then cut.
- **up** (back view) - later.
- **side** (profile) - later; the other side is the same art mirrored (flip flag, not new art).

Do **down only** for now. We get it rigged + walking + reading well before drawing the back and side sets.

## Parts (down/front set)
Ten parts: limbs split into two segments so they bend at the elbow/knee. Hair can be part of the head; hand baked into the forearm, foot/boot into the shin.

| File | Part | Joint / pivot (rotates about) |
|------|------|-------------------------------|
| `head.png` | head + hair + face | base of the neck |
| `torso.png` | torso + hips (the body core) | its own center (the root part) |
| `upper_arm_left.png` / `upper_arm_right.png` | shoulder to elbow | shoulder |
| `forearm_left.png` / `forearm_right.png` | elbow to hand (hand included) | elbow |
| `thigh_left.png` / `thigh_right.png` | hip to knee | hip |
| `shin_left.png` / `shin_right.png` | knee to foot (boot included) | knee |

Each segment must draw its joint ends fully (a little past the elbow/knee) so the two overlap with no gap when bent. (The first rig used single-piece arms/legs; this splits them for knee/elbow bend.)

## Export convention (important - makes assembly trivial)
- **Transparent PNG**, one file per part.
- **Shared canvas:** export every part on the **same canvas size** (the full character's bounding box from the source), each part drawn in its correct position, transparent everywhere else. Overlaying all six at origin then reassembles the whole character with no manual offsets. Easiest, most forgiving workflow.
- **Neutral rest pose:** arms hanging naturally at the sides, legs straight, standing - the pose all animations key away from.
- **Resolution:** work at human.png's native resolution; I will scale the rig in-engine. Keep it crisp (no pre-scaling blur).
- Each limb is a **clean, complete piece** including the bit that tucks under the torso/shoulder (so it doesn't show a gap when it rotates). Draw the shoulder/hip end a little past the joint.

## Cutting workflow (full image -> parts)
The AI generates one assembled full-body on a white background, not separated parts - that is expected. Generating parts individually is unreliable (they won't match), so generate-whole-then-cut is the pipeline, and the A-pose makes it tractable.
1. **Remove the white background.** GIMP/Krita: Select By Color -> white -> Delete, or Color-to-Alpha on white. (Or drop the full image in the repo and I will flood-fill it from the edges so interior whites like eye-shine survive.)
2. **Cut each part to its own layer, generously at the joint** - extend the arm up *into* the shoulder and the leg up *into* the hip, so a small rotation never exposes a gap.
3. **Layer order: torso on top of the limb tops.** With the torso covering the shoulders/hips, a modest swing hides the joint, so little-to-no hidden-area repainting is needed for a first walk.
4. **Export** each part on the shared full-size canvas (transparent), per the export convention above.

Keep the generated source at `game/assets/characters/human/down/raw/full.png` for reference/re-cuts.

## Files on disk
Drop the parts here (create the folder):
```
game/assets/characters/human/down/
  head.png  torso.png  arm_left.png  arm_right.png  leg_left.png  leg_right.png
```
Naming convention for later facings: `.../up/<part>.png`, `.../side/<part>.png`.

## What I do once these land
Build the reusable `CharacterRig` (parts wired to these textures, pivots set at the joints above), author the idle, then the walk, and replace the placeholder block in the test scene. The down-facing walk validates the #1 risk (does a painted cutout read top-down) before you draw the up/side sets.

## Open choices to confirm before you cut
- Six single-piece parts as above, or do you want elbows/knees split now (more joints = more work, more polish)?
- Hair baked into `head.png` (simplest) or a separate `hair.png` (lets it sway later)?
