# Changelog

User-facing release notes for {{PROJECT_NAME}} — what changed, from the perspective of someone using the product, not the codebase. Distinct from `docs/plans/` (which is internal, implementation-focused) and from git history (which is developer-focused).

## Mechanism: capture now, draft at release time

Writing a changelog entirely at release time loses detail — by then nobody remembers the nuance of why a fix mattered or what the user-visible edge case was. Instead:

1. **`/changelog-capture`** — run this *while the context is fresh* (right after shipping something user-visible) to append a short editorial note to [`_next.md`](_next.md).
2. **`/changelog-draft`** — run this *at release time* to turn the accumulated notes in `_next.md` into a formatted release entry, then clear `_next.md` for the next cycle.

## `_next.md`

A running, unformatted scratch file — see [`_next.md`](_next.md) itself for the exact shape. It is **not** the published changelog; it's the raw material `/changelog-draft` consumes.

## What this module does NOT provide

- **Multi-language translation** of release notes. If your project ships to users in multiple locales, that's a real extension worth building (see `ADAPTING.md` in the kit repo), but it's a product decision this kit doesn't make for you.
- **Publishing** (in-app display, a docs site, a mailing list). `/changelog-draft` produces the text; where it ends up published is specific to your product.
- A fixed output format. Adapt `/changelog-draft`'s instructions to whatever convention you use (Keep a Changelog, GitHub Releases, a custom in-app format).
