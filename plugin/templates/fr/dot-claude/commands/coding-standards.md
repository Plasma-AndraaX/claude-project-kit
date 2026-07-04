---
description: Proposer ou actualiser docs/coding-standards.md selon la stack du projet, à partir des conventions idiomatiques à jour (formatter + style-guide) plutôt qu'une table figée. Documentaire — jamais de scaffold.
argument-hint: [langage/stack optionnel — sinon lu depuis CLAUDE.md ou détecté]
---

# Proposer / actualiser les conventions de code

Cette commande remplit ou met à jour [`docs/coding-standards.md`](../../docs/coding-standards.md) avec les conventions **idiomatiques** de la stack, en s'appuyant sur une source de documentation **vivante** quand elle est disponible. À utiliser surtout quand il n'y a pas (encore) de conventions *observées* à documenter : un **projet neuf**, l'**ajout d'un langage**, ou une **actualisation** des conventions d'un écosystème.

Stack/langage éventuellement précisé par l'utilisateur : **$ARGUMENTS**

## Ce que cette commande NE fait PAS (à lire d'abord)

- Elle **n'installe aucun outil**, ne génère pas de `.prettierrc`/`.eslintrc`/config de linter, ne touche pas à `package.json`/`pyproject.toml`. Ce kit est un scaffold de *documentation/méthode*, pas d'application.
- Elle **ne code pas en dur** une règle d'équipe non demandée, ni une convention exotique/personnelle — elle vise l'idiomatique consensuel.
- Elle **n'écrit rien sans confirmation** : elle présente un diff, tu valides.

## Phase 1 — Déterminer la stack

- Si `$ARGUMENTS` est renseigné, c'est le langage/la stack visé.
- Sinon, lire la section **Stack** de [`CLAUDE.md`](../../CLAUDE.md).
- Sinon, détection légère via les manifestes racine (`package.json`/`tsconfig.json`, `pyproject.toml`/`requirements.txt`, `go.mod`, `Cargo.toml`, `*.csproj`/`*.sln`, `composer.json`, `Gemfile`, `pom.xml`/`build.gradle*`).
- Codebase **multi-langage** → traiter chaque écosystème séparément (une sous-section par langage en Phase 3).

Confirmer la liste des langages retenus avant d'aller plus loin.

## Phase 2 — Récupérer les conventions idiomatiques (source vivante d'abord)

Pour **chaque** langage, viser **deux sources complémentaires** :

- le **formatter** (formatage : indentation, guillemets, points-virgules, largeur, virgules finales) — ex. Prettier (JS/TS), `black`/`ruff` (Python), `gofmt` (Go), `rustfmt` (Rust), `dotnet format` (.NET) ;
- le **style-guide / linter** (nommage, structure, imports — ce que le formatter ne fixe pas) — ex. ESLint/typescript-eslint, PEP 8, Effective Go, Rust API Guidelines, conventions C# de Microsoft, Google Style Guides.

**Comment** :
- Si une source de doc à jour est disponible (skill `/find-docs`, CLI `ctx7`, ou équivalent) : l'utiliser. Ex. résoudre l'outil (`ctx7 library "Prettier" "default formatting options"`) puis récupérer la doc (`ctx7 docs <id> "..."`). Préférer les sources à réputation élevée. **C'est la voie préférée** : conventions à jour et sourçables.
- **Sinon** (aucun outil de doc live) : dégrader vers ta connaissance des conventions **largement adoptées** de la stack — et **signaler ce fallback** dans le doc généré (voir le statut en Phase 3).

Ne jamais inventer : dans le doute entre deux conventions, retenir la plus largement adoptée dans l'écosystème et le dire.

## Phase 3 — Synthétiser dans `docs/coding-standards.md`

Remplir le squelette existant (Vue d'ensemble / Conventions par langage / Application), sans réécrire ce qui a déjà été confirmé sur ce projet :

- **Pivot sur l'outillage** — recommander le formatter/linter idiomatique et « ses défauts » plutôt que de réénumérer chaque règle qu'il applique déjà (« adopter Prettier avec ses réglages par défaut »). Lister ensuite les conventions clés que l'outil **ne fixe pas** : nommage (fichiers, variables, fonctions, types), organisation des imports, structure de dossiers.
- **Une sous-section par langage** si la stack est hétérogène.
- **Statut en tête du fichier** : `> Conventions **proposées** le AAAA-MM-JJ selon la stack déclarée — à confirmer/ajuster ; elles ne reflètent pas encore un usage observé.` (et, si le fallback Phase 2 a été utilisé : ajouter « proposées de mémoire, à vérifier contre la doc officielle »). Retirer/adapter ce statut quand le code réel confirme les conventions.
- **Section « Déclaré vs observé »** : la laisser absente sur un projet neuf (rien d'observé) ; sur un projet existant, **compléter sans écraser** l'observé sans confirmation.

## Phase 4 — Offrir un `.editorconfig` (pas d'office)

Proposer — **sans l'imposer** — un `.editorconfig` de base *dérivé* des conventions retenues (`root = true`, `indent_style`/`indent_size`, `charset = utf-8`, `end_of_line = lf`, `insert_final_newline = true`, `trim_trailing_whitespace = true`, plus d'éventuels overrides par glob de langage). C'est un fichier déclaratif neutre, pas une dépendance. Si un `.editorconfig` existe déjà, montrer un diff, ne pas écraser.

## Phase 5 — Présenter avant d'écrire

Montrer le diff proposé de `coding-standards.md` (et du `.editorconfig` si retenu), avec les **sources utilisées** (liens si via doc live). N'écrire qu'après confirmation. Committer (`docs:`) seulement si l'utilisateur le demande — vérifier `docs/prefs/<login>.md` pour ses conventions de commit si ce projet l'utilise.

## Règles

- **Documentaire, jamais de scaffold** — recommander l'outillage, ne pas l'installer/configurer.
- **Source vivante préférée, fallback signalé** — la qualité et la fraîcheur viennent de `find-docs`/`ctx7` ; sans lui, être transparent sur le statut « de mémoire ».
- **« Proposé » explicite** tant que l'usage réel n'a pas confirmé — ne pas maquiller une proposition en convention « en vigueur ».
