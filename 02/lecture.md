# Listes &mdash; Cours

## Définition

Une liste en OCaml (type `list` ou `List.t`, cf [List](https://v2.ocaml.org/api/List.html)) est :

- une structure de données fondamentale et très utilisée

- des listes chainées, c-à-d, une collection ordonnée d'éléments (en opposition
  à un set par exemple)

- peut contenir n'importe quel type d'éléments (entiers, flottants, listes,
  etc..) mais tous les éléments doivent avoir le même type

## Manipulation de base
Une liste est :
- soit vide

- soit composée d'un ou plusieurs éléments du même type, séparés par des `;`

Liste vide :
```ocaml
[]
```

### Listes non vides valides :

```ocaml
[1; 3; 0; -1; 12] : int list
```

```ocaml
['B'; 'o'; 'n'; 'j'; 'o'; 'u'; 'r'; '!'] : char list
```

```ocam;
[true; true; false] : bool list
```

```ocam;
[[]; [1]; [2;2]] : ?
```
sont des listes valides : tous les éléments ont le même type.

### Listes non valides
```ocaml
[1; 'a'; 2; 3]
```
retournent  une erreur de type :

`Error: This expression has type char but an expression was expected of type int`

```ocaml
[[1]; ['1'; '2']]
```
n'est pas valide pour la même raison : son premier élément a pour type `int
list` et son second `char list`.

## Création

```ocaml
let l = []
let l' = [1;2;3]
```

Avec `List.init` :
```ocaml
init : int -> (int -> 'a) -> 'a list
(** [init len f] is [f 0; f 1; ...; f (len-1)], evaluated left to right. *)
```

#### Exemples:
```ocaml
List.init 5 (fun ind -> ind)
```

```ocaml
List.init 5 (fun ind -> Int.to_string ind)
```

```ocaml
List.init 3 (fun ind -> 2 * ind)
```

## Ajouter un élément

Ajouter un élément à une liste se fait avec l'opérateur binaire `(::)`. Il
permet d'ajouter un élément en tête de la liste.

```ocaml
 1 :: [2;3;4]
```
est équivalent à

```ocaml
[1;2;3;4]
```
ou encore à

```ocaml
1 :: 2 :: [3;4]
```

```ocaml
1 :: 2 :: 3 :: [4]
```

```ocaml
1 :: 2 :: 3 :: 4 :: []
```

L'opérateur `(::)` est en fait un sucre syntaxique pour la fonction `List.cons`
:
```ocaml
cons : 'a -> 'a list -> 'a list
```

On peut donc aussi ajouter un élément à tête d'une liste avec :
```ocaml
cons 1 [2;3;4]
```

## Concaténer des listes
Avec l'opérateur binaire `@`:
```ocaml
(@) : 'a list -> 'a list -> 'a list
```

ou avec la fonction `append`:
```ocaml
append : 'a list -> 'a list -> 'a list
```
Avec `concat`
```ocaml
concat : 'a list list -> list
```

#### Exemple :
Tous les listes ci-dessous sont égales à la liste `[1;2;3;4]` :
```ocaml
[1;2] @ [3;4]
```
```ocaml
List.append [1;2] [3;4]
```
```ocaml
List.concat [[1;2]; [3;4]]
```

## Accesseurs et fonctions de base.
### Accèder à un élément de la liste:

La tête (head) :
```ocaml
hd : 'a list -> 'a
```
(lève une exception quand appelé sur la liste vide, on en reparle demain !)

La queue (tail) :
```ocaml
tl : 'a list -> 'a list
```

Sur une liste non-vide :
```ocaml
List.hd l :: List.tl l = l
```

Nième éléments:
```ocaml
nth : 'a list -> int -> 'a
```
(lève une exception si l'indice est trop grand)

Cette fonction n'est pas très efficace : elle est linéaire. Il faut parcourir la
liste jusqu'à l'indice recherché.

## Autres fonctions utiles:
Retourne la longueur d'une liste :
```ocaml
length : 'a list -> int
```

Renverse une liste  (`List.rev [1; 2; 3]` est `[3; 2; 1]`) :
```ocaml
rev : 'a list -> 'a list
```

## List : un type récursive polymorphique

Pour afficher le type dans `utop` :
```ocaml
#show list;;
```
On obtient :
```ocaml
type 'a list =
 | []
 | ( :: ) of 'a * 'a list
```

On parlera des types polymorphique et récursive plus tard dans la semaine. Ici,
ce qui nous intéresse :

- tous les éléments d'une liste doivent avoir le même type (`'a`) :
```ocaml
[1; 2; 3]
```
a type `int list` (l'inférence de type a déterminé que `'a` est `int`).

```ocaml
["a"; "b"; "c"]
```
a le type `string list`.

- si on ajoute un élément à liste, on obtient ... un liste (type récursif)
#### Exemple :
```ocaml
"a" :: []
```

## Filtrage par motif sur les listes
En anglais, filtrage par motif = pattern matching.

Pour comprendre "sur quoi" faire le filtrage par motif, il faut regarder le type:

```ocaml
type 'a list =
 | []
 | ( :: ) of 'a * 'a list
```

```ocaml
match l with
| [] -> ... (* cas où la liste est vide *)
| x :: xs -> ... (* cas où la liste contient au moins un élément *)
```

Mais il est possible de raffiner plus !
```ocaml
match l with
| [] -> ... (* cas où la liste est vide *)
| x :: [] -> ... (* cas où la liste a exactement un élément *)
| x :: y ::  z :: [] -> ... (* cas où la liste a exactement  3 éléments *)
| _ -> ... (* tous les autres cas *)
```

Il faut évidemment faire attention à être exhaustif et non redondant :

```ocaml
let f l =  match l with
| [] -> 0
| x :: _ -> x
| x :: _ :: _ -> x
```
affiche
```
Line 4, characters 2-13:
Warning 11 [redundant-case]: this match case is unused.

val f : int list -> int = <fun>
```

et

```ocaml
let f l =  match l with
| x :: [] -> x
| _ :: x :: _ -> x
```

affiche

```
Lines 2-4, characters 11-18:
Warning 8 [partial-match]: this pattern-matching is not exhaustive.
Here is an example of a case that is not matched:
[]

val f : 'a list -> 'a = <fun>
```

le expression déstructurante rencontre le même problème :
```ocaml
let f (head :: tail) = head
```
ou encore
```ocaml
let f l =
  let h, t = l in h
```

affiche tous les deux un avertissement :

```
Line 1, characters 6-27:
Warning 8 [partial-match]: this pattern-matching is not exhaustive.
Here is an example of a case that is not matched:
[]
```

#### Exemples :
```ocaml
match [1; 2 ; 3] with
| [] -> 0
| _ :: _ -> 1
```

```ocaml
let is_empty l = match l with
 | [] -> true
 | _ -> false
```

```ocaml
let has_2_or_less_elements l = match l with
 | [] | _ :: [] | _ :: _ :: [] -> true
 | _ -> false
```

## Parcourir une liste

Il existe deux façons de parcourir les listes :

- avec la récursion

- avec un itérateur de la librairie `List` (ce sont simplement des
  fonctions récursives prédéfinies)

### Récursions sur les listes

Les listes étant une structure récursive, elles se prêtent naturellement à être
manipulées par des fonctions récursives.

Très souvent, ces fonctions suivent le motif suivant:
```ocaml
let rec f ll = match ll with
  | [] -> (* cas liste vide = cas d'arrêt de la récursion *)
  | head :: tail ->  (* appel récursif sur tail *)
```

Voici quelques exemples .

#### Calculer la longueur d'une liste
```ocaml
let rec longueur ll = match ll with
 | [] -> failwith "todo"
 | x :: xs -> failwith "todo"
```

#### Somme des éléments d'une liste
```ocaml
let rec sum ll = match ll with
 | [] -> failwith "todo"
 | head :: tail -> failwith "todo"
```

#### Mettre des majuscules au début des mots
```ocaml
let rec capitalize ll = match ll with
 | [] -> failwith "todo"
 | _ :: _ ->  failwith "todo" (* String.capitalize_ascii *)
```

#### Rechercher un élément
```ocaml
let rec contient ll = match ll with
  | [] ->
  | _ :: _ -> failwith "todo"
```

## Fonctions d'ordre supérieur
-> programmation **fonctionnelle**

Les fonctions en OCaml :
- sont des valeurs au même type que les entiers, les listes...
- ont un type "flèche" `->`

Elles peuvent donc :
- être anomymes (de la même façon que `true & true` est une booléenne anonyme)
- être passées en argument d'une autre fonction
- être retournées par une fonction

### Fonctions anonymes

```ocaml
fun x -> x + 1
```
est une  valeur de type  `int -> int`.

```ocaml
(fun x -> x + 1) 2
```

### Fonctions en argument

```ocaml
let apply op x y = op x y
```
```ocaml
apply (fun x -> x + 1) 2 3
```

```ocaml
apply ( * ) 2 3
```

Ou encore,
```ocaml
((fun f -> (f 2)) (fun x -> x + 1)
```

### Retourner une fonction

C'est ce qui se passe quand vous faites une application partielle.

Par exemple,
```ocaml
let add x y = x + y
```

```ocaml
let add_2 = add 2
```
est une fonction de type `int -> int`.


## Itérateurs

Ce sont des fonctions qui parcourent séquentiellement les éléments d'une liste
et effectue une action (= applique une fonction) sur chacun d'eux.

Il existe 3 grandes catégories :

- `map` : applique une fonction à chaque élément de la liste

- `fold` : prend en paramètre une fonction de réduction, une valeur initiale et
  une liste et parcourent la liste en accumulant le résultat à partir de la
  valeur initiale et en appliquant la fonction de réduction à chaque élément de
  la liste.

- `iter` : applique une fonction qui fait des effets de bord à chaque élément.

On va ignorer `iter` parce qu'il n'est pas "pur", mais son utilisation est très
similaire aux autres.

### Map

```ocaml
 val map : ('a -> 'b) -> 'a t -> 'b t
 val mapi : (int -> 'a -> 'b) -> 'a t -> 'b
```

#### Exemple :

```ocaml
List.map (fun x -> x * x) [1; 2; 3; 4];;
```

```ocaml
List.map (fun a -> Char.uppercase_ascii a) ['a'; 'b'; 'C']
```
Peut aussi s'écrire:
```ocaml
List.map Char.uppercase_ascii ['a'; 'b'; 'C']
```

#### Exercices :

Définir `add_dot : string list -> string list` qui ajoute un point `"."` à
la fin de tous les mots de la liste d'entrée.

Définir `inverse : float list -> float list` qui calcule l'inverse de chaque
élément de la liste d'entrée.

### Fold

Il existe plusieurs `fold` dans le module `List`. Les deux qui nous intéressent
sont :

```ocaml
 val fold_left : ('acc -> 'elt -> 'acc) -> 'acc -> 'elt list -> 'acc

 val fold_right : ('elt -> 'acc -> 'acc) -> 'elt list -> 'acc -> 'acc
```

#### Exemple
```ocaml
List.fold_left (fun somme elt_i -> somme + elt_i) 0 [1; 2; 3; 4]
(* donne 10 ! *)

List.fold_right (fun elt_i somme -> somme + elt_i) [1; 2; 3; 4] 0
(* donne 10 aussi ! *)
```

#### Fold_left / fold_right : quelle est la différence ??

La documentation ...

`fold_left f init [b1; ...; bn]` is `f (... (f (f init b1) b2) ...) bn.`

`fold_right f [a1; ...; an] init` is `f a1 (f a2 (... (f an init) ...)).`

#### Des exemples :

```ocaml
let f a b = "(" ^ a ^ " + " ^ b ^ ")"
```

```ocaml
f "1" "2"
(* "(1 + 2)" *)
```
```ocaml
f (f "1" "2") "3"
(* "((1 + 2) + 3)" *)
```
```ocaml
f "1" (f "2" "3")
(* "(1 + (2 + 3))" *)
```

En l'utilisant avec les folds :
```ocaml
List.fold_left f "0" ["1"; "2"; "3"; "4"]

List.fold_right f ["1"; "2"; "3"; "4"] "0"
```

Et comme l'addition est commutative, si on fait l'opération affichée en string
sur des entiers, on obtient 10, avec `fold_left` et `fold_right` mais l'ordre de
calcul n'est pas le même.

En pratique, on utilise plus souvent `fold_left` par il est récursif terminal
contrairement à `fold_right`.

#### Exemples
```ocaml
List.fold_left (fun acc elt -> elt :: acc) [] ["B"; "o"; "n"; "j"; "o"; "u"; "r"]
```

```ocaml
List.fold_right (fun elt acc -> elt :: acc) ["B"; "o"; "n"; "j"; "o"; "u"; "r"] []
```

### Encore plus d'itérateurs

Il existe aussi des itérateurs combinés (`fold_left_map`), des itérateurs sur
deux listes (`map2`, `fold_left`, etc..) ou pour filter (`filter`).

#### Exemples
Filtre les entiers d'une liste pour ne garder que ceux pairs :
```ocaml
let filter_even l =
    List.filter (fun elt -> elt mod 2 = 0) l
```

Compare les éléments d'une liste termes à termes :
```ocaml
let compare_list l1 l2 =
    List.map2 (fun elt1 elt2 -> elt1 = elt2) l1 l2
```
Peut aussi s'écrire
```ocaml
let compare_list = List.map2 (=)
```

## Liste / Tableau (`List` / `Array`)

Les listes sont :
- une structure fonctionnelle (pas d'effet de bord) ;
- incroyables pour faire des prototypes, et écrire du code rapidement ;
- très efficace pour ajouter un élément en tête de liste (opération en temps constant) ;
- peu efficace pour ajouter un élément ailleurs, ou rechercher / retirer un élément ;
- une structure persistante.

Les tableaux sont globablement leur antagoniste !
- une structure impérative (qui fonctionne par effets de bord) ;
- plus complexe à utiliser (par exemple, ils ont une taille fixée à la création) ;
- très efficace pour rechercher/retirer/ajouter;
- une structure mutable.

### Persistance

Quand vous ajoutez une élément à une liste, vous ne modifiez pas la liste
d'entrée, vous en créez une nouvelle.

`OCaml` est très (très) efficace pour la création de nouvelle valeur immutable
et il dispose aussi d'un GC (garbage collector), qui va s'assurer que s'il n'y a
plus de lien vers une valeur, elle est nettoyée.

#### Exemple
Liste :
```ocaml
let l1 = [ 1; 2; 3 ];;
```
```ocaml
let l2 = 4 :: l1;;
```ocaml
l1;;
```

Tableau :
```ocaml
let a1 = [| 0 ; 1; 2; 3 |];;
```
```ocaml
let a2 = a1;;
a2.(0) <- 4;;
```
```ocaml
a1;;
```