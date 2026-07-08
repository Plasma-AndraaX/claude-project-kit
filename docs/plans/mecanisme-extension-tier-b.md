---
status: in-progress
created: 2026-07-08
settled:
related-adr: 0007
---

# Plan — Mécanisme d'extension des commandes (tier b) — compagnon de l'ADR 0007

Compagnon de [l'ADR 0007](../adr/0007-mecanisme-extension-tier-b.md). Capture *comment* le mécanisme extend-first se construit, *quelles* formes ont été explorées, et *ce qui* reste ouvert. La direction est fixée par l'ADR ; **le design concret est délibérément ici** (pas dans l'ADR immuable) et se valide par un prototype avant généralisation.

## Reformulation du problème

Les skills de base vivent sous `plugin/skills/<nom>/SKILL.md`, partagées, lues depuis `${CLAUDE_PLUGIN_ROOT}`. Aujourd'hui, un projet qui veut les spécialiser les **forke** (tier c) — Holoon en a 6, dupliquées de la base (voir le diagnostic 2026-07-08). On veut : **base au plugin + surcouche au projet**, injectée à des points prévus, en mode extension.

## Forme cible (à valider au Lot 1 — non figée)

- **Overlay projet** : un fichier optionnel par commande, p. ex. `.claude/armature/<nom>.md` (chemin/format à confirmer).
- **Dispatch** : chaque skill de base commence par une clause — « si l'overlay projet existe, lis-le et applique ses injections aux ancrages ci-dessous ; annonce *surcharge projet active* au démarrage ».
- **Points d'ancrage nommés** : des emplacements déclarés dans la skill de base où le contenu projet s'insère. **Taxonomie dérivée du diagnostic** (les 4 natures récurrentes) :
  1. **Cibles/exemples domaine-stack** — `new-adr` zones d'exploration, `capture-lessons` lignes de la table de routage.
  2. **Détection projet-spécifique** — `whats-left` grep de livraison, `changelog-capture` buckets.
  3. **Étapes/sections additionnelles** — `changelog-draft` locales/metadata/captures, `whats-left` sections en plus.
  4. **Bloc de format de sortie surchargeable** — `dashboard` étape delivery, `changelog-draft` format de sortie.
- **Extend seul** — pas de mode replace ; le tier (c) reste l'échappatoire.

## Surface d'impact

### Skills
- Chaque skill de base concernée gagne : une **clause d'aiguillage** + des **ancrages nommés**.

### Documentation
- `ADAPTING.md` § « Personnaliser une commande du plugin » — étendre : comment écrire un overlay, la syntaxe d'ancrage.
- Éventuellement `plugin/templates/*/docs/workflow.md.tpl` si le mécanisme touche la doctrine générée.

### Outillage
- Format d'overlay + syntaxe d'ancrage = **nouvelle convention** à documenter ; un check de lint (correspondance ancrages base ↔ overlay) est envisageable (Q4).

### Code
- Aucun code applicatif — ce sont des skills (prompts) + une convention de fichiers.

## Lots d'implémentation

### Lot 1 — Prototype sur `new-adr` (dé-risquer la forme)
- Concevoir la forme minimale : chemin de l'overlay, 2-3 ancrages nommés dans `new-adr` (zones d'exploration ; `deciders`/références ; conventions VCS), la clause d'aiguillage.
- Implémenter sur `plugin/skills/new-adr/SKILL.md` + un overlay d'exemple simulant Holoon.
- Faire tourner et **mesurer la fiabilité** : la base injecte-t-elle proprement aux ancrages, sans « baver » (la séparation molle) ? sur plusieurs essais.
- **Critère de sortie** : `new-adr` lit l'overlay et injecte aux ancrages de façon **fiable et reproductible** ; forme d'overlay + syntaxe d'ancrage **arrêtées**.

### Lot 2 — Généraliser aux extensions nettes
- Porter la forme validée sur `capture-lessons`, `changelog-capture`, `dashboard`, `whats-left` (→ `review-backlog`).
- **Critère de sortie** : les 5 skills portent ancrages + aiguillage ; un overlay projet les spécialise **sans fork**.

### Lot 3 — `changelog-draft` (l'hybride)
- Cas le plus lourd (locales, `metadata.json`, captures). Trancher : l'overlay suffit-il, ou reste-t-il en tier (c) ?
- **Critère de sortie** : verdict tranché + implémenté (overlay, ou override documenté comme exception assumée).

### Lot 4 (hors scope 0007, gated future) — Localisation
- Les skills de base sont en anglais, Holoon veut du français. **Axe distinct**, hors périmètre de l'ADR 0007 — noté ici pour mémoire.
- **Déclencheur de réveil** : une fois le mécanisme extend en place, si la langue reste le dernier blocage à l'adoption Holoon → candidat à un futur ADR (skills localisés).

## Alternatives considérées (plus détaillé que l'ADR)

### α — Mode replace dans l'overlay
Écarté : 0/6 des commandes Holoon le réclament (même `changelog-draft` est une spécialisation, pas un remplacement). Le tier (c) — commande locale namespace-distinct — couvre déjà le cas rare de remplacement, sans complexifier le mécanisme extend.

### β — Figer la syntaxe d'ancrage dans l'ADR
Écarté : la fiabilité du dispatch mou et l'ergonomie de la syntaxe ne se connaissent qu'en essayant. Prototype d'abord (Lot 1), design gelé ensuite.

## Questions ouvertes

- **Q1 — Chemin/format de l'overlay** : `.claude/armature/<nom>.md` ? Un frontmatter pour déclarer quels ancrages il cible ?
- **Q2 — Déclaration des ancrages** : comment la skill de base *nomme* ses ancrages (commentaire nommé ? section conventionnée ?) et comment l'overlay les cible sans ambiguïté.
- **Q3 — Fiabilité du dispatch mou** : à quel point la base « bave »-t-elle dans l'injection ? — **le Lot 1 tranche**.
- **Q4 — Lint** : faut-il un check qui valide que les ancrages ciblés par un overlay existent bien dans la base (éviter les overlays silencieusement ignorés) ?

## Progression

| Lot | SHA | Date | Notes |
|---|---|---|---|
| — | — | — | *(rien livré ; ADR + plan ouverts le 2026-07-08)* |

## Follow-ups surfacés pendant l'implémentation

*(vide à l'ouverture)*

## Journal de décisions

- **2026-07-08** — Ouverture. Trois choix de cadrage validés par l'utilisateur : **direction seule** dans l'ADR (design au plan) ; **localisation hors scope** (Lot 4 gated) ; **extend seul** (pas de mode replace). Fondé sur le diagnostic des 6 commandes Holoon (5 extensions + 1 hybride, 0 remplacement).

## Prochaines actions

- [ ] Lot 1 — prototype sur `new-adr` : forme d'overlay + ancrages + aiguillage, mesure de fiabilité.
- [ ] Décider Q1/Q2 au vu du prototype.
- [ ] Lot 2 — généraliser une fois la forme arrêtée.
- [ ] Lot 3 — trancher `changelog-draft`.
- [ ] Lot 4 — *gated future*, ne rien faire avant le déclencheur (langue = dernier blocage).

---

## À la clôture du plan

Voir [`docs/workflow.md`](../../plugin/templates/fr/docs/workflow.md.tpl) § *Clôturer un plan*. Le Lot 4 étant *gated future* (hors scope 0007), le plan peut passer `implemented` une fois les Lots 1-3 livrés.
