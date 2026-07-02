---
status: implemented
created: 2026-07-02
settled: 2026-07-02
related-adr: 0002
---

# Plan — Module `docs/incidents/` (compagnon de l'ADR 0002)

Compagnon de [l'ADR 0002](../adr/0002-journal-incidents.md). Capture *comment* le module journal-d'incidents est implémenté dans le kit, et *ce qui* reste ouvert.

## Reformulation du problème

Ajouter à l'arsenal Full un dossier `docs/incidents/` avec un README (mécanisme + quand ouvrir) et un gabarit de postmortem, généré dans les projets bootstrapés ; puis écrire le premier postmortem réel du kit (l'incident `settings.json` global). Le module doit s'insérer sans marcher sur `lessons-technical` (leçon atemporelle), le backlog (travail à faire) ni un simple commit (bug résolu).

## Forme cible

Structure `docs/incidents/` calquée sur `docs/adr/` :
- `README.md` — l'index + la doctrine : **quand** un événement mérite un postmortem (critère : impact réel + surprise + mérite une chronologie + génère des actions/leçons qui ne tiennent pas dans un message de commit) ; et la frontière explicite avec `lessons-technical`, le backlog et le commit.
- `template.md` — gabarit copié verbatim (comme `adr/template.md`), sections : frontmatter (`date`, `severity`, `status: open|resolved`, `lessons: []`, `follow-ups: []`) puis **Résumé** · **Chronologie** · **Impact** · **Cause racine** · **Remédiation (ce qui a été fait sur le coup)** · **Actions de suivi & leçons produites** (avec liens vers `lessons-technical`/`backlog`).

Un postmortem **référence** ses leçons/follow-ups plutôt que de les dupliquer : la leçon généralisable va dans `lessons-technical.md`, le travail restant en `backlog/`, et le postmortem les pointe.

## Surface d'impact

### Templates (bilingue, pour les projets bootstrapés)
- **Nouveaux** : `templates/{en,fr}/docs/incidents/README.md.tpl` et `templates/{en,fr}/docs/incidents/template.md` (ce dernier copié verbatim, pas de placeholder — comme `adr/template.md`/`plans/template.md`).
- `templates/{en,fr}/docs/persistence-strategy.md.tpl` : une ligne matrice `Incident/postmortem (événement daté) → docs/incidents/` *(FULL-ONLY)*, avec la nuance « ≠ leçon (lessons-technical) ≠ travail (backlog) ».
- `templates/{en,fr}/docs/workflow.md.tpl` : une entrée qui distingue **commit** vs **leçon** vs **postmortem** vs **backlog** *(FULL-ONLY)* — le pendant, pour les incidents, du routage d'idées neuves déjà présent.
- `templates/{en,fr}/docs/lessons-technical.md.tpl` : une ligne dans l'en-tête pointant « pour un *événement* (pas une leçon), voir `docs/incidents/` » *(FULL-ONLY)*.
- `templates/{en,fr}/CLAUDE.md.tpl` : une ligne dans la table de routage *(FULL-ONLY)*.
- `templates/{en,fr}/docs/README.md.tpl` : une ligne dans la carte de doc *(FULL-ONLY)*.

### Skill bootstrap
- `.claude/commands/bootstrap-claude-env.md` : Phase 4, ajouter `docs/incidents/README.md` + `docs/incidents/template.md` à la **liste Full** (exclure de Minimal). Générés d'office en Full, pas de question Phase 3 (cf. Q2). Le `template.md` est copié verbatim (à ajouter au § *Which files get a .tpl suffix* de `CONTRIBUTING.md` — c'est un fichier sans suffixe).

### Outillage
- `tools/lint-templates.py` : `MINIMAL_SKIP_DIRS` contient déjà `adr`/`plans`/`prefs`/`changelog` — **ajouter `incidents`** pour que le rendu Minimal ne l'attende pas. Vérifier la parité `en`/`fr` du nouveau dossier.

### Kit pour lui-même (dogfood)
- **Nouveaux** : `docs/incidents/README.md` (fr) + `docs/incidents/2026-07-01-settings-json-global-ecrit-hors-perimetre.md` — le vrai postmortem : chronologie (sous-agent de test → écriture `~/.claude/settings.json` global → alerte classifieur → vérification que rien n'était cassé), cause racine (résolution de chemin hors périmètre + consentement relayé-par-coordinateur traité comme direct), remédiation, et actions de suivi/leçons (dont la règle « les écritures irréversibles/config passent par l'agent au contact direct de l'utilisateur »).

## Lots d'implémentation

### Lot 1 — Template + intégrations
- Créer `incidents/README.md.tpl` + `incidents/template.md` (en+fr), brancher persistence/workflow/lessons-technical/CLAUDE/README, bootstrap Phase 4, `lint-templates.py` (`MINIMAL_SKIP_DIRS`), `CONTRIBUTING.md` (§ .tpl).
- **Critère de sortie** : `python3 tools/lint-templates.py` vert ; rendu Full contient `docs/incidents/`, rendu Minimal non.

### Lot 2 — Dogfood
- Écrire `docs/incidents/README.md` + le postmortem `2026-07-01-*` du kit ; y référencer la/les leçon(s) (ex. dans `lessons-technical` du kit si on en ouvre une) et l'entrée backlog/findings.
- **Critère de sortie** : postmortem complet (chronologie + cause racine + actions) sans placeholder.

## Alternatives considérées (plus détaillé que l'ADR)

### α — Journal unique append-only
Écartée : cf. ADR. Un fichier unique empêche de dater/lier chaque incident et devient illisible.

### β — Réutiliser `lessons-technical` avec une convention de titre « Incident : … »
Écartée : mélange deux natures (événement vs leçon) dans un même flux append-only, et prive l'incident de son frontmatter (severity/status/liens).

## Questions ouvertes

- ~~**Q1 — champs de frontmatter du postmortem**~~ : résolu — `severity` libre au départ (échelle `low|medium|high` proposée en exemple), pas de norme imposée avant d'avoir plusieurs incidents.
- ~~**Q2 — question bootstrap ?**~~ : résolu — généré d'office en Full, pas de question Phase 3.
- ~~**Q3 — `status: open` a-t-il un sens**~~ : résolu — oui, `open` tant que les actions de suivi ne sont pas bouclées, puis `resolved` (documenté dans le gabarit et le README).

## Journal de décisions

- **2026-07-02** — module retenu : dossier `docs/incidents/`, un fichier par incident, Full only (ADR 0002). Frontière posée avec commit / `lessons-technical` / backlog. Premier postmortem identifié : incident `settings.json` du 2026-07-01.

## Prochaines actions

- [x] Valider Q1–Q3 avec l'utilisateur avant le Lot 1.
- [x] Lot 1 — template + intégrations + lint vert.
- [x] Lot 2 — dogfood README + premier postmortem (`2026-07-01-settings-json-global-hors-perimetre.md`).

_Clôturé le 2026-07-02 — Lots 1 et 2 livrés, voir `CHANGELOG.md` § [Unreleased]._
