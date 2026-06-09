# Parking lot

Good ideas raised out of phase. Parked here so they are not lost, to be decided in the phase noted. Not commitments.

## For Phase 5 (Progression & Combat)

- **Starter model: one fixed protagonist + recruitable team, vs. choosing among distinct starters.** (Raised 2026-06-08.) Phillip-Juan's instinct: if starters differ, the choice must *matter* (tank vs damage vs ranged archetype vibes). Interacts with: the "2 callings per race" structure (callings are the natural home for archetype identity) and the animation budget (each distinct archetype = another full animation set; a controllable party multiplies animation + AI + input work). Claude's lean: one deeply-animated controlled character, callings carry the archetype flavour, treat any "team"/party as a scope multiplier to justify hard before adding.

## For the animation state machine (roadmap M6 / generalize step)

- **Use a node-based state machine for the player; AnimationTree for enemies.** (Advice Phillip-Juan received, 2026-06-09.) Rationale: the player has input-driven, interruptible transitions (idle/walk/attack/hit/dodge) that a code/node state machine expresses cleanly with explicit control; enemies are more "play the clip for this AI state," which Godot's AnimationTree (AnimationNodeStateMachine) handles well. The current rig uses a simple `CharacterRig.play()` over an AnimationPlayer with blend - fine for now (idle/walk); revisit the structure when attack/hit/combat states land and the player needs real transition logic.
