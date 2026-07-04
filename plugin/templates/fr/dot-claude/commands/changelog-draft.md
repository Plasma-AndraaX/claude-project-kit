---
description: Produire le draft du changelog utilisateur pour une release donnée, à partir de docs/changelog/_next.md, du git log et des corps de PR mergées.
argument-hint: [version ou date de release]
---

# Rédiger le draft du changelog de release

Transforme les notes accumulées dans `docs/changelog/_next.md` en une entrée de changelog formatée et publiable pour la release **$ARGUMENTS**.

## Sources, par ordre de priorité

1. **`docs/changelog/_next.md`** — la source primaire. Ces notes ont été capturées près du travail, en langage utilisateur ; fais-leur confiance plus qu'à ce que tu reconstruirais après coup.
2. **`git log` depuis le dernier tag de release** — vérifie s'il existe des commits visibles utilisateur sans entrée correspondante dans `_next.md`. Si tu en trouves un, c'est un trou : soit l'entrée a été oubliée (demande à l'utilisateur, n'invente pas le cadrage utilisateur silencieusement), soit ce n'était réellement pas visible utilisateur (ignore-le).
3. **Corps/titres des PR mergées** *(si ce projet utilise des PR)* — même usage que le git log, utile quand les messages de commit sont laconiques.

**N'utilise jamais** les messages de commit bruts ou les titres de tickets internes tels quels comme texte de changelog — ils sont écrits pour des développeurs, pas des utilisateurs. Traduis-les dans le même registre en langage clair que les entrées de `_next.md`.

## Processus

1. Lis `_next.md` et liste chaque entrée comme candidate.
2. Vérifie les trous par rapport au `git log`/PR (voir ci-dessus). Signale tout trou à l'utilisateur plutôt que de deviner ce qu'un commit silencieux signifiait pour les utilisateurs.
3. Groupe et ordonne les entrées selon la convention de ce projet (demande si elle n'est pas encore établie — ex. Added/Changed/Fixed/Removed façon Keep a Changelog, ou une liste chronologique inverse à plat).
4. Présente le draft à l'utilisateur pour relecture avant toute publication.
5. Une fois approuvé : ajoute l'entrée finalisée là où vit le changelog publié de ce projet (un `CHANGELOG.md`, un site de doc, un champ de notes de release — demande si ce n'est pas établi), puis **vide `_next.md`** pour revenir à sa forme de gabarit vide pour le cycle suivant.

## Ce que ce skill ne fait PAS

- Il ne traduit pas la sortie dans d'autres langues — si ce projet s'adresse à plusieurs locales, c'est une extension séparée, spécifique au projet (voir `ADAPTING.md` dans le kit d'origine).
- Il ne publie nulle part automatiquement — la dernière étape est une action manuelle/scriptée spécifique à la surface de publication réelle de ce projet.
- Il n'invente pas de cadrage utilisateur pour un commit sans entrée `_next.md` et sans impact utilisateur clair — il demande plutôt que de deviner.
