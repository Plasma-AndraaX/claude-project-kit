# Coding Standards

The actual style and naming conventions in force in {{PROJECT_NAME}} — indentation, naming, formatting, linting. **Living document** — update as conventions are adopted, or when a later pass finds drift.

> Keep this about *what* the convention is and *how* it's enforced, not *why*. If a style choice was a deliberate architectural decision, cross-reference the relevant ADR or a dated entry in `docs/lessons-technical.md` instead of explaining the reasoning here.

## Overview

<!-- One line: is this codebase consistent across the board, or does it vary by module/language? If heterogeneous, say so explicitly here and use one "Conventions" subsection per area below instead of a single global one. -->

## Conventions

<!-- Homogeneous codebase: fill in the fields below once. Heterogeneous codebase (multiple languages, or drift between subprojects/modules): duplicate this subsection per area, and name each one after the module/language it covers (e.g. "### Backend (C#)", "### Frontend (TypeScript)"). -->

### <Language / module>

- **Indentation**:
- **Line length**:
- **Quotes / string style**:
- **Naming** (files, variables, functions, types):
- **Import / module organization**:
- **Linter / formatter**: (tool + config file, if any)

## Declared vs. observed

<!-- Only keep this section if a real conflict was found — e.g. a linter config states one convention but a meaningful share of the code doesn't follow it. State both sides, record which one is authoritative going forward (the user's call, not an assumption), and date the entry. Delete this whole section if there's nothing to reconcile. -->

## Enforcement

<!-- How is this actually enforced today: a CI lint step, a pre-commit hook, editor config only, or nothing yet? Be honest if it's aspirational rather than enforced — that's useful information too. -->
