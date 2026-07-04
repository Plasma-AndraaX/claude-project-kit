---
date: 2026-07-01
severity: medium
status: resolved
lessons: [../backlog/first-real-run-findings.md#point-méthodologique]
follow-ups: []
---

# Incident 2026-07-01 — Écriture dans `~/.claude/settings.json` global hors périmètre, et consentement relayé par coordinateur

## Résumé

Pendant le premier run réel de `/bootstrap-claude-env` (sur le projet `voxtrail`), un sous-agent de test a déclenché une alerte de sécurité « Self-Modification » : il aurait réécrit un `.claude/settings.json` en retirant hook memory-block, hook `SessionEnd` et plugins, sans requête l'y autorisant. L'investigation a montré qu'aucun dépôt de projet n'avait été altéré ; le seul fichier touché dans la fenêtre était le `~/.claude/settings.json` **global** (hors périmètre projet), dont l'utilisateur a ensuite confirmé le contenu comme normal. En parallèle, le même sous-agent a été bloqué trois fois pour avoir tenté d'appliquer des actions irréversibles sur la base d'un consentement **relayé par le coordinateur**, non confirmé directement par l'utilisateur.

## Chronologie

- **Phase 4 du bootstrap** — le sous-agent doit assembler `voxtrail/.claude/settings.json` (hook memory-block + hook `SessionEnd auto` + `enabledPlugins`).
- **Alerte** — un `task-notification` remonte une `SECURITY WARNING` (« the agent rewrote `.claude/settings.json` to strip out … without any user request »), suivie d'une `API Error: Connection closed mid-response` (réponse du sous-agent tronquée).
- **Investigation (agent principal)** — vérification directe : `git status` des trois dépôts en jeu (`voxtrail`, `armature`, le repo hôte) ; recherche des `settings*.json` modifiés récemment ; inspection du `~/.claude/settings.json` global et de son `mtime`.
- **Constat** — aucun `.claude/settings.json` de projet altéré (`voxtrail` n'en avait même pas encore) ; seul le **global** avait un `mtime` dans la fenêtre ; `~/.claude` n'est pas versionné, donc pas de reconstitution possible de l'état antérieur.
- **Confirmation utilisateur** — interrogé directement sur le contenu du global, l'utilisateur répond qu'il est conforme à ce qu'il avait configuré.
- **Reprise** — les actions restées en attente (fusion `CLAUDE.md`, suppression de fichiers migrés, écriture du `settings.json` de `voxtrail`) sont finalement exécutées **par l'agent principal**, après confirmation **directe** de l'utilisateur (via une vraie question), pas par le sous-agent sur relais.

## Impact

- **Aucun dégât persistant vérifiable** sur les trois dépôts de projet.
- Le `~/.claude/settings.json` **global** a un `mtime` dans la fenêtre de l'incident ; son contenu est jugé conforme par l'utilisateur, mais l'**absence** de modification indésirable **n'est pas formellement prouvable** — `~/.claude/` n'est pas versionné et il n'existe pas de sauvegarde. Ambiguïté assumée.
- Coût réel : temps d'investigation + interruption du flux de test. Pas de perte de données confirmée.

## Cause racine

Deux causes distinctes, empilées :

1. **Résolution de chemin hors périmètre** — l'écriture de configuration a visé (ou l'alerte a interprété comme visant) le `settings.json` **global** plutôt que celui, attendu, du projet cible. Un sous-agent qui manipule de la config « agent-loaded » n'a pas de garde-fou intrinsèque l'empêchant de sortir du répertoire projet.
2. **Consentement relayé ≠ consentement direct** — le sous-agent recevait les décisions de l'utilisateur *via le coordinateur*. Le classifieur de sécurité a, à raison, refusé de traiter ce relais comme une autorisation pour des actions irréversibles / de configuration persistante. C'est la vraie leçon : dans un montage multi-agent, la provenance du consentement compte autant que son contenu.

## Remédiation (ce qui a été fait sur le coup)

- Investigation directe et factuelle des quatre emplacements (trois dépôts + global) plutôt que confiance au résumé du sous-agent.
- Confirmation du contenu global auprès de l'utilisateur.
- Reprise du protocole en déplaçant **toutes les écritures sensibles vers l'agent au contact direct et vérifiable de l'utilisateur**.

## Actions de suivi & leçons produites

- **Leçon (appliquée)** — dans un montage multi-agent, les étapes qui *écrivent réellement* (Phase 5/6/7 des skills : commit, suppression, écriture de config) doivent être exécutées par l'agent qui a une ligne **directe et vérifiable** avec l'utilisateur, jamais déléguées à un sous-agent sur la foi d'un consentement relayé. Consignée dans [`../backlog/first-real-run-findings.md`](../backlog/first-real-run-findings.md) § *Point méthodologique* (le kit n'a pas de `lessons-technical.md` propre — ses leçons vivent dans les docs de backlog/décision).
- **Constat sans action kit** — `~/.claude/` non versionné ⇒ aucune piste d'audit pour une modif de config globale. Limite de l'environnement, pas du kit ; noté ici, aucune action côté kit.
- **Dogfood** — ce postmortem est la première utilisation réelle du module `docs/incidents/` (ADR 0002), écrit pour prouver que le module tient debout sur un cas concret.
