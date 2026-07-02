---
date: YYYY-MM-DD
severity: low | medium | high   # échelle libre au départ ; voir README
status: open                    # open tant que les follow-ups ne sont pas bouclés, puis resolved
lessons: []                     # liens vers les entrées lessons-technical produites
follow-ups: []                  # liens vers les items backlog produits
---

# Incident YYYY-MM-DD — <titre court>

## Résumé

Une ou deux phrases : ce qui s'est passé, l'impact en une ligne.

## Chronologie

- **HH:MM** (ou étape) — …
- …

## Impact

Ce qui a été réellement affecté (données, config, temps perdu, périmètre). Rester factuel.

## Cause racine

Pourquoi c'est arrivé — la ou les causes profondes, pas seulement le symptôme.

## Remédiation (ce qui a été fait sur le coup)

Ce qui a été fait pour contenir/corriger pendant l'incident.

## Actions de suivi & leçons produites

- [ ] Action / correctif à mener → destination (`backlog/`, commit, …)
- Leçon généralisable extraite → [`lessons-technical.md`](../lessons-technical.md) (référencer, ne pas dupliquer)
