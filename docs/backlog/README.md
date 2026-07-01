# Backlog — claude-project-kit

Sujets ouverts sur le kit lui-même (pas sur un projet bootstrapé). Pas de `docs/adr/`/`docs/plans/` pour l'instant — les décisions structurantes déjà prises ont leur raisonnement dans `README.md`/`ADAPTING.md` ; le format ADR est réservé aux futures décisions pas encore tranchées (voir les items ci-dessous, plusieurs sont candidats).

## Action manuelle requise (pas automatisable depuis cette session)

- [ ] **Faire tourner `/bootstrap-claude-env` (et `/propose-kit-improvement`) pour de vrai** — tous les tests à ce jour sont `tools/lint-templates.py`, un proxy mécanique en Python qui simule ce qu'un LLM *devrait* faire en lisant les skills. Ni l'un ni l'autre n'a jamais été réellement invoqué comme vraie commande slash dans une session Claude Code fraîche — et je ne peux pas le faire moi-même depuis cette session (les deux skills sont scopés à un repo dont je ne suis pas le cwd ici). À faire : ouvrir Claude Code dans `claude-project-kit`, lancer `/bootstrap-claude-env /tmp/un-repertoire-jetable`, puis depuis ce répertoire jetable lancer `/propose-kit-improvement` après y avoir fait un petit changement générique à la main, comparer le résultat réel aux attentes. C'est la seule vérification qui compte vraiment.

## Sujets à mûrir

- [x] **Versioning et rétro-propagation** — voir [`versioning-and-retro-propagation.md`](versioning-and-retro-propagation.md). Tampon de version construit ; remontée cross-projet construite via `/propose-kit-improvement`. Reste ouvert : jamais testé en conditions réelles (item ci-dessus).
- [x] **Modèle de contribution / système d'extension** — voir [`contribution-and-extension-model.md`](contribution-and-extension-model.md). `CONTRIBUTING.md` + `/propose-kit-improvement` couvrent le triage assisté. Le système de plugins/dépôts satellites reste délibérément non construit (zéro contributeur externe à ce jour).

## Fond de tiroir (pas de déclencheur)

- [ ] Doc de stratégie de test dédiée pour les projets bootstrapés.
- [ ] Journal d'incidents/postmortem, distinct de `lessons-technical.md`.
- [ ] Profils supplémentaires entre Minimal et Full.
- [ ] Équivalent `.ps1` de `claude.sh` pour Windows natif (hors WSL).

## Fichiers conservés en référence (sujets clos)

_(vide pour l'instant)_
