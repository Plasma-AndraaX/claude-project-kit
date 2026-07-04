---
status: accepted
date: 2026-07-04
deciders: [Plasma-AndraaX]
superseded-by:
related-adrs: []
related-plans: [armature-plugin]
---

# ADR 0004 — Distribuer Armature comme plugin Claude Code (`armature`)

## Contexte

Aujourd'hui, Armature installe son environnement en **copiant** des fichiers dans chaque projet cible — dont ~9 commandes dans `.claude/commands/`. `KIT_ROOT` (la racine du kit, nécessaire pour lire les templates et diffter) est résolu par un **chemin codé en dur** (`/mnt/c/dev/armature`) ou la variable `$ARMATURE_HOME` — inutilisable tel quel par un tiers qui n'a pas le repo au même endroit.

Besoin exprimé : pouvoir invoquer les commandes sous un **namespace `/armature:…`** dans n'importe quel projet, y compris ceux qu'on met à jour. Vérifié sur la doc officielle : un sous-dossier `.claude/commands/armature/` **ne namespace pas** (le fichier reste `/changelog-capture`) ; le préfixe `:` n'existe **que via un plugin** Claude Code (`plugin-name:skill`). Or un plugin résout du même geste trois choses : le namespace, la **distribution à des tiers** (marketplace), et le **chemin codé en dur** (`${CLAUDE_PLUGIN_ROOT}` pointe vers l'installation).

## Décision

Distribuer Armature comme un **plugin Claude Code nommé `armature`**, hébergé dans le repo `Plasma-AndraaX/armature` qui devient un **marketplace**. Les commandes deviennent des **skills du plugin** (invoquées `/armature:<nom>`) ; les `templates/` sont **bundlés** dans le plugin et résolus via `${CLAUDE_PLUGIN_ROOT}/templates/<lang>/`. Un tiers installe en deux commandes : `/plugin marketplace add Plasma-AndraaX/armature` puis `/plugin install armature@armature`. Le repo conserve en parallèle sa doc dogfoodée (`docs/adr|plans|backlog`).

## Conséquences

- **Positives** — namespace `/armature:` natif ; distribution tierce en 2 commandes ; installé **une fois** → commandes disponibles dans **tous** les projets sans copie ; `${CLAUDE_PLUGIN_ROOT}` **supprime** le chemin codé en dur `/mnt/c/dev/armature` *et* `$ARMATURE_HOME` (dette remboursée) ; mises à jour centralisées via `/plugin update` (plus de re-copie projet par projet).
- **Négatives** — refonte du modèle : fin de la copie des commandes par projet ; les profils Full/Minimal **ne filtrent plus** les commandes (un plugin expose tout — `/armature:new-adr` visible même en Minimal) ; `/propose-kit-improvement` et `/pull-kit-updates`, pensés pour synchroniser des fichiers *copiés*, perdent une partie de leur objet ; le tampon `.armature-version` change de rôle ; travail de migration (commandes → format plugin, réécriture des références, re-migration de voxtrail/Unfog).
- **Neutres** — le repo cumule deux casquettes (marketplace/plugin **et** projet dogfoodé) — compatible ; les **docs générées** (`CLAUDE.md`, `docs/`…) restent *copiées* dans les projets (elles ne peuvent pas vivre dans un plugin), donc un besoin de synchronisation de la doc subsiste, indépendamment des commandes.

## Alternatives considérées

- **Préfixe tiret `/armature-<nom>` sans plugin** — renommer les fichiers (`armature-new-adr.md`…). Garde le modèle de copie, mais donne `-` et non `:`, et ne résout **ni** la distribution tierce **ni** le chemin codé en dur. Rejeté : ne répond pas au besoin.
- **Sous-dossier `.claude/commands/armature/`** — rejeté : techniquement inopérant, un sous-dossier ne namespace pas (doc officielle « How a skill gets its command name »).
- **Statu quo (noms génériques copiés)** — rejeté : ne répond pas au besoin exprimé.

## Références

- Plans liés : [`../plans/armature-plugin.md`](../plans/armature-plugin.md)
- Doc Claude Code : [Skills — command name](https://code.claude.com/docs/en/skills#how-a-skill-gets-its-command-name), [Create plugins](https://code.claude.com/docs/en/plugins), [Plugins reference — `${CLAUDE_PLUGIN_ROOT}`](https://code.claude.com/docs/en/plugins-reference)
