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

## Consistency (lock the design, or every run differs)
A loose prompt lets the model re-invent the outfit/hair/hood each run. To get a repeatable character:
- **Lock the specifics** in the prompt (exact hair, eyes, skin, the precise outfit + trim + emblem, glow colour, hood or not). Vague adjectives = drift.
- **Fix the seed** if the tool supports it, and reuse it.
- **Reference image (the big one):** once you have THE down-facing sheet you love, feed it back as an image reference (img2img) when generating the up (back) and side facings, so the character carries across directions.

## v1 Human protagonist - DRAFT (confirm the design, then this is locked)
Split-limb parts sheet, down (front) facing. Adjust the [brackets] to the chosen design.

> 2D game character rig sheet: the separated body parts of ONE chibi character laid out flat and spaced apart on a plain white background (knolling), none touching. Parts: head; torso; and each limb split into TWO segments - upper arm + forearm (hand included), thigh + shin (boot included) - for both left and right. Each segment fully drawn and outlined including its joint end, in a neutral straight orientation. Chibi human [male], large head, [short spiky black hair with cool blue highlights], [intense glowing cyan eyes], [fair cool-toned skin], serious neutral expression, [no hood]. Outfit: [sleek dark-charcoal segmented body armor with thin glowing magenta trim and a small chest emblem, matching armored gauntlets and shin boots]. Sleek futuristic dark-fantasy style inspired by Solo Leveling: sharp clean linework, thick bold black outlines, high-contrast cel-shading, cool dark palette with magenta and cyan glowing accents. Consistent style, scale, and lighting across every part. White background, no assembled body, no scene, no text, no shadows.

Notes:
- Generate the **down** (front) facing first; up (back) and side facings come later (use the chosen down sheet as the reference image).
- Parts land in `game/assets/characters/human/down/` per the 10-part list in [assets/human-cutout.md](assets/human-cutout.md).
