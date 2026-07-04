# Journal d'incidents — {{PROJECT_NAME}}

Postmortems des incidents à impact réel : **un fichier par incident**, `YYYY-MM-DD-slug.md`, du plus récent au plus ancien. Utiliser [`template.md`](template.md) comme gabarit.

## Quand ouvrir un postmortem (et quand ne pas)

Un postmortem est pour un **événement** — pas une leçon générale, pas un bug ordinaire, pas du travail à faire :

| Tu as… | Où ça va |
|---|---|
| Un bug ordinaire résolu | Le **commit / la PR** suffit — rien à écrire ici |
| Une connaissance générale et atemporelle (« ne pas faire X quand Y ») | [`../lessons-technical.md`](../lessons-technical.md) |
| Du travail restant à planifier | [`../backlog/`](../backlog/README.md) |
| Un **événement** à impact réel, surprenant, qui mérite une chronologie et génère des actions de suivi | **Ici**, un postmortem |

Un postmortem **produit** souvent une leçon et des follow-ups : il les **référence** (frontmatter `lessons:` / `follow-ups:`) plutôt que de les dupliquer. La leçon généralisable va dans `lessons-technical.md`, le travail restant en `backlog/`, et le postmortem pointe vers eux.

## Index

<!-- Une ligne par postmortem, le plus récent en haut. -->

| Date | Incident | Sévérité | Statut |
|---|---|---|---|
| <!-- YYYY-MM-DD --> | <!-- titre + lien --> | <!-- libre --> | <!-- open / resolved --> |
