---
status: accepted
date: 2026-07-08
deciders: [Plasma-AndraaX]
superseded-by:
related-adrs: [0006]
related-plans: [mecanisme-extension-tier-b]
---

# ADR 0007 — Construire le mécanisme d'extension des commandes (tier b : overlay extend-first)

## Contexte

L'[ADR 0006](0006-modele-extension-commandes.md) a posé un modèle d'extensibilité à 3 niveaux et **reporté** le tier (b) — l'overlay à points d'ancrage — au motif qu'aucun besoin additif récurrent n'était démontré (« Holoon est couvert par override »).

Un diagnostic en **lecture seule** des 6 commandes Holoon qui mappent sur une base Armature (2026-07-08 — voir [`../backlog/command-extension-mechanism.md`](../backlog/command-extension-mechanism.md) § Diagnostic) a **réfuté cette prémisse**. Les 6 sont des **extensions** de la base : 5 extensions nettes (`new-adr`, `capture-lessons`, `changelog-capture`, `dashboard`, `whats-left`) + 1 hybride (`changelog-draft`, spécialisée mais dont toute la colonne vertébrale de la base survit — non réinventée). **Zéro remplacement réel** ; le « couplage au code » redouté sur `whats-left` se réduit à une seule ligne de grep. Le besoin d'extension n'est donc pas un cas niche mais **universel** chez Holoon — le projet fondateur d'Armature — qui le paie aujourd'hui en maintenant 6 forks dupliqués voués à diverger de la base. Le déclencheur de réveil du tier (b) a sonné.

## Décision

Construire le **tier (b)** : un mécanisme d'extension **extend-first** où une commande de base `/armature:<nom>` consulte un **overlay projet optionnel** et y injecte le contenu projet à des **points d'ancrage nommés**. Un seul nom de commande (le dispatch supprime le doublon `/<nom>` vs `/armature:<nom>` du tier c). Le mécanisme est **extension seule** — pas de mode remplacement (le diagnostic montre 0/6 le réclament ; le tier (c) reste l'échappatoire si un vrai cas de remplacement surgit).

Cet ADR fixe la **direction** ; la forme concrète (chemin de l'overlay, syntaxe d'ancrage, instruction de dispatch) et un **Lot prototype** de validation vivent dans le [plan compagnon](../plans/mecanisme-extension-tier-b.md). Cet ADR **révise le report du tier (b)** de l'ADR 0006 ; le reste de 0006 (le modèle à 3 niveaux, les tiers a et c) tient inchangé.

## Conséquences

- **Positives** — Holoon (et tout projet à domaine riche) peut **plugger la base et l'étendre** sans forker : la base évolue, la surcouche projet suit. Élimine les 6 forks dupliqués et leur dérive. Un seul point d'entrée `/armature:<nom>` par commande (fin de l'hésitation à deux noms). Design **guidé par des données réelles** : les 6 commandes forment le jeu de validation et la taxonomie d'ancrages.
- **Négatives** — nouvelle machinerie à concevoir, documenter et maintenir dans chaque skill de base (l'aiguillage + les ancrages nommés). Le dispatch in-skill est une séparation **molle** (prompt-level), moins hermétique qu'une commande séparée — à dé-risquer par prototype avant généralisation. La **localisation reste non résolue** (hors scope, cf. *Alternatives*) : un projet francophone comme Holoon garderait un squelette anglais + injections françaises, ou conserverait ses forks pour la langue — donc l'**adoption complète par Holoon n'est pas garantie par ce seul ADR**.
- **Neutres** — le tier (c) (commande locale, remplacement assumé) et le tier (a) (conventions auto-chargées) restent inchangés. Armature-le-repo, qui consomme sa **propre doctrine sans aucune customisation** (ses ADR suivent la base telle quelle), confirme au passage que la base sert déjà le cas simple — le tier (b) ne sert que le cas riche.

## Alternatives considérées

- **Statu quo (tier c pour tout) — le choix de l'ADR 0006** — rejeté : le diagnostic montre que Holoon *étend*, il n'*override* pas ; l'override force 6 forks dupliqués qui perdent les évolutions de la base. C'est le problème, pas la solution.
- **Extend + mode remplacement dans le même overlay** — rejeté *pour l'instant* : 0/6 des commandes le réclament ; ajouter le mode replace complexifie pour un besoin non démontré, et le tier (c) couvre déjà le remplacement.
- **Traiter la localisation dans le même ADR** — rejeté : deux problèmes distincts (divergence de *contenu* vs de *langue*) ; élargir noierait la décision. Axe séparé, candidat à un futur ADR (skills localisés).
- **Figer le design concret (format d'overlay, syntaxe d'ancrage) dans l'ADR** — rejeté : le design mérite un prototype avant d'être gelé dans un doc immuable ; il vit dans le plan.

## Références

- ADR liées : [0006](0006-modele-extension-commandes.md) (pose le modèle 3 niveaux + reporte le tier b — cet ADR révise ce report)
- Plans liés : [`../plans/mecanisme-extension-tier-b.md`](../plans/mecanisme-extension-tier-b.md)
- Diagnostic source : [`../backlog/command-extension-mechanism.md`](../backlog/command-extension-mechanism.md) § Diagnostic des 6 commandes Holoon (2026-07-08)
