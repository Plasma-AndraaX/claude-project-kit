# Journal d'incidents — Armature

Postmortems des incidents à impact réel survenus **en travaillant sur le kit** : un fichier par incident, `YYYY-MM-DD-slug.md`, du plus récent au plus ancien. Le kit utilise pour la forme le gabarit qu'il génère lui-même — voir [`../../templates/fr/docs/incidents/template.md`](../../templates/fr/docs/incidents/template.md) (dogfood).

## Quand ouvrir un postmortem (et quand ne pas)

Un postmortem est pour un **événement** — pas une leçon générale, pas un bug ordinaire, pas du travail à faire :

| Tu as… | Où ça va |
|---|---|
| Un bug ordinaire résolu | Le **commit / la PR** suffit — rien à écrire ici |
| Une connaissance générale et atemporelle | `backlog/first-real-run-findings.md`, `ADAPTING.md`, ou un doc de décision (le kit n'a pas de `lessons-technical.md` propre) |
| Du travail restant à planifier | [`../backlog/`](../backlog/README.md) |
| Un **événement** à impact réel, surprenant, qui mérite une chronologie et génère des actions de suivi | **Ici**, un postmortem |

## Index

| Date | Incident | Sévérité | Statut |
|---|---|---|---|
| 2026-07-01 | [Écriture dans `~/.claude/settings.json` global hors périmètre, et consentement relayé par coordinateur](2026-07-01-settings-json-global-hors-perimetre.md) | medium | resolved |
