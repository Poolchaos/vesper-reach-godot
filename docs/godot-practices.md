# Godot practices

Conventions for this project's Godot 4 / GDScript code, weighted toward performance, memory, and leak avoidance (the machine-health concerns). CLAUDE.md carries the short version; this is the detail. Grounded in current Godot docs + community (2026).

## Mental model (coming from React)

| React | Godot |
|-------|-------|
| component | scene (`.tscn`) + its script |
| component tree | node tree |
| props / children | exported vars + child nodes |
| `componentDidMount` | `_ready()` |
| events / callbacks up | signals |
| global store / context | autoload (singleton) |
| exported class | `class_name` on a script |

Give a reusable script a name with `class_name Foo` (next to `extends`) so it is usable as a type anywhere without `preload`.

## Performance

- **Statically type hot code.** Typed GDScript runs ~28-59% faster on hot paths (Vector2 math, loops, frequently-called funcs) because the VM skips Variant dispatch. Type `_process` / `_physics_process`, movement, and loops; do not bother typing one-off UI callbacks. Enable the editor's add-type-hints completion.
- **Right tick for the job.** `_physics_process(delta)` for movement/physics (fixed timestep); `_process(delta)` for visuals. Keep both light. Animation advances by `delta` (see CLAUDE.md animation discipline).
- **No per-frame waste.** Do not allocate or call `get_node()` every frame; cache nodes with `@onready var x := $Path`. Avoid building node paths inside loops.
- **Profile first.** Use the built-in Profiler and the Monitors panel before optimising; record the frame-budget delta in the system's design doc (60 FPS = 16.6 ms/frame).

## Memory and leaks

Godot runs two memory systems:
- **RefCounted** (Resources, many utility classes): reference-counted, freed automatically.
- **Object / Node**: you free them. Free a node with `queue_free()` (safe, end of frame); `free()` is immediate and riskier.

**Orphan nodes** are the classic leak: a node created with `.new()` / `instantiate()` but never added to the tree, or `remove_child()`-ed without being freed. A single forgotten `queue_free()` in a spawn loop leaks thousands per session. Guard reuse of a possibly-freed reference with `is_instance_valid(ref)`.

**Leak check (run when any spawn/free system lands):**
1. Debug > Monitors > Object > **Orphan Nodes** (and Object Count). Note the baseline.
2. Play; perform the suspected action repeatedly (open/close a UI, spawn/kill the opponent, enter/exit a spar).
3. Compare counts. If they climb and never settle, you leaked.
4. Call `print_orphan_nodes()` to dump the leaked types + paths.
5. Find where that type is instantiated; add the missing `queue_free()` or disconnect the stale reference.

## Signals (decoupling)

The decoupled-event system ("buttons work with signals"):
```gdscript
signal died(by_attacker)              # declare

died.emit(self)                       # emit

func _ready() -> void:                # listen
	enemy.died.connect(_on_enemy_died)

func _on_enemy_died(attacker) -> void:
	pass
```
- Use the **typed form** `node.signal_name.connect(_on_x)` (static-checked, no string typos), not `connect("signal_name", ...)`.
- `bind(extra)` appends args so a listener knows which emitter fired (e.g. which opponent died).
- **Leaks:** connecting a node's method to a **long-lived object's** signal (an autoload, or a parent that outlives the child) keeps the child alive. Disconnect in `_exit_tree()`, or use `CONNECT_ONE_SHOT` for fire-once. Avoid connecting **lambdas**: each `func(): ...` is a new `Callable` you cannot easily disconnect, and capturing `self` extends the node's lifetime. Prefer named methods; if a lambda is unavoidable, store it in a var so you can disconnect the same `Callable`.

## Autoloads (global singletons)

An autoload is a node parented before any scene loads, reachable by name everywhere (the "global script" advice). Good for genuinely cross-scene state/managers: player stats, a game clock, an input/router service.
- It is **not** a true singleton (it can still be `.new()`-ed again); it is a convenience for global access.
- It is the **most overused** feature. Global mutable state becomes hard to trace and a coupling + leak hazard. If something does not truly need global reach, pass a reference or use a scene-scoped node instead.
- Notify changes via **signals**, not by letting everyone poke the autoload's fields. Because autoloads never free, they are the number-one place stale signal connections leak: always disconnect.

Sources: [Godot docs - Singletons/Autoload](https://docs.godotengine.org/en/stable/tutorials/scripting/singletons_autoload.html), [Static typing in GDScript](https://www.beep.blog/2024-02-14-gdscript-typing/), [orphan-node leak detection](https://bugnet.io/blog/how-to-find-memory-leaks-in-godot-games), [Godot 4 signal patterns](https://godot-mcp.abyo.net/guides/godot4-signals).
