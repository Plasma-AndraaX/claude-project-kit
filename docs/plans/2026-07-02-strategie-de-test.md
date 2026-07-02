---
status: implemented
created: 2026-07-02
settled: 2026-07-02
related-adr: 0001
---

# Plan — Module `docs/testing.md` (compagnon de l'ADR 0001)

Compagnon de [l'ADR 0001](../adr/0001-strategie-de-test.md). Capture *comment* le module stratégie-de-test est implémenté dans le kit, et *ce qui* reste ouvert.

## Reformulation du problème

Il faut ajouter, à l'arsenal Full du kit, un fichier `docs/testing.md` généré dans les projets bootstrapés, et le remplir pour le kit lui-même. Concrètement, dans un dépôt qui a déjà `operations.md § Test` (le *comment lancer*), `lessons-technical.md` (les *pièges*) et `coding-standards.md` (les *conventions*), le nouveau fichier doit occuper une niche non couverte — la *stratégie* — sans marcher sur les trois autres.

## Forme cible

Un template `docs/testing.md.tpl` (Full only) avec des **sections-squelette à remplir** (stack-agnostique, pas de réponses codées en dur) :

- **Philosophie** — à quel point ce projet mise sur le test automatique vs. la revue vs. le run manuel ; ce compromis assumé.
- **Niveaux** — quels niveaux existent (unit / intégration / e2e / lint / autre), pour quelle couverture, et *pourquoi ceux-là*.
- **Ce qu'on ne teste pas** (délibérément) — et pourquoi (coût/valeur).
- **Définition de « testé »** — le critère qui fait qu'une feature/un changement est considéré couvert avant merge.
- **Comment lancer** — un pointeur court vers [`operations.md § Test`](operations.md), pas une duplication.

En-tête du fichier : une phrase qui pose la frontière avec `operations.md` (comment lancer) et `lessons-technical.md` (pièges ponctuels).

## Surface d'impact

### Templates (bilingue, pour les projets bootstrapés)
- **Nouveau** : `templates/{en,fr}/docs/testing.md.tpl` (encadré `FULL-ONLY` de bout en bout, ou généré via la sélection de fichiers profil-driven — cf. Questions ouvertes Q1).
- `templates/{en,fr}/docs/operations.md.tpl` : ajouter dans `## Test` un pointeur vers `testing.md` *(Full only, marqueur inline)*.
- `templates/{en,fr}/docs/persistence-strategy.md.tpl` : une ligne matrice `Stratégie/doctrine de test → docs/testing.md` *(FULL-ONLY)*.
- `templates/{en,fr}/CLAUDE.md.tpl` : une ligne dans la table de routage *(FULL-ONLY)*.
- `templates/{en,fr}/docs/README.md.tpl` : une ligne dans la carte de doc *(FULL-ONLY)*.

### Skill bootstrap
- `.claude/commands/bootstrap-claude-env.md` : Phase 4, ajouter `docs/testing.md` à la **liste Full** (et l'exclure explicitement de Minimal). Pas de nouvelle question Phase 3 — généré d'office en Full comme `coding-standards.md` (cf. Q2).

### Outillage
- `tools/lint-templates.py` : rien de spécifique à coder si les marqueurs/parité sont respectés — le lint existant couvre. Vérifier qu'il passe.

### Kit pour lui-même (dogfood)
- **Nouveau** : `docs/testing.md` (à la racine du kit, monolingue fr) rempli avec la vraie stratégie : `lint-templates.py` (parité, marqueurs, rendu) + run manuel end-to-end des 3 skills sur un vrai projet (ce qu'on vient de faire), + ce qu'on ne teste pas (pas de CI, pas de test unitaire du Python de lint), + définition de « testé » pour un changement de template.

## Lots d'implémentation

### Lot 1 — Template + intégrations
- Créer `testing.md.tpl` (en+fr), brancher operations/persistence/CLAUDE/README, mettre à jour bootstrap Phase 4.
- **Critère de sortie** : `python3 tools/lint-templates.py` vert ; un rendu Full contient `testing.md`, un rendu Minimal ne le contient pas.

### Lot 2 — Dogfood
- Écrire `docs/testing.md` réel du kit.
- **Critère de sortie** : le fichier décrit la stratégie réelle (lint + run manuel des 3 skills) sans placeholder.

## Alternatives considérées (plus détaillé que l'ADR)

### α — Une section dans `operations.md` plutôt qu'un fichier
Écartée : cf. ADR. Le mélange doctrine/commandes est précisément l'anti-pattern que `persistence-strategy` proscrit.

### β — Générer aussi en Minimal
Écartée pour l'instant : un prototype n'a pas de doctrine de test à formaliser ; `operations.md § Test` lui suffit. Réversible si un besoin Minimal apparaît.

## Questions ouvertes

- ~~**Q1 — encadrement `FULL-ONLY` vs sélection de fichiers**~~ : résolu — pattern `workflow.md` (fichier non listé en Minimal via `MINIMAL_SKIP_FILES`, pas de marqueur enveloppant).
- ~~**Q2 — question bootstrap ?**~~ : résolu — généré d'office en Full, pas de question Phase 3.

## Journal de décisions

- **2026-07-02** — module retenu comme fichier dédié Full-only (ADR 0001) ; frontière posée avec `operations.md § Test` (comment lancer) et `lessons-technical.md` (pièges ponctuels).

## Prochaines actions

- [x] Valider Q1/Q2 avec l'utilisateur avant le Lot 1.
- [x] Lot 1 — template + intégrations + lint vert.
- [x] Lot 2 — dogfood `docs/testing.md` du kit.

_Clôturé le 2026-07-02 — Lots 1 et 2 livrés, voir `CHANGELOG.md` § [Unreleased]._
