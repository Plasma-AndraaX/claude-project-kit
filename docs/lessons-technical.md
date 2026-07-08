# Leçons techniques — Armature

Pièges non-évidents rencontrés en développant/distribuant le kit, qu'on ne peut pas reconstituer en lisant le code. Ajout **en tête** (append-only) ; une leçon invalidée est *superseded* (pas réécrite), son corps conservé en blockquote. Voir aussi `docs/testing.md` (dogfooding) et `CHANGELOG.md` (releases).

## Publier une version du plugin et la faire *prendre* chez un consommateur : la mécanique piégeuse

Au moment de couper une release Armature puis de la faire tourner sur un projet consommateur (p. ex. Holoon), quatre pièges non-devinables coûtent facilement une heure ou deux — et ils reviennent à **chaque** release :

- **C'est `plugin/.claude-plugin/plugin.json` `version` qui pilote la détection d'install/update**, pas le fichier `VERSION` (lui n'est que cosmétique / lisible-humain). Bumper `VERSION` + `CHANGELOG` sans bumper `plugin.json` → `/plugin update` ne voit aucune nouvelle version.
- **Le clone de marketplace local ne se rafraîchit pas tout seul.** `/plugin update` réinstalle depuis `~/.claude/plugins/marketplaces/<nom>` (un simple `git clone`). S'il est en retard sur `origin/master`, tu réinstalles la version *périmée*, sans erreur. → toujours `/plugin marketplace update <nom>` (ou `git pull` le clone) **avant** `/plugin update`.
- **`/plugin update` (slash) vise le scope `user` par défaut.** Un plugin installé en **scope projet** (dans le `.claude/settings.json` du projet) fait échouer la commande avec « not installed at scope user ». → passer par la **CLI** : `claude plugin update <plugin>@<marketplace> --scope project`. Le cache (`~/.claude/plugins/cache/<…>/<version>/`) est **partagé** entre scopes — un seul re-cache sert tous les scopes.
- **Développer le plugin en live = `claude --plugin-dir ./plugin` uniquement.** Toute install par marketplace (distante *ou* locale) copie un snapshot en cache ; les éditions du working tree n'y apparaissent pas. C'est le dogfooding décrit dans `docs/testing.md` / `claude.sh`.

Exemple concret (2026-07-08) : la mise à jour du plugin sur Holoon a échoué deux fois avant qu'on trouve que (a) le clone de marketplace était **16 commits derrière** `origin/master`, et (b) `/plugin update` visait le scope `user` alors qu'Armature y est installé en scope projet.

_Captured 2026-07-08._
