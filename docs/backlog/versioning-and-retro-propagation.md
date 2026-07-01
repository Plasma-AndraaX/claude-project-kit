# Versioning et rétro-propagation

## Le problème

Aujourd'hui, un projet bootstrapé ne garde aucune trace de la révision du kit qui l'a généré. Deux conséquences :
- Impossible de savoir, des mois plus tard, si une amélioration ultérieure du kit (fix de bug, nouveau module) a des chances de s'appliquer à ce projet sans tout re-diffter à l'aveugle.
- La limite déjà documentée dans `ADAPTING.md` ("pas de rétro-propagation automatique, diff manuel") est *pire* qu'elle n'y paraît : un diff manuel suppose de savoir depuis quel point de départ on part, ce qui n'est actuellement pas le cas.

## Décision prise (2026-07) — SHA git plutôt que semver

Tamponner le SHA du commit du kit (`git -C KIT_ROOT rev-parse HEAD`, capturé en Phase 4) dans un fichier `.claude-project-kit-version` à la racine du projet cible, plutôt que de maintenir un numéro de version sémantique à la main.

**Pourquoi pas un semver classique + CHANGELOG dédié** : ça demanderait une discipline manuelle (bump à chaque commit substantiel) qui sera oubliée — exactement le genre de mécanisme qui s'auto-sabote avec le temps. Le SHA git est automatique, précis, et permet un `git diff <sha>..HEAD -- templates/<lang>/` direct pour voir exactement ce qui a changé depuis le bootstrap d'un projet donné.

**Limite assumée initialement, levée le 2026-07-01** : un SHA n'est pas lisible humainement. `VERSION` (semver, `0.1.0` pour l'instant) + `CHANGELOG.md` construits — le SHA reste la source de vérité *précise* pour le diff mécanique de `/propose-kit-improvement`, le semver+changelog sert la lecture humaine ("qu'est-ce qui a changé depuis que j'ai bootstrapé mon projet ?"). Bump manuel et délibéré, pas à chaque commit — sauf le chemin `/propose-kit-improvement` (Phase 6), qui alimente `[Unreleased]` automatiquement à chaque changement externe accepté, précisément pour ne pas dépendre de la mémoire du mainteneur sur ce chemin-là.

## Ce que ça ne résout PAS encore

Le tamponnage donne le *point de départ* du diff, mais pas de mécanisme pour appliquer sélectivement les changements pertinents à un projet déjà bootstrapé (un `.tpl` peut avoir divergé sous l'effet des propres modifications du projet). Rester en diff manuel assisté (on sait maintenant depuis où diffter) plutôt que viser une synchronisation automatique façon `cookiecutter --replay` — trajet lourd, pas justifié tant qu'aucun cas réel ne le réclame.

## Remontée cross-projet (le vrai trou "auto-apprenant") — ✅ résolu (2026-07)

Construit : `/propose-kit-improvement` (généré dans chaque projet bootstrapé, profils Full et Minimal). Utilise le tampon `.claude-project-kit-version` ci-dessus pour diffter les fichiers "propres au kit" (liste stricte, jamais les fichiers de contenu projet) contre l'original, classer généralisable/spécifique/bruit, filtrer les infos personnelles, et présenter le patch à l'utilisateur pour confirmation avant toute branche/commit dans le checkout local du kit. Le push/PR reste une demande séparée et explicite — jamais automatique.

Ce qui reste ouvert : le skill n'a jamais été testé en conditions réelles (même limite que le reste du kit, voir `docs/backlog/README.md` § action manuelle requise). Et rien n'assure qu'un contributeur pense à le lancer — pas de rappel automatique, juste une commande disponible.
