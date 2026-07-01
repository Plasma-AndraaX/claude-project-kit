# Outillage Claude Code

Inventaire des plugins, skills, subagents et hooks Claude Code utilisés (ou évalués) sur {{PROJECT_NAME}}. Garder ce document vivant — le mettre à jour à chaque adoption, évaluation ou abandon.

## Stratégie

<!-- Un paragraphe : à quel point ce projet est-il délibéré sur l'outillage IA ? Ex. « adopter les built-ins en premier, écrire un skill custom seulement quand un processus multi-étapes récurrent a besoin d'être codifié ». -->

## Inventaire

### Skills built-in (fournis avec Claude Code)

<!-- Lister ceux réellement utilisés, une ligne chacun : nom — pourquoi. -->

### Skills custom (dans `.claude/commands/`)

| Skill | Vocation |
|---|---|
| `/bootstrap-claude-env` *(si conservé après le setup initial — sinon retirer cette ligne)* | Régénère/étend cet environnement depuis `claude-project-kit` |
| `/new-adr` | Processus guidé pour ouvrir une ADR + son plan compagnon |
| `/capture-lessons` | Passe en revue le travail récent et propose des mises à jour de doc |
| `/whats-left` | Vue tactique des items backlog/plan ouverts |
| `/dashboard` *(profil Full)* | Régénère `docs/dashboard.html` |
<!-- CHANGELOG-ONLY --> | `/changelog-capture` | Capture une note de changelog utilisateur pendant que le contexte est frais |
| `/changelog-draft` | Rédige le changelog de release depuis `docs/changelog/_next.md` | <!-- /CHANGELOG-ONLY -->

### Plugins / serveurs MCP

| Plugin ou serveur MCP | Statut | Pourquoi |
|---|---|---|
<!-- Une ligne par plugin/MCP considéré. Statut : `adopted` (activé dans .claude/settings.json ou la config MCP), `suggested` (pertinent, pas encore activé — décision de l'utilisateur), `rejected` (considéré, explicitement pas adopté). Les suggestions faites au bootstrap ne viennent que des plugins Anthropic-verified (claude.com/plugins) ou de serveurs MCP officiels connus des éditeurs, correspondant au stack détecté — jamais d'une recherche web ouverte, pour éviter de recommander un serveur MCP non vérifié. Cette table ne devrait pas rester vide : au minimum, elle reflète ce que l'analyse au bootstrap a jugé pertinent pour ce stack, même si toutes les lignes sont `suggested`. -->

### Recommandé, pas encore activé

<!-- Si une ligne `suggested` ci-dessus nécessite un credential/secret pour être réellement activée (c'est le cas de la plupart des serveurs MCP), la commande/le snippet de config exact va ici — jamais un secret pré-fourni. L'utilisateur la lance lui-même quand il est prêt. Supprimer cette section s'il n'y a rien en attente. -->

### Catalogue des hooks

<!-- Lister les hooks configurés dans .claude/settings.json et ce que fait chacun. Le hook memory-block (si activé) va ici. -->

## Hors périmètre (délibérément écarté)

<!-- Choses considérées et explicitement pas adoptées, avec la raison — évite de relitiger plus tard. -->

## Comment évaluer un nouveau plugin/skill

<!-- La barre de ton équipe pour adopter un nouvel outillage IA — ex. « doit résoudre un problème récurrent au moins deux fois », « ne doit pas exiger de secrets au-delà de ce qui est déjà accordé ». -->

## Socle de sécurité

<!-- Contraintes sur ce que les outils/hooks ont le droit de faire (accès réseau, gestion des credentials, commandes destructrices). -->

## Références

<!-- Liens vers les marketplaces de plugins, discussions internes, etc. -->
