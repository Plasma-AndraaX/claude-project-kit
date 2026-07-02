---
date: YYYY-MM-DD
severity: low | medium | high   # free scale to start with; see README
status: open                    # open until follow-ups are closed, then resolved
lessons: []                     # links to the lessons-technical entries produced
follow-ups: []                  # links to the backlog items produced
---

# Incident YYYY-MM-DD — <short title>

## Summary

One or two sentences: what happened, the impact in one line.

## Timeline

- **HH:MM** (or step) — …
- …

## Impact

What was actually affected (data, config, time lost, scope). Stay factual.

## Root cause

Why it happened — the underlying cause(s), not just the symptom.

## Remediation (what was done on the spot)

What was done to contain/fix during the incident.

## Follow-up actions & lessons produced

- [ ] Action / fix to carry out → destination (`backlog/`, commit, …)
- Generalizable lesson extracted → [`lessons-technical.md`](../lessons-technical.md) (reference, don't duplicate)
