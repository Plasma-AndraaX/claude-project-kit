# Versioning et rétro-propagation

## Le problème

Aujourd'hui, un projet bootstrapé ne garde aucune trace de la révision du kit qui l'a généré. Deux conséquences :
- Impossible de savoir, des mois plus tard, si une amélioration ultérieure du kit (fix de bug, nouveau module) a des chances de s'appliquer à ce projet sans tout re-diffter à l'aveugle.
- La limite déjà documentée dans `ADAPTING.md` ("pas de rétro-propagation automatique, diff manuel") est *pire* qu'elle n'y paraît : un diff manuel suppose de savoir depuis quel point de départ on part, ce qui n'est actuellement pas le cas.

## Décision prise (2026-07) — SHA git plutôt que semver

Tamponner le SHA du commit du kit (`git -C KIT_ROOT rev-parse HEAD`, capturé en Phase 4) dans un fichier `.claude-project-kit-version` à la racine du projet cible, plutôt que de maintenir un numéro de version sémantique à la main.

**Pourquoi pas un semver classique + CHANGELOG dédié** : ça demanderait une discipline manuelle (bump à chaque commit substantiel) qui sera oubliée — exactement le genre de mécanisme qui s'auto-sabote avec le temps. Le SHA git est automatique, précis, et permet un `git diff <sha>..HEAD -- templates/<lang>/` direct pour voir exactement ce qui a changé depuis le bootstrap d'un projet donné.

**Limite assumée** : un SHA n'est pas lisible humainement ("est-ce qu'on a beaucoup de retard ?"). Si ça devient un vrai besoin (plusieurs projets, écart significatif), un `CHANGELOG.md` du kit lisible par humain redevient pertinent — pas construit tant que ce besoin n'est pas concret.

## Ce que ça ne résout PAS encore

Le tamponnage donne le *point de départ* du diff, mais pas de mécanisme pour appliquer sélectivement les changements pertinents à un projet déjà bootstrapé (un `.tpl` peut avoir divergé sous l'effet des propres modifications du projet). Rester en diff manuel assisté (on sait maintenant depuis où diffter) plutôt que viser une synchronisation automatique façon `cookiecutter --replay` — trajet lourd, pas justifié tant qu'aucun cas réel ne le réclame.

## Remontée cross-projet (le vrai trou "auto-apprenant")

Symétrique du problème ci-dessus : rien ne fait remonter vers le kit ce qu'on apprend en l'utilisant sur un projet réel. Proposition à trancher : ajouter à `/capture-lessons` (généré dans chaque projet) un filtre supplémentaire — *"cette leçon concerne-t-elle Claude Code / les conventions de ce kit en général, plutôt que ce projet précis ?"* — et si oui, proposer explicitement d'ouvrir une entrée dans le backlog du kit (ou une PR, une fois le repo public) en plus de (ou à la place de) la capture locale.

Pas encore implémenté — mérite sa propre réflexion avant d'y toucher (est-ce que ça alourdit `/capture-lessons` pour un bénéfice encore hypothétique tant que le kit n'a bootstrapé qu'un nombre restreint de projets ?).
