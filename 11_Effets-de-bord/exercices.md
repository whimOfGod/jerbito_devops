# Exercices

## Impression de valeurs

1. Écrire la fonction `hello_world : unit -> unit`
2. Déterminez l'ordre dans lequel les arguments d'une fonction sont évalués.
3. Écrire une fonction `print_int_option : int option -> unit`.
4. Écrire une fonction imprimant les valeurs du type json suivant :

```ocaml
type json =
  | Null
  | Bool of bool
  | Int of int
  | Float of float
  | String of string
  | Array of json list
  | Object of (string * json) list;;
```

## Tableaux et références

1. Écrire récursivement la fonction `fibonacci`.
2. Modifier cette fonction pour qu'elle mémoize le résultat, en utilisant un
   tableau de donnée optionelle : avant de calculer une valeur, la fonction
   vérifier si celle-ci n'a pas été stockée dans le tableau. Si elle l'a été,
   elle réutilise cette valeur. Sinon, elle la calcule et la stocke.
3. Utiliser le type `array` pour créer un tableau à double entrée de taille
   100x100, tel que `tableau.(i).(j)` soit `i + j`.
