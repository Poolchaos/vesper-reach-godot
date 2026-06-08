# ADR-0001 - Engine & tooling

**Status:** Accepted 2026-06-08 - Godot 4 (4.6.3 current stable), free built-in 2D bones; Spine deferred.
**Date:** 2026-06-08

## Context
v1 is a 2D top-down chibi RPG using locked **2D skeletal/cutout** animation (ADR-0002), 4-direction first. Constraints: PC/Steam-first (native desktop export, controller, clean Steam path); Linux-native dev (Linux Mint); solo senior web developer who has shipped an Electron app to Steam before; goal is learning real animation; **no paid tools for now** (stated 2026-06-08). All facts verified live 2026-06-08 (sources in the Phase 3 chat turn).

Key constraint consequence: **Spine is out for v1.** Its IK, weighted meshes, and skins are all Professional-only ($379); the $69 Essential tier lacks exactly the features the skeletal approach needs. The free skeletal-authoring landscape is otherwise thin (DragonBones rebranded to LoongBones with paid tiers + uncertain compatibility). This favours an engine with a *built-in, free* skeletal rig editor.

## Candidates

### A. Godot 4 + built-in 2D skeletal - RECOMMENDED
- Free, MIT, no royalties, no revenue ceiling. Native Linux editor.
- Built-in Skeleton2D / Bone2D with **IK and mesh deformation included free** - the same capabilities Spine gates behind $379. Visual scene + AnimationPlayer editor keeps focus on animation, not plumbing.
- Steam: GodotSteam (free; 2026 releases support Godot 4.4+, Win/Linux/macOS) and Godot is officially documented by Valve in Steamworks. Native desktop exports; built-in controller/input support.
- Optional future upgrade: Esoteric ships an official spine-godot GDExtension runtime, so Spine can be added later without re-platforming if its tooling/skins are ever wanted.
- Cost to the learner: a new engine + GDScript (Python-like, trivial for a senior dev). Offset by removing the self-built engine/animation scaffolding the web path requires.

### B. Web stack wrapped: Electron (or Tauri) + PixiJS/Phaser
- Free, open-source libs; lowest learning ramp for a senior web dev; proven Steam shipping (Phaser+Electron, e.g. Desktop Heroes, Oct 2025); Electron's bundled Chromium gives consistent rendering.
- Weaknesses for THIS project: no built-in scene/animation editor (you build the engine layer yourself - friction for an animation-learning project); **free skeletal authoring is now thin** (Spine paid, LoongBones uncertain), so you would likely author rigs in Godot/another tool anyway; Steam-from-JS relies on third-party libs (greenworks/steamworks.js) that are "often outdated and poorly maintained" - the exact pain Phillip-Juan has already hit.
- Tauri sub-variant rejected: uses the OS webview (WebKitGTK/WebView2/WebKit), so WebGL/canvas rendering is inconsistent across platforms, and it has the least game/Steam tooling.

### C. Defold + Spine extension
- Free, lightweight, truly cross-platform, proven Steam releases.
- But its skeletal path consumes **Spine-format** assets, which need a Spine-format authoring tool (paid, or the uncertain LoongBones). Weak fit for a no-fee user. Smaller community/ecosystem; Lua.

### Considered and rejected
- **Unity 6:** runtime fee canceled; Personal free under $200k revenue (no fee), Spine + 2D animation, Steamworks.NET. Rejected as primary: heavy for a 2D chibi game, lingering licensing-trust whiplash, more engine than a solo 2D learner needs when Godot is free + lighter.

## Decision
LOCKED 2026-06-08: **Godot 4** (standard / GDScript build; current stable **4.6.3**, released 2026-05-20; pin the exact installed version at install time), using its **built-in free 2D skeletal system** (Skeleton2D / Bone2D / IK / mesh deform). **Spine deferred** - a paid tool, declined for now; the official spine-godot GDExtension runtime keeps it as a no-rework future upgrade. Web stack (B) and Defold (C) rejected primarily because a no-fee skeletal-authoring path is weak outside an engine with a built-in rig editor; Unity rejected as heavy with a licensing-trust overhang.

License: MIT, no royalties, no revenue ceiling. Distribution: native desktop exports (Linux/Windows/macOS); Steam via GodotSteam (free). macOS distribution still needs Apple's macOS-only signing chain and stays deferred.

## Consequences (if A is locked)
- Replaces the "no engine, no code" gate: engine-specific work (a Godot project, the cutout rig, the state machine) can begin once this ADR is signed off.
- Install Godot 4 (latest stable, version pinned at sign-off) natively on Linux; verify the export templates + a GodotSteam path before relying on them.
- The human cutout rig is authored against Godot's bone system; the asset spec (asset-spec gate) documents part separation + pivots.
