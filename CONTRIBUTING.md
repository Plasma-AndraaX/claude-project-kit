# Contributing

This kit is maintained by [Plasma-AndraaX](https://github.com/Plasma-AndraaX) as a personal tool, shared publicly under the MIT license (see [`LICENSE`](LICENSE)).

## Pull requests are welcome, with no merge guarantee

Opening a PR is always welcome. Whether it gets merged depends on a simple test: **is it generalizable and stack-agnostic, or specific/opinionated to your own workflow?**

- **Generalizable** (fixes a real bug, improves a template's clarity, adds a language variant, tightens the `/bootstrap-claude-env` skill's logic) → good candidate for the core kit.
- **Specific/opinionated** (a profile tuned to one ecosystem, a doctrine the maintainer doesn't personally want to carry, a translation into a language the maintainer can't review) → better kept as your own fork or extension rather than pushed into the core. See [`docs/backlog/contribution-and-extension-model.md`](docs/backlog/contribution-and-extension-model.md) for the current thinking on a lighter-weight extension mechanism (not built yet).

## Which files get a `.tpl` suffix

A file under `templates/<lang>/` gets a `.tpl` suffix **iff** `/bootstrap-claude-env`'s Phase 4 must do something to it at generation time — substitute a `{{PLACEHOLDER}}` and/or strip a `FULL-ONLY`/`MINIMAL-ONLY`/`CHANGELOG-ONLY` marker. Everything else is copied byte-for-byte and never gets the suffix: `claude.sh`, `.gitignore`, `.env.claude.example`, `docs/adr/template.md`, `docs/plans/template.md`, `docs/incidents/template.md`, `docs/changelog/_next.md`, every `dot-claude/commands/*.md`, `tools/session-end-capture.sh`. See Phase 4's file mapping in `.claude/commands/bootstrap-claude-env.md` for the authoritative, exhaustive list — don't restate or re-derive this rule elsewhere (`propose-kit-improvement.md`/`pull-kit-updates.md` both point back here instead of repeating it).

## Before opening a PR

- If it touches `templates/`, change **both** `templates/en/` and `templates/fr/`, keeping them in structural parity (same files, same `FULL-ONLY`/`MINIMAL-ONLY`/`CHANGELOG-ONLY` marker placement). Run `python3 tools/lint-templates.py` before submitting — it checks exactly this.
- If it touches `.claude/commands/bootstrap-claude-env.md`, keep the phases in sync with what the templates actually expect (file selection lists, marker semantics).
- If it touches the kit-owned/excluded file lists in `propose-kit-improvement.md`'s Phase 2, make the identical edit in `pull-kit-updates.md`'s Phase 2 — the two skills must agree on exactly which files are in scope for either direction of sync, or one will offer to touch something the other refuses to.
- Small, focused PRs are much easier to triage than large ones bundling several ideas.

## Reporting an issue vs. proposing a fix

Either is fine. If you're not sure whether something is a bug or a deliberate design choice, check [`README.md`](README.md) and [`ADAPTING.md`](ADAPTING.md) first — a fair amount of "why" is already written down there.
