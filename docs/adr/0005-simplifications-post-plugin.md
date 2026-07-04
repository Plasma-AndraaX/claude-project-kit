---
status: accepted
date: 2026-07-04
deciders: [Plasma-AndraaX]
superseded-by:
related-adrs: [0004]
related-plans: [post-plugin-simplification]
---

# ADR 0005 — Simplifications post-plugin : profil unique + fin de la synchronisation projet↔kit

## Contexte

La bascule d'Armature en plugin ([ADR 0004](0004-plugin-armature.md)) retire la copie des commandes par projet et le chemin codé en dur. Dès lors, deux pans du modèle actuel perdent leur justification :

1. **Le double profil Full/Minimal.** Minimal existait pour ne pas imposer la machinerie ADR/plan/dashboard à un petit projet. Mais un plugin **expose toutes ses commandes partout** (impossible de les filtrer par profil), et la doc générée peut être élaguée à la main. Maintenir deux profils coûte : 44 paires de marqueurs `FULL-ONLY` (18 fichiers) + 4 paires `MINIMAL-ONLY` (6 fichiers), une question de plus au bootstrap, et des combinaisons de lint.
2. **La synchronisation projet↔kit** (`/propose-kit-improvement`, `/pull-kit-updates`, tampon `.armature-version`). Ces skills diffaient les fichiers *copiés* contre le kit. Le plugin met à jour les commandes via `/plugin update` ; les docs générées sont trop **personnalisées par projet** pour un three-way merge fiable. Le tampon ne servait que de baseline à ces diffs, et la langue de contenu vient désormais de `${user_config.lang}` (ADR 0004), pas d'une trace par projet.

## Décision

Réduire Armature à **un seul profil (Full)** et **supprimer la synchronisation projet↔kit**. Concrètement : retirer l'axe de marqueurs `FULL-ONLY`/`MINIMAL-ONLY` (le contenu `FULL-ONLY` devient inconditionnel, le contenu `MINIMAL-ONLY` est supprimé), la question de profil au bootstrap, les commandes `/propose-kit-improvement` et `/pull-kit-updates`, et le tampon `.armature-version` (avec son champ `profile=`). Le besoin ponctuel de tirer l'évolution d'un template de doc retombe sur un **diff manuel**, déjà assumé dans `ADAPTING.md` (« Limite connue : pas de rétro-propagation »).

## Conséquences

- **Positives** — suppression massive de complexité : un seul jeu de contenu, plus de marqueurs de profil, plus de sync bidirectionnelle, plus de tampon ni de versioning par projet, lint plus simple, bootstrap qui pose moins de questions, moins de surface à maintenir en parité `en`/`fr`.
- **Négatives** — perte de la rétro-propagation assistée (remonter une amélioration depuis un projet) — mais peu utilisée et redondante avec une PR directe sur le repo ; perte du profil Minimal — un petit projet reçoit tout l'arsenal (qu'il peut ignorer/élaguer). Chantier de nettoyage (retirer marqueurs, 2 skills, tampon ; adapter bootstrap + lint + doc).
- **Neutres** — les modules **orthogonaux** `changelog` et `memoryhook` restent des opt-in (ce ne sont pas des profils) ; la « Limite connue : pas de rétro-propagation » d'`ADAPTING.md` redevient la doctrine explicite.

## Alternatives considérées

- **Garder Minimal comme simple sous-ensemble documentaire** (sans machinerie de profil) — rejeté : garde un axe conditionnel ; une fois les commandes en plugin, la valeur d'un profil réduit ne paie plus son coût.
- **Recentrer `propose`/`pull` sur la doc uniquement** — rejeté : les docs sont trop personnalisées pour un merge fiable ; maintenir deux skills three-way-merge ne se justifie plus.
- **Conserver le tampon comme marqueur de langue par projet** — rejeté : `${user_config.lang}` couvre le besoin (langue globale à l'install) ; le multi-langue par projet est un besoin hypothétique (YAGNI).

## Références

- ADR liées : [0004](0004-plugin-armature.md) (le driver — la bascule plugin)
- Plans liés : [`../plans/post-plugin-simplification.md`](../plans/post-plugin-simplification.md)
- `ADAPTING.md` § « Limite connue : pas de rétro-propagation »
