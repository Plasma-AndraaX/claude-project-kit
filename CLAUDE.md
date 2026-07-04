# CLAUDE.md

Guidance for Claude Code sessions working **on this repo** (`Armature` itself). Not to be confused with `plugin/templates/*/CLAUDE.md.tpl`, which is what gets generated **into** bootstrapped projects — different audience, don't conflate the two.

## What this repo is

A bilingual (`en`/`fr`) kit that bootstraps a Claude Code documentation/workflow environment (ADR↔plan↔backlog, `CLAUDE.md`, coding standards, optional changelog module) into any project, via the `/bootstrap-claude-env` skill. See [`README.md`](README.md) for the user-facing pitch, [`ADAPTING.md`](ADAPTING.md) for the reasoning behind every non-obvious design choice.

Current version: **0.4.0** (see [`CHANGELOG.md`](CHANGELOG.md)). Public at `github.com/Plasma-AndraaX/armature`.

## Structure

- `plugin/templates/en/`, `plugin/templates/fr/` — the actual templates, kept in **structural parity** (same files, same `<!-- CHANGELOG-ONLY -->`/`<!-- MEMORYHOOK-ONLY -->` markers). Run `python3 tools/lint-templates.py` after touching either.
- `plugin/skills/bootstrap-claude-env/SKILL.md` — the main skill, generates a project from `plugin/templates/<lang>/`.
- The workflow commands now ship as **plugin skills** (`plugin/skills/<name>/SKILL.md`), invoked `/armature:<name>` (e.g. `/armature:new-adr`, `/armature:dashboard`) — no longer generated into each bootstrapped project's `.claude/commands/`. The old project↔kit sync skills (`/propose-kit-improvement` + `/pull-kit-updates`) and the `.armature-version` stamp they were anchored on were removed with the move to a single installed plugin (ADR 0005).
- `plugin/templates/<lang>/tools/session-end-capture.sh` — optional `SessionEnd` hook (message or headless-auto capture of lessons/changelog).
- `tools/lint-templates.py` — the only automated check that exists. Verifies marker balance, `en`/`fr` parity, and clean rendering across every profile × changelog combination. It does **not** verify the skills actually work when run for real — see below.
- `docs/backlog/README.md` — what's open on the kit itself.
- `docs/adr/` + `docs/plans/` — the kit's own decision records and companion plans. Since 2026-07-02 the kit dogfoods its own ADR ↔ plan machinery (format points at `plugin/templates/fr/docs/adr|plans/template.md` rather than duplicating it).
- `docs/testing.md` — how the kit is tested (lint + manual end-to-end run of the 3 skills). `tools/lint-templates.py` stays the only automated check.
- `docs/incidents/` — postmortems of real-impact incidents hit while working on the kit.

## Where things stand — read this first in a new session

Check [`docs/backlog/README.md`](docs/backlog/README.md) for the current state; don't trust this paragraph to stay accurate as work continues, update it here only if it goes stale. As of `0.1.0`, all 3 skills (`/bootstrap-claude-env`, `/propose-kit-improvement`, `/pull-kit-updates`) have been run for real on a live project (2026-07-01/02) and 9 of the 10 sub-specification frictions found have been fixed (2026-07-02) — see [`docs/backlog/first-real-run-findings.md`](docs/backlog/first-real-run-findings.md). On 2026-07-02, three decisions landed (ADRs 0001/0002/0003): two new Full-profile modules — `docs/testing.md` (testing strategy) and `docs/incidents/` (postmortems) — plus the `/coding-standards` command (both profiles, proposes conventions from the stack via a live docs source). ADR 0003's plan leaves a gated-future Lot 2 (dogfood `/coding-standards` on a real project). Since then (2026-07-03/04) the kit was **renamed `claude-project-kit` → Armature** (repo `Plasma-AndraaX/armature`; version stamp `.claude-project-kit-version` → `.armature-version`; the two deployed projects `voxtrail`/`Unfog` migrated by hand) — see `CHANGELOG.md` [Unreleased], not yet committed. The **plugin migration is now largely built** on branch `armature-rebrand` (not pushed): ADR 0004 (Armature as a Claude Code plugin) + ADR 0005 (single profile, no propose/pull, no `.armature-version` stamp) are implemented — the kit ships under `plugin/` (`plugin/skills/*` invoked `/armature:…`, `plugin/templates/` read via `${CLAUDE_PLUGIN_ROOT}`), one profile, bootstrap refactored, docs+lint aligned; `claude plugin validate --strict` and `lint-templates.py` both green. **Remaining**: Lot 5 — publish the marketplace + re-migrate `voxtrail`/`Unfog` onto the plugin (drop their copied commands), and an end-to-end live test of `/armature:bootstrap-claude-env`. The two `docs/backlog/README.md` "fond de tiroir" items stay dormant.

## Working conventions

- New template content touches **both** `plugin/templates/en/` and `plugin/templates/fr/` — see `CONTRIBUTING.md`.
- Conditional markers (`CHANGELOG-ONLY`/`MEMORYHOOK-ONLY`): **on a table row, keep the marker inline** on the same line as the row — a standalone marker line there leaves a blank line mid-table and breaks it. **Around a multi-line prose block, a marker on its own line is fine**: the strip removes it as a whole line, and both `strip_markers` in `tools/lint-templates.py` and the bootstrap skill absorb the framing blanks so nothing collapses into a double blank line (enforced by the linter's consecutive-blank-line check).
- Changes made directly in a session on this repo should get a `CHANGELOG.md` `[Unreleased]` entry by hand.
- Don't build ahead of a demonstrated need — several backlog items are deliberately deferred with a documented wake trigger rather than built speculatively (see `docs/backlog/contribution-and-extension-model.md` for the clearest example of this doctrine in action).
