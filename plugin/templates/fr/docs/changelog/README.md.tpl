# Changelog

Notes de release destinées aux utilisateurs de {{PROJECT_NAME}} — ce qui a changé, du point de vue de quelqu'un qui utilise le produit, pas le code. Distinct de `docs/plans/` (interne, centré implémentation) et de l'historique git (centré développeur).

## Mécanisme : capturer à chaud, rédiger à la release

Rédiger un changelog entièrement au moment de la release fait perdre le détail — à ce moment-là, plus personne ne se souvient de la nuance qui rendait un fix important ou du cas limite visible côté utilisateur. À la place :

1. **`/armature:changelog-capture`** — à lancer *pendant que le contexte est frais* (juste après avoir livré quelque chose de visible pour l'utilisateur) pour ajouter une courte note éditoriale dans [`_next.md`](_next.md).
2. **`/armature:changelog-draft`** — à lancer *au moment de la release* pour transformer les notes accumulées dans `_next.md` en une entrée de release formatée, puis vider `_next.md` pour le cycle suivant.

## `_next.md`

Un fichier de brouillon courant, non formaté — voir [`_next.md`](_next.md) lui-même pour la forme exacte. Ce n'est **pas** le changelog publié ; c'est la matière première que `/armature:changelog-draft` consomme.

## Ce que ce module ne fournit PAS

- La **traduction multi-langue** des notes de release. Si ton projet s'adresse à des utilisateurs dans plusieurs langues, c'est une extension réelle et utile à construire (voir `ADAPTING.md` dans le dépôt du kit), mais c'est un choix produit que ce kit ne fait pas à ta place.
- La **publication** (affichage in-app, site de doc, mailing list). `/armature:changelog-draft` produit le texte ; où il finit publié dépend de ton produit.
- Un format de sortie figé. Adapte les instructions de `/armature:changelog-draft` à la convention que tu utilises (Keep a Changelog, GitHub Releases, un format in-app custom).
