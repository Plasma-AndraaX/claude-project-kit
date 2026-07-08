# Personnalisation des commandes par projet (mécanisme d'extension)

## Le problème

Depuis que les commandes d'Armature sont des skills du plugin ([ADR 0004](../adr/0004-plugin-armature.md)), un projet qui veut **spécialiser** une commande (p. ex. un workflow de changelog maison) n'a que deux options aujourd'hui, toutes deux mauvaises :

- **Forker** la commande dans le `.claude/commands/<nom>.md` du projet → elle se fige, ne bénéficie plus des mises à jour du plugin (c'était l'état de Holoon avant la bascule).
- **Modifier la base** dans le plugin → change le comportement pour *tous* les projets.

Il manque un moyen de garder la **base au plugin** et la **spécialisation au projet**, découplées.

## Déclencheur réel — Holoon (2026-07-06)

Le plugin a été installé sur Holoon, qui portait 6 commandes locales pré-plugin, dont plusieurs **fortement personnalisées** :

- `changelog-draft` (181 l. vs 31 l. générique) : workflow de release sur-mesure — multi-locale fr/en/es/ca, `i18n-glossary`, `metadata.json`, captures, buckets, flags wizard/email.
- `changelog-capture`, `whats-left` (celle-ci couplée au code : détection de livraison silencieuse via `grep … Holoon.Domain/Events/…`) : fortement enrichies.
- `new-adr`, `capture-lessons` : structure générique **plus** conventions/exemples Holoon (Gitflow `--no-ff`→develop, « pas de `Co-Authored-By: Claude` », cibles EF Core / NeinLinq / Holacracy).

Ces personnalisations sont **supérieures** aux skills génériques pour Holoon → elles coexistent avec `/armature:*` sans conflit (namespace distinct), mais on ne veut pas les re-forker à chaque évolution du kit.

## L'idée de départ (utilisateur)

Que chaque commande de base lise un fichier d'extension projet (p. ex. `.claude/armature/<commande>.md`) s'il existe, et l'intègre — pour enrichir sans forker.

## L'analyse — la personnalisation n'est pas *une* seule chose

Un fichier d'extension unique traiterait pareil **quatre natures** très différentes :

1. **Conventions transverses** (pas de `Co-Authored-By`, Gitflow, `deciders`) — reviennent dans plusieurs commandes ⇒ un fichier par commande les **duplique**. Doivent vivre à **un seul endroit** (prefs) lu par toutes.
2. **Données** (glossaire i18n, liste des locales) — de la config, pas des instructions à fusionner.
3. **Comportement additif** (cibles/exemples de stack) — *ici* l'idée d'extension marche bien.
4. **Comportement différent** (`changelog-draft` Holoon) — pas un enrichissement mais un autre workflow ; un overlay serait aussi gros que la commande ⇒ autant une **commande locale dédiée**.

## Proposition à trois tiers (à challenger)

- **(a) Conventions transverses** → un fichier prefs projet unique, lu en préambule par toutes les commandes de base.
- **(b) Extension ciblée** → l'idée de départ, mais avec des **points d'ancrage nommés** dans la commande de base (p. ex. une section « cibles/exemples projet »), pour que l'insertion soit prévisible plutôt qu'improvisée par le modèle à chaque run.
- **(c) Override complet** → assumé, pour les cas lourds (`changelog-draft` Holoon) : une commande locale qui remplace, sans culpabilité. Le plugin ne cherche pas à tout absorber.

**Piège central** : un overlay universel qui prétend tout couvrir finit aussi complexe et fragile que le fork qu'il voulait éviter. Les points d'ancrage n'ont de valeur que là où la variabilité est *prévisible* — d'où la nécessité du tier (c).

## Trouvaille qui a tranché (2026-07-06) — le tier (a) existe déjà

En inspectant le kit avant de proposer quoi que ce soit à construire, on constate que le tier (a) n'est **pas à bâtir** :

- **`docs/prefs/<login>.md`** (perso) et **`CLAUDE.md`** (équipe) sont **auto-chargés par Claude à chaque session** → toute skill de base tournant dans le projet « voit » déjà ces conventions, sans mécanisme de lecture dédié.
- Le template `prefs/README` cite *explicitement* les exemples Holoon : « format des messages de commit, **souhait ou non de trailers co-auteur**, stratégie de branches ».
- Trois skills (`new-adr`, `document-standards`, `dashboard`) **consultent déjà** `docs/prefs/<login>.md` (pour les conventions de commit).

La proposition se réduit donc à : **(a) déjà là** (observation, pas décision) ; **(c) marche aujourd'hui** (namespace distinct, à bénir) ; **(b) seule vraie machinerie neuve**, sans déclencheur.

## Diagnostic des 6 commandes Holoon (2026-07-08) — le déclencheur du tier (b) a sonné

Question posée : Holoon *étend*-il la base Armature, ou la *remplace*-t-il ? Diagnostic en **lecture seule** — comparaison de chacune des 6 commandes Holoon qui mappent sur une skill de base contre cette base (6 agents parallèles). *(Holoon a 10 commandes locales ; 4 — `db-pull-from-prod`, `i18n-add-key`, `i18n-audit`, `release` — n'ont aucun équivalent Armature et restent purement locales, hors sujet.)*

| Commande | Verdict | La base survit-elle ? |
|---|---|---|
| `new-adr` | Extension | Squelette identique (6 phases, sections d'ADR verbatim) + zones domaine/permissions, Gitflow greffés |
| `capture-lessons` | Extension | Table de routage + filtre identiques + cibles EF Core/CQRS/Holacracy greffées |
| `changelog-capture` | Extension | Même cible, même filtre, même handoff `→ changelog-draft` ; + buckets/locales |
| `dashboard` | Extension | Sections + script + « known patterns » identiques ; seule l'étape delivery reskinnée |
| `changelog-draft` | Hybride | Réécrit (fr, 7 vs 5 étapes) **mais** toute la colonne vertébrale survit (3 sources priorisées, « signale les trous, n'invente pas », voix éditoriale prime, pause de revue, reset `_next.md`). Spécialisé, pas réinventé. |
| `whats-left` | Extension | Squelette verbatim + 5 sections en plus ; le « couplage au code » = **une seule ligne de grep** |

**Résultat : 5 extensions nettes + 1 hybride qui reste une spécialisation. Zéro remplacement réel.**

**Ce que ça corrige dans l'ADR 0006** (le *modèle* à 3 tiers tient ; c'est sa *disposition* qui était fausse) :
- 0006 qualifiait Holoon de « cas canonique de l'override (c) » et `changelog-draft` de « comportement franchement différent ». **Réfuté** : Holoon *étend* pour les 6, il n'override pas.
- 0006 reportait le tier (b) faute de « besoin additif récurrent ». **La réalité est l'inverse** : le besoin d'extension est **universel** chez Holoon, payé aujourd'hui par 6 forks dupliqués qui vont dériver de la base.

**Forme de design qui se dégage** (→ ouverte le 2026-07-08 comme [ADR 0007](../adr/0007-mecanisme-extension-tier-b.md), qui révise le report du tier (b)) :
- **Dispatch** : `/armature:<nom>` consulte un overlay projet optionnel (idée utilisateur — un seul nom de commande, pas de doublon `/<nom>` vs `/armature:<nom>`).
- **Extend-first** : l'overlay injecte aux points d'ancrage ; le mode *replace* est rare, voire inutile (aucune des 6 ne le réclame).
- Types d'ancrage récurrents : (1) cibles/exemples domaine-stack, (2) détection projet-spécifique, (3) étapes/sections additionnelles, (4) bloc de format de sortie surchargeable.
- **Bémol localisation** : skills de base en anglais, Holoon a forké en partie pour du **français** → un extend-aux-ancrages garde un squelette anglais (commande bilingue) ; servir pleinement Holoon peut demander aussi des skills localisés. L'extension règle la divergence de *contenu*, pas de *langue*.
- **Bémol fiabilité** : le dispatch in-skill (« suis cet autre fichier ») est une séparation *molle* (prompt-level), moins hermétique qu'une commande séparée — à valider par prototype.

## Statut

**Tranché le 2026-07-06 par [ADR 0006](../adr/0006-modele-extension-commandes.md)** (+ [plan compagnon](../plans/2026-07-06-modele-extension-commandes.md)) : modèle d'extensibilité à 3 niveaux **sans nouvelle machinerie** — (a) conventions portées par les fichiers déjà auto-chargés, (c) override local assumé, (b) overlay à points d'ancrage **délibérément reporté**. Ce fichier est conservé comme **réflexion source**. Distinct de [`contribution-and-extension-model.md`](contribution-and-extension-model.md), qui traite des *dépôts satellites / overlays de templates*.

**Déclencheur de réveil du tier (b)** : **a sonné le 2026-07-08.** Le diagnostic ci-dessus montre que le besoin d'extension est universel chez Holoon (6/6 des commandes mappées sont des extensions de la base, pas des overrides) → ouvert le 2026-07-08 comme **[ADR 0007](../adr/0007-mecanisme-extension-tier-b.md)** (+ [plan](../plans/2026-07-08-mecanisme-extension-tier-b.md)) : construire le mécanisme extend (dispatch `/armature:<nom>` → overlay, ancrages nommés, extend-first), révisant le report du tier (b) de 0006. **Livré le 2026-07-08** (plan `implemented`) sur les 6 commandes mappées ; Holoon peut désormais dé-forker via des overlays `.claude/armature/<nom>.md` (travail sur Holoon, non fait).
