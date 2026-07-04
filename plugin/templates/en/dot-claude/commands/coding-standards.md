---
description: Propose or refresh docs/coding-standards.md for the project's stack, from up-to-date idiomatic conventions (formatter + style guide) rather than a baked-in table. Documentation only — never scaffolds.
argument-hint: [optional language/stack — otherwise read from CLAUDE.md or detected]
---

# Propose / refresh coding standards

This command fills in or updates [`docs/coding-standards.md`](../../docs/coding-standards.md) with the stack's **idiomatic** conventions, leaning on a **live** documentation source when one is available. Use it mainly when there are no (yet) *observed* conventions to document: a **new project**, **adding a language**, or **refreshing** an ecosystem's conventions.

Stack/language the user may have specified: **$ARGUMENTS**

## What this command does NOT do (read first)

- It **installs nothing**, generates no `.prettierrc`/`.eslintrc`/linter config, doesn't touch `package.json`/`pyproject.toml`. This kit is a *documentation/method* scaffold, not an application one.
- It **doesn't hardcode** a team rule you didn't ask for, nor an exotic/personal convention — it aims for the consensus idiom.
- It **writes nothing without confirmation**: it presents a diff, you approve.

## Phase 1 — Determine the stack

- If `$ARGUMENTS` is set, that's the target language/stack.
- Otherwise, read the **Stack** section of [`CLAUDE.md`](../../CLAUDE.md).
- Otherwise, light detection via root manifests (`package.json`/`tsconfig.json`, `pyproject.toml`/`requirements.txt`, `go.mod`, `Cargo.toml`, `*.csproj`/`*.sln`, `composer.json`, `Gemfile`, `pom.xml`/`build.gradle*`).
- **Multi-language** codebase → handle each ecosystem separately (one subsection per language in Phase 3).

Confirm the list of languages before going further.

## Phase 2 — Fetch idiomatic conventions (live source first)

For **each** language, aim for **two complementary sources**:

- the **formatter** (formatting: indentation, quotes, semicolons, width, trailing commas) — e.g. Prettier (JS/TS), `black`/`ruff` (Python), `gofmt` (Go), `rustfmt` (Rust), `dotnet format` (.NET);
- the **style guide / linter** (naming, structure, imports — what the formatter doesn't set) — e.g. ESLint/typescript-eslint, PEP 8, Effective Go, Rust API Guidelines, Microsoft C# conventions, Google Style Guides.

**How**:
- If an up-to-date docs source is available (`/find-docs` skill, `ctx7` CLI, or equivalent): use it. E.g. resolve the tool (`ctx7 library "Prettier" "default formatting options"`) then fetch docs (`ctx7 docs <id> "..."`). Prefer high-reputation sources. **This is the preferred path**: current, citable conventions.
- **Otherwise** (no live docs tool): fall back to your knowledge of the stack's **widely adopted** conventions — and **flag that fallback** in the generated doc (see the status line in Phase 3).

Never invent: when torn between two conventions, take the one most widely adopted in the ecosystem, and say so.

## Phase 3 — Synthesize into `docs/coding-standards.md`

Fill the existing skeleton (Overview / Conventions per language / Enforcement), without rewriting anything already confirmed on this project:

- **Pivot on tooling** — recommend the idiomatic formatter/linter and "its defaults" rather than re-enumerating every rule it already applies ("adopt Prettier with its default settings"). Then list the key conventions the tool **doesn't** set: naming (files, variables, functions, types), import organization, folder structure.
- **One subsection per language** if the stack is heterogeneous.
- **Status line at the top of the file**: `> Conventions **proposed** on YYYY-MM-DD for the declared stack — to confirm/adjust; they don't yet reflect observed usage.` (and, if the Phase 2 fallback was used: add "proposed from memory, verify against official docs"). Remove/adjust this status once real code confirms the conventions.
- **"Declared vs observed" section**: leave it absent on a new project (nothing observed); on an existing project, **complete without overwriting** the observed part without confirmation.

## Phase 4 — Offer an `.editorconfig` (not by default)

Offer — **without imposing it** — a base `.editorconfig` *derived* from the retained conventions (`root = true`, `indent_style`/`indent_size`, `charset = utf-8`, `end_of_line = lf`, `insert_final_newline = true`, `trim_trailing_whitespace = true`, plus any per-language glob overrides). It's a neutral declarative file, not a dependency. If an `.editorconfig` already exists, show a diff, don't overwrite.

## Phase 5 — Present before writing

Show the proposed diff of `coding-standards.md` (and the `.editorconfig` if retained), with the **sources used** (links if via live docs). Only write after confirmation. Commit (`docs:`) only if the user asks — check `docs/prefs/<login>.md` for their commit conventions if this project uses it.

## Rules

- **Documentation only, never scaffold** — recommend tooling, don't install/configure it.
- **Live source preferred, fallback flagged** — quality and freshness come from `find-docs`/`ctx7`; without it, be transparent about the "from memory" status.
- **"Proposed" made explicit** until real usage has confirmed — don't dress a proposal up as an "in force" convention.
