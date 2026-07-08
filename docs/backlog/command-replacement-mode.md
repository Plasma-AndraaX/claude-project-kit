# Mode de remplacement de commande (via l'overlay)

## L'idée

Étendre le mécanisme d'overlay du tier (b) ([ADR 0007](../adr/0007-mecanisme-extension-tier-b.md)) pour qu'un fichier `.claude/armature/<nom>.md` puisse **remplacer entièrement** la commande de base — pas seulement l'enrichir aux hooks/ancrages. Concrètement : une section réservée `## replace` qui, si présente, fait que `/armature:<nom>` **ignore la base** et suit le fichier projet verbatim (ni process de base, ni `before`/`after`, ni ancrages).

## Pourquoi ça vaut le coup (point utilisateur, 2026-07-08)

Aujourd'hui, remplacer une commande relève du **tier (c)** — une commande locale `.claude/commands/<nom>.md`, dans un **namespace distinct**. Ça marche, mais ça traîne le défaut des **deux noms** : `/nom` (locale) coexiste avec `/armature:<nom>` (plugin), et l'utilisateur hésite à chaque fois lequel taper.

Un mode `## replace` dans l'overlay **unifie tier (b) et tier (c)** sous **un seul nom de commande** (`/armature:<nom>`) et **un seul endroit** (`.claude/armature/`) : le même fichier peut *étendre* (hooks/ancrages) ou *remplacer* (`## replace`), selon le besoin. Fin de l'hésitation à deux noms.

## Pourquoi c'était écarté (ADR 0007)

L'ADR 0007 a choisi **extend seul** et rejeté « extend + mode remplacement », au motif que :
- le diagnostic des 6 commandes Holoon montrait **0/6** cas de vrai remplacement (même `changelog-draft`, le plus divergent, est une *spécialisation* de la base, pas un remplacement) ;
- le tier (c) couvre déjà le remplacement, sans complexifier le mécanisme extend.

Donc : pas de besoin *démontré* au moment de trancher. Ce backlog acte que le besoin *UX* (nom unique) existe quand même, indépendamment du besoin fonctionnel.

## Esquisse de design (à challenger)

- Overlay : une section `## replace`. Si présente, la clause de dispatch de la skill de base dit « suis `## replace` verbatim et **n'applique rien** de la suite (process, hooks, ancrages) ».
- **Fiabilité** : le remplacement est en fait le dispatch le *plus simple* (« ignore la base, fais ça ») — hermétique au niveau du prompt, sans splice mid-flow.
- **Contrepartie identique au tier (c)** : un `## replace` ne bénéficie pas des évolutions de la base (c'est un fork, juste logé dans l'overlay sous le nom unique). Le gain est purement UX + co-localisation, pas la synchro.
- **Garde-fou** : `## replace` et les hooks/ancrages sont **mutuellement exclusifs** dans un même overlay (remplacer *ou* étendre, pas les deux) — un lint pourrait le vérifier.

## Question ouverte centrale

Un overlay qui remplace tout est-il *meilleur* qu'une commande locale tier (c) ? Le seul gain est le nom unique + la co-localisation ; le coût est un mode de plus à spécifier et la tentation du « pourquoi pas juste étendre ». À ne construire que si le remplacement est *genuinement* nécessaire (pas un gros extend déguisé).

## Statut

**Ouvert, candidat à un futur ADR** qui réviserait la décision *extend-seul* de l'ADR 0007 (comme 0007 a révisé le report du tier (b) de 0006). Distinct de la réflexion source [`command-extension-mechanism.md`](command-extension-mechanism.md).

**Déclencheur de construction** : un cas concret où un projet a besoin de *remplacer* le workflow entier d'une commande (pas l'étendre) **et** veut le garder sous `/armature:<nom>` — c.-à-d. où la friction des deux noms du tier (c) devient réellement pénible. Ou : assez de besoins « remplacement » s'accumulent pour que l'unification b+c sous un nom unique paie son coût.
