# Modèle de contribution et d'extension

## Contexte

Le repo n'est pas encore public (Forgejo privé). La question se pose en prévision : si publié un jour (GitHub évoqué), comment gérer les contributions externes sans que ça devienne ingérable pour un mainteneur solo qui veut trier lui-même ce qu'il accepte ?

## Décision légère prise maintenant

`CONTRIBUTING.md` documente juste la doctrine : PR bienvenues, aucune garantie de merge, tri par le mainteneur selon un critère simple — généralisable et agnostique de stack → candidat pour le core ; spécifique/opinionated → mieux comme extension personnelle.

## Idée en attente — système de plugins / dépôts satellites

Intuition de départ : plutôt que de tout merger dans `claude-project-kit`, un contributeur pourrait maintenir son propre dépôt qui *référence* le kit (un `templates/<lang>/` additionnel, appliqué en overlay par le skill) — pour éviter d'alourdir le core avec des variantes trop spécifiques, tout en laissant la communauté construire ce qu'elle veut.

**Pourquoi ce n'est pas construit maintenant** : zéro contributeur externe à ce jour, zéro PR reçue. Construire l'abstraction (résolution de plusieurs `KIT_ROOT`, gestion des conflits entre overlay et core, convention de nommage) pour un besoin hypothétique va exactement à l'encontre de la doctrine du kit lui-même ("ne pas designer pour des besoins hypothétiques"). Le coût de se tromper sur la forme de cette abstraction *avant* d'avoir vu un vrai cas d'usage est plus élevé que le coût d'attendre.

**Trigger de réveil** : une vraie PR arrive qui est utile mais trop spécifique/opinionated pour le core (ex. un profil dédié à un écosystème particulier, une traduction dans une langue que le mainteneur ne veut pas maintenir lui-même). À ce moment, concevoir le mécanisme d'overlay avec un vrai cas concret sous les yeux plutôt qu'en abstrait.

## Alternative écartée pour l'instant

Un système de plugins *dans* le kit (comme les marketplaces de plugins Claude Code) — écarté car ça duplique un mécanisme qui existe déjà à l'échelle de Claude Code lui-même (`claude.com/plugins`) ; pas besoin de réinventer une marketplace pour un kit de bootstrap.
