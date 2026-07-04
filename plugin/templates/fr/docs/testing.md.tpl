# Stratégie de test — {{PROJECT_NAME}}

*Comment* ce projet aborde le test : la **doctrine**, pas les commandes. Pour le *comment lancer* (commandes concrètes), voir [`operations.md`](operations.md) § Test. Pour un piège de test ponctuel découvert en chemin, voir [`lessons-technical.md`](lessons-technical.md).

## Philosophie

<!-- Un paragraphe : à quel point ce projet mise sur le test automatique vs. la revue vs. le run manuel, et pourquoi. Énoncer le compromis assumé (ex. « pas de CI à ce stade — vérification par lint + run manuel du chemin nominal avant merge »). -->

## Niveaux de test

<!-- Quels niveaux existent réellement et pourquoi ceux-là. Une ligne par niveau en place — ne pas lister des niveaux aspirationnels. -->

| Niveau | Outil / framework | Périmètre | Quand il tourne |
|---|---|---|---|
| <!-- ex. unit --> | <!-- ex. pytest --> | <!-- ce qu'il couvre --> | <!-- ex. avant chaque commit --> |

## Ce qu'on ne teste pas (délibérément)

<!-- Ce qui est volontairement hors périmètre de test, et pourquoi (coût/valeur). Aussi important que ce qu'on teste. -->

## Définition de « testé »

<!-- Le critère qui fait qu'un changement est considéré couvert avant merge. Ex. « le lint passe + le chemin nominal a été exercé au moins une fois ». -->

## Comment lancer

Voir [`operations.md`](operations.md) § Test pour les commandes concrètes — ne pas les dupliquer ici.
