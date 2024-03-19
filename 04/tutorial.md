# Travaux pratiques &mdash; n-uplet et exception

## Question 1
Définir la fonction `first : 'a * 'b -> 'a` et la fonction `second : 'a * 'b -> 'b` que retournent respectivement  le premier et le second élément d'une paire.

Ces fonctions existent d'ailleurs en OCaml (`fst` et `snd`).

## Question 2
Définir la fonction `sum : int * string -> int * string -> int * string` qui somme les premiers composantes des paires et qui concatènent les secondes composantes.

Par exemple,
```ocaml
sum (1, "Bon") (2, "jour")
(* retourne (3, "Bonjour") *)
```

## Question 3
Définir la fonction `suffix_prefix : string -> char -> char option * char option` tel que `suffix_prefix str c` retourne le caractère précédent la première occurence de `c` dans `str` et le caractère suivant.

Exemple :
```ocaml
suffix_prefix "Bonjour" 'o';;
(* (Some 'B', Some 'n') *)

suffix_prefix "Bonjour" 'B';;
(* (None, Some 'o') *)

suffix_prefix "Bonjour" 'r';;
(* (Some 'u', None) *)

suffix_prefix "Bonjour" 'a';;
(* (None, None) *)
```

## Question 4
Définir les fonctions
- `zip : 'a list * 'b list -> ('a * 'b) list`
- `unzip : ('a, 'b) list -> 'a list * 'b list`

`zip` doit lever `Invalid_argument "Listes de taille différente"` si les listes
ne sont pas de même taille.

Exemple d'utilisation :
```ocaml
zip [1;2;3] [4;5;6];;

(* [(1, 4); (2, 5); (3, 6)] *)

unzip [(1,1); (2, 3); (4, 3)];;

(* ([1; 2; 4], [1; 3; 3]) *)
```

## Question 5
Définir la fonction `min_max : int list -> (int, int)` qui retourne une paire contenant le minimum et le maximum de la liste d'entrée.

Définissez une exception `Empty` que est levée si la liste est vide.

Écrivez la fonction avec une fonction récursive et une seconde fois en utilisant `List.fold_left`.

## Question 6 - Listes associatives
On va définir un bulletin de notes et écrire de fonctions pour ajouter des matières, des notes, "corriger" les notes, et extraire les meilleures notes.

Pour cela, on définit les types suivants :

```ocaml
type subject = Math | English | History | Sport
type grade = int
type report = (subject * grade list) list
```
Un `report` est donc un bulletin, c'est à dire, une liste de matières chacune associée à une liste de notes.

On définira aussi deux exceptions :
```ocaml
exception Subject_not_found
exception No_grade of subject
```
`Subject_not_found` est levée quand la matière recherchée n'est pas dans le bulletin.

`No_grade` est levée quand la matière inspectée n'a pas de notes enregistrées.

Écrire les fonctions suivantes (n'hésitez pas à utiliser les itérateurs `map` et `fold_left` du module `List`).

- une fonction `add_subject : subject -> report -> report` qui ajoute une nouvelle matière au bulletin (sans note)

- une fonction `add_grade : subject -> grade -> report -> report` qui ajoute une note à une matière présente dans le bulletin.

- une fonction `get_grades : subject -> report -> grade list` qui retourne les notes d'une matière.

- une fonction `get_best_grade : subject -> report -> grade` qui retourne la meilleure note associée à une matière. Utilisez la fonction `min_max` définie précédemment.

- une fonction `get_best_grade_opt : subject -> report -> grade opt` qui fait la même chose que la précédente mais retourne un type option plutot que de lever des exceptions. Aucune exception ne devrait échapper de cette fonction.

- une fonction `change_grades : (int -> int) -> subject -> report -> report` qui modifie les notes associée à une matière en utilisant la fonction passée en entrée.

- une fonction `compute_avg : subject -> report -> float`  qui calcule la moyenne d'une matière. Vous pouvez utilisez `Float.from_int` pour convertir les entiers en flottant.

- une fonction `get_best_grades_in : subject list -> report -> (subject * grade) report` qui retourne les meilleurs notes de chaque matière présente dans la liste en entrée. Utilisez la fonction `get_best_grade` définie précédemment.


## Question 7
Définir la fonction `optimize : int list -> (int -> int) ->  int -> int` .

`optimize inputs f` prend une liste d'entrée `inputs` à précalculer pour la fontion `f` et retourne la fonction `f` telle que si elle est appelée sur les valeurs précalculées, elle les utilise plutôt que d'appeler `f`.

Par exemple, on pourrait définir la fonction `opti_fibo` précalculée sur les entiers de 0 à 39,

```ocaml
let opti_fibo = optimize (List.init 39 (fun i -> i)) fibo
```

Quand la fonction `opti_fibo` est appelée sur un de ces entiers, elle ne doit pas appeler `fibo`.

Vous pouvez mettre un `print_endline "Calcul."` dans la fonction que vous optimisez
(`fibo`) ici pour vérifier qu'à l'appel de la version optimisée, sur une entrée
précalculée, rien ne s'affiche.
