# Image prompts

Canonical home for AI-generation prompts. Prompts live here, never pasted as the source-of-truth into chat or code (they rot there). Run them from this file. All art must hit the locked aesthetic and, for anything rigged, the parts rule below.

## Style anchor (locked)
Chibi proportions (large head ~1:2 head-to-body, compact body, short limbs, big expressive eyes) rendered in a **sleek futuristic dark-fantasy style inspired by Solo Leveling**: sharp clean linework, **thick bold black outlines**, high-contrast cel-shading, a cool/dark palette accented with **glowing magical highlights** (a polished system-RPG feel), sleek modern-fantasy clothing/gear, dramatic edge/rim lighting. Single character, centred, **white background** (AI tools can't output true alpha; flat white keys out cleanly). NOT soft pastel storybook, NOT pixel art, NOT AAA realism. Inherited Vesper Reach world + races, reinterpreted in this look.

## Two art languages (don't mix)
- **(A) Character cutouts** - white background, no scene baked in, so the engine composites them. Hero, NPCs, enemies; the rig parts are this kind.
- **(B) Scene backgrounds** - painted environments, no live characters in frame, so cutouts composite on top. Comes later.

## Getting riggable parts - two routes
- **Route 1 (Phillip-Juan's preference): generate in parts.** A flat rig sheet of separated, complete body parts. Finicky - the model often draws the body assembled or makes parts inconsistent in scale/style, so expect iteration. When it works, cutting is trivial (parts already apart and complete).
- **Route 2 (reliable fallback): generate the whole character in an A-pose, then cut.** The A-pose means cutting mostly along visible gaps with minimal repainting. Claude can strip the white background and rough-slice to shrink the manual cutting.

## Parts rule
The character must end up as 6 parts: `head`, `torso`, `arm_left`, `arm_right`, `leg_left`, `leg_right` - each a complete separate piece in a neutral straight orientation, with the joint end (shoulder/hip/neck) drawn a little past the connection. A whole-character source must be front-facing, symmetrical, A-pose (arms clear of the torso, legs apart).

## v1 Human protagonist (character cutout) - fill [brackets]

### Route 1 - parts sheet (try first)
> 2D game character rig sheet: the separated body parts of ONE chibi character laid out flat and spaced apart on a plain white background (knolling), none touching or overlapping - head, torso, left arm, right arm, left leg, right leg, each a complete separate piece in a neutral straight orientation. [Male/female] human, chibi proportions (large head). Sleek futuristic dark-fantasy style inspired by Solo Leveling: sharp clean linework, thick bold black outlines, high-contrast cel-shading, cool/dark palette with subtle glowing magical accents, sleek modern-fantasy clothing. Consistent style, scale, and lighting across every part. White background, no assembled body, no scene, no text, no shadows.

### Route 2 - whole A-pose (fallback, cut after per assets/human-cutout.md)
> True-chibi 2D fantasy RPG character, full body, single character, centred. Large head ~one-third of total height, compact body, short limbs, big expressive eyes. [Male/female] human, [short brown] hair. Sleek futuristic dark-fantasy style inspired by Solo Leveling: sharp clean linework, thick bold black outlines, high-contrast cel-shading, cool/dark palette with subtle glowing magical accents, sleek modern-fantasy clothing. Front-facing and symmetrical, relaxed A-pose with arms held out away from the sides (not touching the torso) and legs slightly apart, feet flat, neutral expression facing the viewer. White background, no scene, no props, no text, no shadows.

Notes:
- Generate the **down** (front) facing first; up (back) and side facings come later, after the down-facing rig + walk reads well.
- Parts land in `game/assets/characters/human/down/` as the 6 filenames above. Cutting + white-bg removal: [assets/human-cutout.md](assets/human-cutout.md).
