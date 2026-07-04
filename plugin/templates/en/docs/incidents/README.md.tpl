# Incident log — {{PROJECT_NAME}}

Postmortems of incidents with real impact: **one file per incident**, `YYYY-MM-DD-slug.md`, most recent first. Use [`template.md`](template.md) as the skeleton.

## When to open a postmortem (and when not)

A postmortem is for an **event** — not a general lesson, not an ordinary bug, not work to be done:

| You have… | Where it goes |
|---|---|
| An ordinary bug, fixed | The **commit / PR** is enough — nothing to write here |
| General, timeless knowledge ("don't do X under condition Y") | [`../lessons-technical.md`](../lessons-technical.md) |
| Remaining work to plan | [`../backlog/`](../backlog/README.md) |
| An **event** with real impact, surprising, worth a timeline, that generates follow-up actions | **Here**, a postmortem |

A postmortem often **produces** a lesson and follow-ups: it **references** them (frontmatter `lessons:` / `follow-ups:`) rather than duplicating them. The generalizable lesson goes in `lessons-technical.md`, remaining work in `backlog/`, and the postmortem points at them.

## Index

<!-- One row per postmortem, most recent on top. -->

| Date | Incident | Severity | Status |
|---|---|---|---|
| <!-- YYYY-MM-DD --> | <!-- title + link --> | <!-- free --> | <!-- open / resolved --> |
