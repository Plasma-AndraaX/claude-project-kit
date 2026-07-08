#!/usr/bin/env bash
# Dogfooding — lance Claude Code avec le plugin Armature chargé depuis le
# working tree du kit, pour exercer les vraies commandes /armature:* sur leur
# source réelle (dispatch d'overlay compris). Édite plugin/skills/<x>/SKILL.md
# puis /reload-plugins pour recharger à chaud.
#
# NB : distinct du claude.sh GÉNÉRÉ dans les projets bootstrapés (qui charge
# .env.claude et fait un passe-plat) — celui-ci sert le dogfooding du kit
# lui-même. Voir docs/testing.md § « Comment lancer ».
set -euo pipefail
here="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
exec claude --plugin-dir "$here/plugin" "$@"
