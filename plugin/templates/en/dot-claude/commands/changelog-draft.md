---
description: Produce the user-facing changelog draft for a given release, from docs/changelog/_next.md plus git log / merged PR bodies.
argument-hint: [release version or date]
---

# Draft the release changelog

Turn the accumulated notes in `docs/changelog/_next.md` into a formatted, publishable changelog entry for release **$ARGUMENTS**.

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

## What this skill does NOT do

- It does not translate the output into other languages — if this project ships to multiple locales, that's a separate, project-specific extension (see `ADAPTING.md` in the kit this was bootstrapped from).
- It does not publish anywhere automatically — the last step is a manual/scripted action specific to this project's actual publishing surface.
- It does not invent user-facing framing for a commit with no `_next.md` entry and no clear user impact — ask rather than guess.
