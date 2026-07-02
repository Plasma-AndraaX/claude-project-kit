# Backlog — claude-project-kit

Sujets ouverts sur le kit lui-même (pas sur un projet bootstrapé). Pas de `docs/adr/`/`docs/plans/` pour l'instant — les décisions structurantes déjà prises ont leur raisonnement dans `README.md`/`ADAPTING.md` ; le format ADR est réservé aux futures décisions pas encore tranchées (voir les items ci-dessous, plusieurs sont candidats).

## Action manuelle requise (pas automatisable depuis cette session)

_(vide — le seul item de cette section a été traité, voir ci-dessous)_

## Sujets à mûrir

- [x] **Faire tourner les trois skills pour de vrai** — fait le 2026-07-01/02, sur un vrai projet (`voxtrail`, pas un répertoire jetable vide), par des agents frais suivant le texte des skills à la lettre. Les 3 fonctionnent et n'ont produit aucun résultat incorrect. Voir [`first-real-run-findings.md`](first-real-run-findings.md) pour le détail complet des frictions/instructions sous-spécifiées trouvées (10 points, aucun bloquant) — reste à mûrir : lesquelles corriger et dans quel skill.
- [x] **Versioning et rétro-propagation** — voir [`versioning-and-retro-propagation.md`](versioning-and-retro-propagation.md). Tampon de version construit ; remontée cross-projet via `/propose-kit-improvement` ; application sélective via `/pull-kit-updates`. Reste ouvert : jamais testé en conditions réelles (item ci-dessus).
- [x] **Modèle de contribution / système d'extension** — voir [`contribution-and-extension-model.md`](contribution-and-extension-model.md). `CONTRIBUTING.md` + `/propose-kit-improvement` couvrent le triage assisté. Le système de plugins/dépôts satellites reste délibérément non construit (zéro contributeur externe à ce jour).

## Fond de tiroir (pas de déclencheur)

- [ ] Doc de stratégie de test dédiée pour les projets bootstrapés.
- [ ] Journal d'incidents/postmortem, distinct de `lessons-technical.md`.
- [ ] Profils supplémentaires entre Minimal et Full.
- [ ] Équivalent `.ps1` de `claude.sh` pour Windows natif (hors WSL).

## Fichiers conservés en référence (sujets clos)

_(vide pour l'instant)_
