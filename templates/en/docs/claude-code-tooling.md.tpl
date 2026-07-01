# Claude Code tooling

Inventory of the Claude Code plugins, skills, subagents, and hooks used (or evaluated) on {{PROJECT_NAME}}. Keep this living — update when you adopt, evaluate, or drop something.

## Strategy

<!-- One paragraph: how deliberate is this project about AI tooling? E.g. "adopt built-ins first, write a custom skill only when a recurring multi-step process needs codifying". -->

## Inventory

### Built-in skills (shipped with Claude Code)

<!-- List the ones actually used, one line each: name — why. -->

### Custom skills (in `.claude/commands/`)

| Skill | Purpose |
|---|---|
| `/bootstrap-claude-env` *(if kept after initial setup — otherwise remove this row)* | Regenerates/extends this environment from `claude-project-kit` |
| `/new-adr` | Guided process to open an ADR + companion plan |
| `/capture-lessons` | Reviews recent work and proposes doc updates |
| `/whats-left` | Tactical view of open backlog/plan items |
| `/dashboard` *(profile Full)* | Regenerates `docs/dashboard.html` |
<!-- CHANGELOG-ONLY --> | `/changelog-capture` | Captures a user-facing changelog note while context is fresh |
| `/changelog-draft` | Drafts the release changelog from `docs/changelog/_next.md` | <!-- /CHANGELOG-ONLY -->

### Plugins / MCP servers

| Plugin or MCP server | Status | Why |
|---|---|---|
<!-- One row per plugin/MCP server considered. Status: `adopted` (enabled in .claude/settings.json or MCP config), `suggested` (relevant, not yet enabled — the user's call), `rejected` (considered, explicitly not adopted). Bootstrap-time suggestions come only from Anthropic-verified plugins (claude.com/plugins) or well-known official vendor MCP servers matching the detected stack — never from an open web search, to avoid recommending an unvetted/unofficial MCP server. This table should not ship empty: at minimum it reflects what bootstrap-time analysis found relevant for this stack, even if every row is `suggested`. -->

### Recommended, not yet enabled

<!-- If any `suggested` row above requires a credential/secret to actually enable (most MCP servers do), the exact setup command/config snippet goes here — never a provisioned secret. The user runs it themselves when ready. Delete this section if nothing is pending. -->

### Hooks catalog

<!-- List hooks configured in .claude/settings.json and what each does. The memory-block hook (if enabled) belongs here. -->

## Out of scope (deliberately skipped)

<!-- Things considered and explicitly not adopted, with the reason — saves re-litigating later. -->

## How to evaluate a new plugin/skill

<!-- Your team's bar for adopting new AI tooling — e.g. "must solve a problem that recurred at least twice", "must not require secrets beyond what's already granted". -->

## Security baseline

<!-- Any constraints on what tools/hooks are allowed to do (network access, credential handling, destructive commands). -->

## References

<!-- Links to plugin marketplaces, internal discussions, etc. -->
