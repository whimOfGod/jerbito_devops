# Exercices sur les variants et records

## Type énumérés

1. Définir un type représentant les trois fin de partie possibles aux
   échec. Écrire la fonction qui prend une fin de partie et retourne les
   flottants 1. en cas de victoire, 0.5 en cas de nul et 0. en cas de défaite.
2. Définir un type `semaine`. Écrire la fonction `est_un_weekend` qui détermine
   si un jour donné est un week-end.
3. Écrire un type représentant la machine à état "métro-boulot-dodo".
4. Écrire la fonction `action_suivante` qui passe à 'état suivant. Testez-la.
5. Rajouter un état "Vacance" au type de donnée. La fonction précédente
   marche-t-elle encore ?
6. Définir un type `carte_a_jouer` représentant les cartes d'un jeu à 32 cartes
   (As, 7 au 10, valet, dame, roi pour les quatres couleurs pique, coeur,
   carreaux et trefle).
7. Écrire la fonction `est_rouge` qui indique si la carte est de carreaux ou de
   coeur. Écrire la fonction `est_une_tete`.
8. Écrire les fonctions `score_normal` et `score_atout` qui calculent le score
   que donne une carte, au jeu de la coinche (considérant qu'elle n'est pas un
   atout, puis considérant qu'elle en est un).
9. Écrire (si vous en avez le courage) la fonction qui prend en entrée quatres
   cartes, et qui indique si la première remporte le pli. (On considère qu'il
   n'y a pas d'atout.)
10. Que pensez-vous du type défini pour les cartes à jouer ?

## Constructeurs avec données

1. Écrire un type représentant les entiers et les flottants
2. Écrire les somme, différence, multiplication et division entre deux éléments
   de ce type.
3. Écrire un type représentant les températures en Celsius.
4. Revisiter le type des cartes à jouer à l'aide des constructeurs avec
   données. Refaire les même questions avec le nouveau types.
5. Écrire la fonction `score` qui prend en entrée une carte et la couleur de
   l'atout (si possible) et retourne les points qu'elle apporte au score total.

### Types enregistrements (ou produit)

1. Définir un type `point` qui définit un point par ses coordonnées cartésiennes.
2. Revisiter le types des cartes à jouer à l'aide des types
   enregistrements. Refaire encore et toujours les mêmes questions !

### Combinaison de types produits et types

1. On rajoute des jokers aux cartes. Les jokers n'ont pas de couleurs. Adaptez
   le type `carte_a_jouer` !

## Types `option` et `list`

1. Écrire la fonction `return` qui étant donné deux entiers, retourne leur
   division (ou `None` si elle n'est pas possible).
2. Écrire la fonction `salutation` qui prend en entrée une chaine de caractère
   optionnelle, et retourne `"Bonjour, <nom>"` si un nom a été donné, et `"Bonjour,
   quel est ton nom ?"` sinon.
3. Écrire la fonction `commence_par_un_trois` qui prend en entrée une liste, et
   qui indique si elle commence par un trois.
4. Écrire la fonction `premier_element`, qui prend en entrée une liste et
   utilise le type option pour retourner le premier élément s'il existe.


## Type json

1. Écrire la fonction `vers_chaine` qui prend en entrée un type JSON, et
   retourne une chaine de caractère correspondant au json sérialisé. On ne se
   préoccupera pas d'"échapper" les caractères.

## Pour aller plus loin

1. Écrire un type représentant le diff entre deux fichiers.
2. Écrire un type représentant un arbre binaire.
3. Écrire un type représentant un graphe.

