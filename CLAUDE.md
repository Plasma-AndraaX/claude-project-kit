# CLAUDE.md

Guidance for Claude Code sessions working **on this repo** (`claude-project-kit` itself). Not to be confused with `templates/*/CLAUDE.md.tpl`, which is what gets generated **into** bootstrapped projects — different audience, don't conflate the two.

## What this repo is

A bilingual (`en`/`fr`) kit that bootstraps a Claude Code documentation/workflow environment (ADR↔plan↔backlog, `CLAUDE.md`, coding standards, optional changelog module) into any project, via the `/bootstrap-claude-env` skill. See [`README.md`](README.md) for the user-facing pitch, [`ADAPTING.md`](ADAPTING.md) for the reasoning behind every non-obvious design choice.

Current version: **0.3.0** (see [`CHANGELOG.md`](CHANGELOG.md)). Public at `github.com/Plasma-AndraaX/claude-project-kit`.

## Structure

- `templates/en/`, `templates/fr/` — the actual templates, kept in **structural parity** (same files, same `<!-- FULL-ONLY -->`/`<!-- MINIMAL-ONLY -->`/`<!-- CHANGELOG-ONLY -->` markers). Run `python3 tools/lint-templates.py` after touching either.
- `.claude/commands/bootstrap-claude-env.md` — the main skill, generates a project from `templates/<lang>/`.
- `templates/<lang>/dot-claude/commands/propose-kit-improvement.md` + `pull-kit-updates.md` — generated into every bootstrapped project; sync changes *to* and *from* the kit using a three-way diff anchored on `.claude-project-kit-version` (SHA + lang + profile + changelog choice, stamped at bootstrap time). Both skills share a strict "kit-owned vs. project-owned" file list — if you edit one skill's Phase 2 list, edit the other's too (see `CONTRIBUTING.md`).
- `templates/<lang>/tools/session-end-capture.sh` — optional `SessionEnd` hook (message or headless-auto capture of lessons/changelog).
- `tools/lint-templates.py` — the only automated check that exists. Verifies marker balance, `en`/`fr` parity, and clean rendering across every profile × changelog combination. It does **not** verify the skills actually work when run for real — see below.
- `docs/backlog/README.md` — what's open on the kit itself.
- `docs/adr/` + `docs/plans/` — the kit's own decision records and companion plans. Since 2026-07-02 the kit dogfoods its own ADR ↔ plan machinery (format points at `templates/fr/docs/adr|plans/template.md` rather than duplicating it).
- `docs/testing.md` — how the kit is tested (lint + manual end-to-end run of the 3 skills). `tools/lint-templates.py` stays the only automated check.
- `docs/incidents/` — postmortems of real-impact incidents hit while working on the kit.

## Where things stand — read this first in a new session

Check [`docs/backlog/README.md`](docs/backlog/README.md) for the current state; don't trust this paragraph to stay accurate as work continues, update it here only if it goes stale. As of `0.1.0`, all 3 skills (`/bootstrap-claude-env`, `/propose-kit-improvement`, `/pull-kit-updates`) have been run for real on a live project (2026-07-01/02) and 9 of the 10 sub-specification frictions found have been fixed (2026-07-02) — see [`docs/backlog/first-real-run-findings.md`](docs/backlog/first-real-run-findings.md). On 2026-07-02, three decisions landed (ADRs 0001/0002/0003): two new Full-profile modules — `docs/testing.md` (testing strategy) and `docs/incidents/` (postmortems) — plus the `/coding-standards` command (both profiles, proposes conventions from the stack via a live docs source). ADR 0003's plan leaves a gated-future Lot 2 (dogfood `/coding-standards` on a real project). No active next priority right now; the two remaining `docs/backlog/README.md` "fond de tiroir" items are deliberately dormant, no active trigger.

## Working conventions

- New template content touches **both** `templates/en/` and `templates/fr/` — see `CONTRIBUTING.md`.
- Profile-conditional markers: **on a table row, keep the marker inline** on the same line as the row — a standalone marker line there leaves a blank line mid-table and breaks it. **Around a multi-line prose block, a marker on its own line is fine**: the strip removes it as a whole line, and both `strip_markers` in `tools/lint-templates.py` and the bootstrap skill absorb the framing blanks so nothing collapses into a double blank line (enforced by the linter's consecutive-blank-line check).
- `/propose-kit-improvement`'s Phase 6 appends to `CHANGELOG.md`'s `[Unreleased]` section for accepted external contributions; changes made directly in a session here should get a `CHANGELOG.md` entry by hand, same discipline.
- Don't build ahead of a demonstrated need — several backlog items are deliberately deferred with a documented wake trigger rather than built speculatively (see `docs/backlog/contribution-and-extension-model.md` for the clearest example of this doctrine in action).
