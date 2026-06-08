# Conventions

Operational detail kept out of CLAUDE.md so that file stays lean. CLAUDE.md is authoritative where they overlap.

## Documentation structure

Create directories as needed; do not stub empty ones.

```
Vesper reach/
├── CLAUDE.md                 (lean operating instructions, loaded every session)
├── decisions/                (ADRs)
│   ├── README.md             (ADR index)
│   └── ADR-NNNN-<topic>.md
├── docs/
│   ├── INDEX.md              (current state + where things live + next action)
│   ├── PROGRESS.md           (append-only work log, newest first)
│   ├── SPRINT.md             (single active sprint queue)
│   ├── conventions.md        (this file)
│   ├── design/               (per-feature design docs: <feature-kebab>.md)
│   ├── assets/               (per-character/per-set asset specs: <set-kebab>.md)
│   └── animation/            (animation references, GIFs, frame studies)
├── reference/                (screenshots, GIFs, mood boards; date-prefixed: YYYY-MM-DD_label.ext)
├── Games/                    (INHERITED reference only - the old Vesper Reach web projects)
└── src/                      (created when the engine decision lands)
```

Naming: ADRs `ADR-NNNN-kebab-topic.md` (sequential, never edited after sign-off, supersede with a new ADR); design docs `docs/design/<feature-kebab>.md`; asset specs `docs/assets/<set-kebab>.md`; references date-prefixed.

## State-file formats

### docs/INDEX.md
The "where am I, where is everything" doc. Sections: Current state (one paragraph), Where to find things (doc links), Next action. Update on milestone start/finish, decision lock, new top-level doc, or when "next action" changes.

### docs/PROGRESS.md
Append-only, newest at top, every entry timestamped. One line per entry:
`- YYYY-MM-DD HH:MM TZ - <one-line summary> <reference (ADR path, commit SHA, etc.)>`
Group a day under a `## YYYY-MM-DD` heading. Never edit past entries; correct with a new entry that references the old.

### docs/SPRINT.md
Single active queue. Each item an H2:
```
## [<status>] M<NN> <Title>
Goal: <one-line definition of done>
- YYYY-MM-DD HH:MM: created
- YYYY-MM-DD HH:MM: <status change>
Notes:
- <dependencies, references, commit SHA when complete>
```
Statuses (exactly one): `complete` (shipped, verified, committed - SHA in notes), `in-progress`, `todo`, `research-or-planning-needed`, `blocked`. Every status change appends a new timestamped line (UTC); never rewrite past lines.

### When a milestone closes
1. Mark the sprint item `complete` with SHA in notes. 2. Append a PROGRESS.md entry. 3. Update INDEX.md "Next action." 4. If it reflected a decision, ensure the ADR is signed off.

## Development workflow (every code-change task)

13 steps, no skipping; steps 5 and 11 are loop-backs.
1. Analyse the issue; restate it; confirm scope if ambiguous.
2. Investigate the code; read every involved file, caller, test; verify the engine API exists in the installed version.
3. Plan the concrete change set: files, states, transitions, tests, expected performance impact.
4. Cross-check the plan against the code with the plan in hand; look for gaps, broken invariants, missed transitions, frame-budget surprises.
5. If gaps found, restart from step 2.
6. If sound, continue.
7. Implement.
8. Add tests for the testable parts (state machines, math, input mapping). Visuals: manual.
9. Ensure tests pass; no false positives.
10. Prettify: run the formatter and linter.
11. Self-audit the diff as a reviewer who never saw the plan. If anything is unfinished or inconsistent, restart from step 2.
12. Commit only when Phillip-Juan asks. One logical change per commit; reference the ADR/design doc/asset spec.
13. Report what changed, what gates ran, the frame budget the new system uses, and ask Phillip-Juan to verify in-game.

### Required checks before declaring work done
Substitute the engine's equivalents once locked (lint / type-or-build / test). For visual/animation changes additionally: run the game and exercise the feature at the target FPS; walk the animation in slow motion (off-by-one frames are the most common bug); silhouette-test the pose; trace every transition into and out of the new state. State explicitly which checks ran; if a check cannot run this session (no display, engine not installed), say so.

## Commit hygiene

- Never `git add -A`/`.`/`-u` or `git commit -a`. Stage by explicit path.
- Run `git status` and read every entry before staging; stage only what belongs to the commit.
- Never amend a commit you did not author; never force-push main/master (warn if asked).
- No `Co-Authored-By` trailer; commit messages stay author-only.
- Never skip hooks (`--no-verify`) unless Phillip-Juan explicitly asks; if a hook fails, fix the cause.
- Multi-line messages via HEREDOC to preserve formatting.

## Dependency safety (only if a web stack wins in Phase 3)

Before any `npm install <new-package>`, however trivial:
1. Surface the dependency to Phillip-Juan first: exact name + version + publisher + last-published date + weekly downloads + repo URL. No silent installs.
2. Check GitHub Security Advisories for the package; if an unresolved advisory exists at the proposed version, flag it and propose the patched version or an alternative.
3. Check for recent ownership/maintainer changes (last ~90 days) or a sudden version-cadence jump; surface as a flag.
4. Run `npm audit` after install; report high/critical advisories, do not silence them.
5. Never use `latest` as a specifier; pin to an exact verified version. `^`/`~` acceptable only for packages already in the lockfile.
6. Be especially skeptical of packages <1 year old, <10k weekly downloads when better-known alternatives exist, single-maintainer packages, or surprising transitive deps.
7. If unsure, do not install; surface the concern and let Phillip-Juan decide.

## Distribution from Linux (for the Phase 3 decision)

- Linux native: built from the engine; ships as `.tar.gz` / AppImage / Flatpak / Steam.
- Windows: cross-compile from Linux is supported by several engines and by Electron/Tauri; ADR-0001 records the verified cross-build command.
- macOS: Apple's signing toolchain is macOS-only; without a cloud-Mac CI or hardware, macOS distribution is deferred by default.
- Web export exists for some engines but is not a v1 target (PC/Steam is).
- All version numbers and per-engine capabilities are verified live during Phase 3, not asserted from memory.
