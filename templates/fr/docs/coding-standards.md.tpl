# Conventions de code

Le style et les conventions de nommage réellement en vigueur dans {{PROJECT_NAME}} — indentation, nommage, formatage, linting. **Document vivant** — à mettre à jour au fil de l'adoption de nouvelles conventions, ou quand un passage ultérieur détecte une dérive.

> Garder ce document centré sur *quelle* est la convention et *comment* elle est appliquée, pas sur le *pourquoi*. Si un choix de style est une décision architecturale délibérée, référencer l'ADR concernée ou une entrée datée de `docs/lessons-technical.md` plutôt que d'expliquer le raisonnement ici.

## Vue d'ensemble

<!-- Une ligne : ce codebase est-il homogène de bout en bout, ou varie-t-il par module/langage ? Si hétérogène, le dire explicitement ici et utiliser une sous-section "Conventions" par zone ci-dessous plutôt qu'une section globale unique. -->

## Conventions

<!-- Codebase homogène : remplir les champs ci-dessous une seule fois. Codebase hétérogène (plusieurs langages, ou dérive entre sous-projets/modules) : dupliquer cette sous-section par zone, en nommant chacune d'après le module/langage qu'elle couvre (ex. "### Backend (C#)", "### Frontend (TypeScript)"). -->

### <Langage / module>

- **Indentation** :
- **Longueur de ligne** :
- **Guillemets / style de chaînes** :
- **Nommage** (fichiers, variables, fonctions, types) :
- **Organisation des imports / modules** :
- **Linter / formatter** : (outil + fichier de config, le cas échéant)

## Déclaré vs observé

<!-- Ne garder cette section que si un vrai conflit a été trouvé — ex. la config du linter énonce une convention mais une part significative du code ne la suit pas. Énoncer les deux côtés, noter lequel fait référence désormais (décision de l'utilisateur, pas une supposition), et dater l'entrée. Supprimer toute cette section s'il n'y a rien à réconcilier. -->

## Application

<!-- Comment c'est réellement appliqué aujourd'hui : une étape de lint en CI, un hook pre-commit, juste une config d'éditeur, ou rien du tout ? Sois honnête si c'est aspirationnel plutôt qu'appliqué — c'est aussi une information utile. -->
