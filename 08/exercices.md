# Arbres

Pour ces questions, utilisez le fichier `arbre.ml` pour définir vos fonctions. Utilisez le fichier test_arbre.ml pour tester vos fonctions.

Vous pouvez ensuite lancer les tests avec la commande `dune exec
test_arbre`. Vous pouvez lancer utop avec le module `Arbre` accessible avec la
commande `dune utop`.

1. Écrire un type représentant un arbre binaire.
2. Écrire une fonction pour imprimer un arbre sur la sortie standard.
3. Ajoutez un `.mli` et testez en utilisant le fichier `executable.ml`.

On souhaite maintenant avoir des entiers associés aux feuilles.

4. Modifier le type pour que les feuilles contiennent des entiers.
5. Adaptez la fonction d'impression.
6. Écrire une fonction qui ajoute un nouvel entier tout à gauche d'un arbre.

On souhaite maintenant que les branches aient des entiers associés

7. Modifier le type pour que les branches contiennent des entiers.
8. Adaptez la fonction d'impression.
9. Écrire une fonction qui ajoute un nouvel entier à la manière d'un arbre
   binaire de recherche (`insere_abr : int -> arbre -> arbre`).
10. Écrire la fonction `contient : int -> arbre -> bool` qui indique si un abr
   contient un entier.

On souhaite maintenant utiliser les arbres binaires de recherche comme un
dictionnaire

11. La clé sera l'entier, et le type de la valeur associée ne sera pas
   contraint. Modifiez le type des arbres pour ajouter une valeur aux feuilles
   et aux noeuds.
12. Écrivez la fonction `insere_dictionnaire : int -> 'a -> 'a arbre -> 'a
    arbre` qui ajoute une nouvelle entrée
13. Écrivez la fonction `map_dictionnaire : int -> 'a arbre -> 'a option` qui
    récupère la valeur associée à une clé
