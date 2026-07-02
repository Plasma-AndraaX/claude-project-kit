---
status: accepted
date: 2026-07-02
deciders: [Plasma-AndraaX]
superseded-by:
related-adrs: []
related-plans: [2026-07-02-journal-incidents]
---

# ADR 0002 — Journal d'incidents / postmortem (module `docs/incidents/`)

## Contexte

Pendant le premier run réel des skills (2026-07-01), un incident concret s'est produit : un sous-agent de test a écrit dans `~/.claude/settings.json` **global** (hors du périmètre projet), une alerte du classifieur de sécurité a suivi, et la cause racine s'est révélée double — une résolution de chemin qui est sortie du projet, et un consentement utilisateur **relayé par un coordinateur** traité (à tort côté agent) comme s'il était direct.

Ce type d'événement n'a **aucune place** dans le kit actuel :
- ce n'est pas un **bug à commiter** (pas de fix de code — `lessons-technical` dit explicitement que le commit suffit pour ça) ;
- ce n'est pas une **leçon** au sens de `lessons-technical` : une leçon est générale et atemporelle (« ne pas faire X quand Y »), alors qu'un incident est un **événement daté** avec une chronologie, un impact, une cause racine, une remédiation et des actions de suivi ;
- ce n'est pas un **item de backlog** (ce n'est pas du travail à faire, c'est un événement à analyser).

Il manque la pièce entre « un commit » et « une leçon » : le **postmortem**. Un postmortem *produit* souvent une leçon (→ `lessons-technical`) et des follow-ups (→ `backlog`), mais il est lui-même l'enregistrement de l'événement.

## Décision

Ajouter au kit un module **`docs/incidents/`**, **profil Full uniquement**, **un fichier par incident** (`docs/incidents/YYYY-MM-DD-slug.md`, comme les ADR/plans datés), avec un gabarit de postmortem structuré (résumé, chronologie, impact, cause racine, remédiation, actions de suivi/leçons produites). Un `docs/incidents/README.md` explique le mécanisme et **quand** ouvrir un postmortem plutôt qu'une leçon ou un simple commit. Le postmortem **référence** les leçons (`lessons-technical`) et follow-ups (`backlog`) qu'il génère, il ne les duplique pas.

## Conséquences

- **Positives** — un endroit dédié pour les événements à vraie matière ; frontière nette avec `lessons-technical` (leçon ≠ événement) et le backlog (analyse ≠ travail) ; format « un fichier par incident » adapté aux postmortems substantiels (chronologie, cause racine).
- **Négatives** — cérémonie non négligeable ; risque de sur-documenter des micro-incidents (atténué par un critère « quand ouvrir » explicite dans le README, et par le profil Full only).
- **Neutres** — absent en Minimal ; un incident sur un prototype se note dans `lessons-technical` ou un commit, faute de mieux, ce qui est acceptable à ce stade de projet.

## Alternatives considérées

- **Journal unique append-only (`docs/incidents.md`)** — rejeté : un postmortem a de la substance (chronologie, actions) ; un fichier unique deviendrait vite illisible et empêcherait de dater/renommer/lier chaque incident individuellement.
- **Étendre `lessons-technical.md`** — rejeté : confond l'événement (daté, ponctuel) et la leçon (générale, atemporelle) — exactement la distinction que ce module veut rendre nette.
- **Ne rien construire** — rejeté : le besoin est démontré par l'incident réel de cette session.

## Références

- Plans liés : [`../plans/2026-07-02-journal-incidents.md`](../plans/2026-07-02-journal-incidents.md)
- Déclencheur / premier postmortem à écrire : l'incident `~/.claude/settings.json` du 2026-07-01, mentionné dans [`../backlog/first-real-run-findings.md`](../backlog/first-real-run-findings.md) § *Point méthodologique*.
