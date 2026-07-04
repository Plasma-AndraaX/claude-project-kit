---
description: Capturer à chaud une courte note éditoriale pour le changelog utilisateur, à partir de la conversation en cours, dans docs/changelog/_next.md.
argument-hint: [optionnel — ce qu'il faut capturer, si ce n'est pas évident depuis la conversation]
---

# Capturer une note de changelog

Tu viens de livrer quelque chose de visible pour l'utilisateur (un fix, une feature, un changement de comportement) et le contexte est frais. Écris une note courte, en langage clair, maintenant — pas au moment de la release, quand la nuance aura disparu.

$ARGUMENTS

## Ce qui va ici

- Des changements **visibles côté utilisateur** : quelque chose qu'un utilisateur du produit remarquerait ou dont il se soucierait. Pas les refactors internes, pas les ajouts de tests, pas les montées de dépendances sans effet de comportement.
- **Langage clair** : pas de jargon, pas de noms de classes/fichiers internes, pas de numéros de ticket. Écris pour la personne qui utilise le produit, pas pour le prochain développeur.
- **Honnête sur le périmètre** : si c'est un fix partiel ou avec une limite connue, dis-le en une clause — ne survends pas.

## Ce qui ne va PAS ici

- Refactors internes, changements uniquement de tests, changements de CI/outillage — sauf effet de bord visible utilisateur (ex. « l'appli démarre nettement plus vite »).
- Tout ce qui est déjà couvert par une entrée non publiée existante — vérifie `_next.md` d'abord, étends une note existante plutôt que de dupliquer.
- Captures d'écran ou exemples contenant de vraies données utilisateur / PII — génériciser ou masquer avant d'inclure.

## Processus

1. Lis `docs/changelog/_next.md`. Si le changement du jour est déjà couvert par une entrée existante, étends-la plutôt que d'en ajouter une nouvelle.
2. Ajoute une nouvelle entrée datée suivant la forme montrée dans le commentaire de `_next.md` : un titre d'une ligne (ce qui a changé, en termes utilisateur) + 1-3 phrases de corps en langage clair.
3. Ne touche à rien d'autre dans le fichier — c'est append-only jusqu'à ce que `/changelog-draft` le vide au moment de la release.

## Ce que tu ne fais PAS

- N'écris pas de discours marketing ou de survente — factuel et clair vaut mieux qu'enthousiaste et vague.
- Ne devine pas un impact utilisateur dont tu n'es pas sûr — demande à l'utilisateur si le cadrage est le bon avant de figer une entrée ambiguë.
- Ne lance pas ce skill pour des changements sans surface visible utilisateur — il est parfaitement acceptable de dire « rien à capturer ici ».
