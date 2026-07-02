---
status: accepted
date: 2026-07-02
deciders: [Plasma-AndraaX]
superseded-by:
related-adrs: []
related-plans: [2026-07-02-strategie-de-test]
---

# ADR 0001 — Stratégie de test des projets bootstrapés (module `docs/testing.md`)

## Contexte

Au premier run réel des trois skills du kit (2026-07-01/02, voir [`docs/backlog/first-real-run-findings.md`](../backlog/first-real-run-findings.md)), un manque est apparu : rien, dans un projet bootstrapé, ne documente *comment ce projet aborde le test*. La seule surface existante est la section `## Test` d'`operations.md`, dont la vocation est le **comment lancer** (les commandes : `npm test`, `pytest`, etc.) — pas le **quoi/à quel niveau/quelle philosophie**.

Il manque une place pour : quels niveaux de test le projet a (unit / intégration / e2e) et pourquoi, ce qu'on ne teste **pas** délibérément, ce qui définit qu'une feature est « testée », et — pour le kit lui-même — le fait que sa vérification repose sur `lint-templates.py` **plus** un run manuel end-to-end des trois skills (justement le trou qui a rendu ce besoin visible).

Le besoin est **démontré**, pas anticipé : l'item était au « fond de tiroir » du backlog en attente d'un déclencheur, et le déclencheur s'est produit.

## Décision

Ajouter au kit un module **`docs/testing.md`** : un fichier dédié, **profil Full uniquement**, distinct de `operations.md § Test`. Il porte la *stratégie* de test (niveaux, philosophie, ce qu'on ne teste pas, définition de « testé »), pas les commandes. `operations.md § Test` reste le lieu du *comment lancer* et gagne un pointeur vers `testing.md`.

## Conséquences

- **Positives** — une place claire et non ambiguë pour la doctrine de test ; le kit peut enfin documenter sa propre stratégie (dogfood) ; frontière nette avec `operations.md` et `lessons-technical.md`.
- **Négatives** — un fichier de plus à générer et à maintenir en parité `en`/`fr` ; risque de rester un squelette vide sur un projet qui ne le remplit pas (atténué en le réservant au profil Full).
- **Neutres** — n'existe pas en profil Minimal : un prototype garde `operations.md § Test` pour le peu qu'il a à dire.

## Alternatives considérées

- **Étendre `operations.md § Test`** — rejeté : mélange « quoi tester » (doctrine, stable) et « comment lancer » (commandes, volatiles) dans une même section, exactement le chevauchement que `persistence-strategy.md` interdit.
- **Ne rien faire, s'en remettre à `lessons-technical`** — rejeté : une leçon est atemporelle et ponctuelle ; une stratégie de test est un document vivant et structuré, pas une entrée append-only.
- **Ne rien construire** — rejeté : le besoin est démontré (cf. Contexte).

## Références

- Plans liés : [`../plans/2026-07-02-strategie-de-test.md`](../plans/2026-07-02-strategie-de-test.md)
- Déclencheur : [`../backlog/first-real-run-findings.md`](../backlog/first-real-run-findings.md)
