# v1 slice (locked 2026-06-08)

The canonical definition of the smallest playable, animation-teaching v1. Locked in Phase 1. Change only by explicit decision (note it in PROGRESS.md).

## Premise
One chibi Human in a single small scene: move, talk to an NPC, fight one sparring opponent with one attack. The smallest build that is both a real game and a complete single-character animation lesson.

## Contents
- **Scene.** One small test room/clearing. Nothing beyond it.
- **Player.** One chibi Human; top-down movement; KB+M and/or controller.
- **NPC.** Same human rig, recoloured (temporary scaffolding); idle only; walk into range -> interact prompt -> 1-2 line dialogue box; no branching.
- **Sparring opponent.** Same human rig, recoloured (temporary); approaches and attacks back; player has one attack; both can be defeated (shared `defeat`); player hit plays `hit_react`; defeat resets the spar (no game-over screen).

## Core animation set (authored once on the human rig)
`idle`, `walk`, `attack`, `hit_react`, `defeat`.
(The number of facing directions each state needs is a Phase 2 decision and multiplies this set.)

## Rig-reuse note
The one rig is used three ways (player, NPC, opponent), recoloured each time. This is temporary scaffolding to move fast, not the shipped look, and it previews how the later roster (3 races x 2 callings + awakening) scales: one rig, swapped parts/palettes.

## Deferred (explicitly out of v1)
Aquarian + Florakin; full callings; awakening; multiple attacks/combos; inventory/loot; leveling/XP; save system; branching dialogue; any scene beyond the room; recruitable-team / distinct-starter model (parked, see [parking-lot.md](../parking-lot.md)).
