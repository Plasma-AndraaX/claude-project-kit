---
description: Capture a short editorial note for the user-facing changelog, from the current conversation, into docs/changelog/_next.md.
argument-hint: [optional — what to capture, if not obvious from the conversation]
disable-model-invocation: true
---

# Capture a changelog note

You just shipped something user-visible (a fix, a feature, a behavior change) and the context is fresh. Write a short, plain-language note now — not at release time, when the nuance will be gone.

$ARGUMENTS

## What belongs here

- **User-visible** changes: something a user of the product would notice or care about. Not internal refactors, not test additions, not dependency bumps with no behavior change.
- **Plain language**: no jargon, no internal class/file names, no ticket numbers. Write for the person using the product, not the next developer.
- **Honest about scope**: if it's a partial fix or has a known limitation, say so in one clause — don't oversell.

## What does NOT belong here

- Internal refactors, test-only changes, CI/tooling changes — unless they have a user-visible side effect (e.g. "the app now starts noticeably faster").
- Anything already covered by an existing unreleased entry — check `_next.md` first, extend an existing note rather than duplicating.
- Screenshots or captures containing real user data / PII — genericize or redact before including.

## Process

1. Read `docs/changelog/_next.md`. If today's change is already covered by an existing entry, extend it instead of adding a new one.
2. Append a new dated entry following the shape shown in `_next.md`'s comment: a one-line header (what changed, in user terms) + 1-3 sentences of plain-language body.
3. Don't touch anything else in the file — this is append-only until `/changelog-draft` clears it at release time.

## What you do NOT do

- Don't write marketing copy or hype — factual and plain beats enthusiastic and vague.
- Don't guess at user impact you're not sure of — ask the user if the framing is right before committing an ambiguous entry.
- Don't run this for changes with zero user-visible surface — it's fine to say "nothing changelog-worthy here."
