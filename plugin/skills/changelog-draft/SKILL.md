---
description: Produce the user-facing changelog draft for a given release, from docs/changelog/_next.md plus git log / merged PR bodies.
argument-hint: [release version or date]
disable-model-invocation: true
---

# Draft the release changelog

Turn the accumulated notes in `docs/changelog/_next.md` into a formatted, publishable changelog entry for release **$ARGUMENTS**.

## Project overlay

Before anything else, check whether this project provides an overlay for this command at `.claude/armature/changelog-draft.md` (relative to the project root).

- **If it exists**, read it and announce: "**Surcharge projet active** (`.claude/armature/changelog-draft.md`)". It holds named markdown sections that extend this command:
  - `## before` / `## after` — reserved lifecycle hooks: run `## before` now (before the process below), and `## after` at the very end.
  - a section whose name matches a `[project anchor: <id>]` marker placed in this skill — inject its content at that marker's location.
  - any section matching neither a reserved hook nor a declared anchor: ignore it.
  - Execute the `## before` section now if present.
- **If it does not exist**, proceed normally — this command behaves exactly as its base, with nothing injected.

## Sources, in priority order

1. **`docs/changelog/_next.md`** — the primary source. These notes were captured close to the work, in user language; trust them over anything you reconstruct after the fact.
2. **`git log` since the last release tag** — cross-check for user-visible commits that have no corresponding `_next.md` entry. If you find one, that's a gap: either the entry was missed (ask the user, don't silently invent the user-facing framing) or it was genuinely not user-visible (skip it).
3. **Merged PR bodies/titles** *(if this project uses PRs)* — same purpose as git log, useful when commit messages are terse.

**Never use** raw commit messages or internal ticket titles as the changelog text verbatim — they're written for developers, not users. Translate into the same plain-language register as `_next.md`'s entries.

## Process

1. Read `_next.md` and list every entry as a candidate.
2. Cross-check against `git log`/PRs for gaps (see above). Flag any gap to the user rather than guessing at what a silent commit meant for users.
3. Group and order entries in whatever convention this project uses (ask if it's not established yet — e.g. Keep a Changelog's Added/Changed/Fixed/Removed, or a flat reverse-chronological list).
4. Present the draft to the user for review before publishing anywhere.
5. Once approved: append the finished entry to wherever this project's published changelog lives (a `CHANGELOG.md`, a docs site, a release-notes field — ask if not established), then **clear `_next.md`** back to its empty template shape for the next cycle.

> `[project anchor: changelog-output]` — if a project overlay defines a `## changelog-output` section, use its output format, grouping/bucket taxonomy, and destination for steps 3 and 5 (e.g. per-version locale files instead of a single `CHANGELOG.md`). The base spine — sources priority, gap-flagging, review pause, `_next.md` reset — stays unchanged.

> `[project anchor: review-additions]` — if a project overlay defines a `## review-additions` section, fold it into the **review pause** (step 4): e.g. propose per-entry metadata/flags, or reclassify flagged gaps, for the user to decide *during* review rather than at the very end.

## What this skill does NOT do

- It does not translate the output into other languages by default — if this project ships to multiple locales, put that (and any other post-draft artifacts: a metadata file, screenshot captures) in the project overlay's `## after` hook (see `ADAPTING.md` § "Personnaliser une commande du plugin").
- It does not publish anywhere automatically — the last step is a manual/scripted action specific to this project's actual publishing surface.
- It does not invent user-facing framing for a commit with no `_next.md` entry and no clear user impact — ask rather than guess.

### Final — project `after` hook

If a project overlay defined a `## after` section, apply its instructions as the closing step — e.g. locale translations (via a glossary), a metadata file, screenshot captures. No overlay ⇒ skip entirely.
