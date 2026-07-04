# Testing strategy — {{PROJECT_NAME}}

*How* this project approaches testing: the **doctrine**, not the commands. For *how to run* (concrete commands), see [`operations.md`](operations.md) § Test. For a one-off testing gotcha found along the way, see [`lessons-technical.md`](lessons-technical.md).

## Philosophy

<!-- One paragraph: how much this project leans on automated testing vs. review vs. manual runs, and why. State the accepted tradeoff (e.g. "no CI at this stage — verification via lint + a manual run of the happy path before merge"). -->

## Test levels

<!-- Which levels actually exist and why those. One row per level in place — don't list aspirational levels. -->

| Level | Tool / framework | Scope | When it runs |
|---|---|---|---|
| <!-- e.g. unit --> | <!-- e.g. pytest --> | <!-- what it covers --> | <!-- e.g. before each commit --> |

## What we deliberately don't test

<!-- What's intentionally out of test scope, and why (cost/value). As important as what we do test. -->

## Definition of "tested"

<!-- The bar that makes a change count as covered before merge. E.g. "lint passes + the happy path was exercised at least once". -->

## How to run

See [`operations.md`](operations.md) § Test for the concrete commands — don't duplicate them here.
