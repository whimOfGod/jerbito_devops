# Plan
- N-uplets
- Type `unit` et effets de bords
- Exceptions

# N-uplets et type produit

En OCaml, un n-uplet s'écrit avec la notation mathématique usuelle :
```ocaml
(1,2,3);;
(* type int * int * int *)
```

Son type est formé à partir de l'opérateur `*` et des types de ses différents
éléments. Il peut être d'arité quelconque et ses éléments peuvent être de types
différents :

```ocaml
let v = (42, "ocaml", true, 'o');;
(* int * string * bool * char *)
```

Les éléments d'un n-uplet ne sont pas modifiables en place et il n'y a pas moyen
de changer cet état de fait, contrairement aux enregistrements.

On peut accéder aux différents éléments d'un n-uplet à l'aide d'une déclaration
`let` déstructurante :

```ocaml
let (a, b, c, d) = v
```
ou si on ne souhaite extraire que certains éléments:
```ocaml
let (_, b_, c, _) = v
```

Avec `match .. with` :

```ocaml
let get_first nuplet =  match nuplet with
| (a, _, _, _) -> a
````
Notez le type de `get_first` : `'a*'b*'c*'d`.

Il n'est pas possible de faire un filtrage par motif sur des n-uplets d'arité différentes :
```ocaml
let get_first nuplet =  match nuplet with
| (a, _) -> a
| (a, _, _) -> a
| (a, _, _, _) -> a
```
car ce sont  des types différents !

Les n-uplets, comme les enregistrements, sont utiles pour écrire des fonctions
qui retournent plusieurs valeurs de types différents. Leur type n'a cependant
pas besoin d'être déclarée contrairement aux enregistrements.

Vous pouvez quand même lui donner un alias :
```ocaml
type pos = int * int
```

```ocaml
let get_x ((x, _) : pos) : int = x
```

On notera cependant que les enregistrements sont préférés dans certaines
situations parce que :
- les champs sont non ordonnés et le sucre syntaxique `{ my_field; _}` est très
  pratique.

```ocaml
type pos = { x : int; y : int; z : int}

let get_x {x; _} = x
```
- accéder à un champ peut se faire sans utiliser un filtrage (via `.`)
```ocaml
let get_x p = p.x
```

- avoir des éléments nommés peut éviter des erreurs de confusion.

Les paires sont cependant très utiles pour retourner plusieurs valeurs sans
avoir à définir un type au préalable (comme il faut le faire avec les
enregistrements).

#### Exemple

Fonction qui retourne le premier  et le dernier élément d'une liste :
```ocaml
let first_and_last ll =
    match ll with
    | [] -> raise (Invalid_argument "Liste vide")
    | x :: xs -> (x, (List.rev xs))
```

Fonction de division par soustraction retournant quotient et reste sous la forme
d'une paire :

```ocaml
let rec division n m =
  if n < m then (0, n)
  else let (q,r) = division (n - m) m in (q + 1, r)
```


### Un mot sur la curryfication

On peut aussi utiliser les paires pour réécrire une fonction à n arguments en
une fonction prenant un n-uplet en entrée.  Par exemple,

```ocaml
let somme x y x = x + y + x
(* int -> int -> int -> int  *)
```

pourrait s'écrire :
```ocaml
let somme_triplet (x, y, z) = x + y + z;;
(* (int * int * int) -> int *)
```

et on retrouve la syntaxe des fonctions C ou Java. Mais il y a des différences
importantes :

- `somme_triplet` ne prend bien qu'un argument en entrée. Il n'y a donc pas d'application partielle possible.

```ocaml
let somme_2 = somme 2
(* int -> int -> int *)
```

- il est est souvent moins efficace d'appeler une fonction avec un n-uplet en
  argument plutôt qu'une fonction avec plusieurs arguments.

L'opération de transformer une fonction qui prend un unique n-uplet en argument
à une fonction à plusieurs arguments s'appelle la curryfication (ou currying en
anglais).

# Unit et effets de bords

## Définition et syntaxe
Le type `unit` est un type préféfini en OCaml. Il ne possèdre qu'une seule valeur : `()`.

```ocaml
let a = ();;
(* val a : unit = () *)
```

En fait, c'est comme un type énuméré à un seul construteur. On pourrait le redéfinir :
```ocaml
type unit = | Unit
```

Il est très important de ne pas le confondre avec l'absence d'argument.
```ocaml
let f () = print_endline "Bonjour !"
```
est une fonction qui a un argument de type `unit`.

On peut d'ailleurs très bien écrire :
```ocaml
let f x y () = x + y
```

Dans ce cas, il est possible de faire :

```ocaml
let f_3 = f 1 2
(* unit -> int *)
```

La somme `1+2` n'est évaluée que quand `()` est appliqué à `f_3`.

```ocaml
let print_message w1 w2 () =
    Printf.printf "Bonjour %s et %s. \n" w1 w2
```

```ocaml
let print_monde = print_message "monde" "monde"
```

## Le type `unit` comme valeur de retour

Une fonction dont le type de retour est `unit` est une fonction qui ne retourne
pas d'informations. Son utilité est donc autre : des effets de bord.

Par exemple :

- toutes les fonctions d'affichage : `print_string : string -> unit`

- les fonctions de mutations de structures impératives
```ocaml
let arr = Array.make 3 0
```
```ocaml
arr.(2) <- 2
```

```ocaml
type pos = { mutable x : int; mutable y : int}
```
```ocaml
let p = { x = 0; y = 0}
```
```ocaml
p.x <- 42
```

- les itérateurs `iter`. `List.iter` a type `('elt -> unit) -> 'elt list -> unit)`
```ocaml
List.iter print_int [1;2;3]
```

## Les séquences

Il est possible de chainer des expressions de type `unit`. On
appelle ça une séquence.

```ocaml
print_string "Bonjour monde !";
print_string "\n";
print_string "OCaml n'est pas une langage fonctionnel pur !"
```

Notez que si vous placez des expressions d'un autre type dans une séquence, vous
allez avoir un warning

```ocaml
1;
print_string "A"
```
```
Line 1, characters 0-1:
Warning 10 [non-unit-statement]: this expression should have type unit.
```

Le type d'une séquence est le type de sa dernière expression :
```ocaml
print_string "Bonjour monde !";
print_string "\n";
print_string "OCaml n'est pas une langage fonctionnel pur !"
(* unit *)
```

```ocaml
print_string "Bonjour monde !";
print_string "\n";
42
(* int *)
```

## For et while

Les boucles impératives existent en OCaml. On en parle peu dans ce cours parce :
- vous connaissez déjà

- elles sont utiles sur les structures impératives dont on va peu parler

- elles nécessitent souvent l'utilisation de références dont on ne vous parlera pas !

Du coup, je vous invite à ne pas les utilisez dans les exercices qu'on vous donne (sauf si on vous le demande **explicitement**) !

```ocaml
let init_arr n finit =
    let v0 = f 0 in
    let arr = Array.make 0 v0 in
    for i = 1 to n - 1 do
    	arr.(i) <- f i (* expression de type unit *)
    done;
    arr
```

## If-then-else incomplet

C'est un cas classique où le compilateur retourne une erreur de type qu'il n'est
pas toujours facile à comprendre.

```ocaml
let is_1 n =
  if n = 1 then true
```

affiche

```
Error: This variant expression is expected to have type unit
         because it is in the result of a conditional with no else branch
       There is no constructor true within type unit
```

C'est parce qu'il y a un peu de sucre syntaxique. Prenons une expression valide :

```ocaml
let print_1 n =
    if n = 1 then print_int 1
    else ()
```

Cette fonction affiche `1` si l'argument vaut 1 et ne fait rien sinon. Mais on
peut aussi s'éviter de préciser "sinon ne fait rien" :

```ocaml
let print_1 n =
    if n = 1 then print_int 1
```

Si on revient à notre premier exemple :

```ocaml
let is_1 n =
  if n = 1 then true
```

est interprété par le compilateur comme :

```ocaml
let is_1 n =
  if n = 1 then true (* type bool *)
  else () (* type unit *)
```
et c'est effectivement une erreur de type.

# Exception

## Gérer les cas particuliers en fonctionnel pure
Un cas particulier gênant :

```ocaml
let head ll = match ll with
    | [] -> failwith "Liste vide"
    | hd :: _ -> hd
```

On pourrait le faire en fonctionnel pur avec `option` :

```ocaml
let head_opt ll = match ll with
  | [] -> None
  | hd :: _ -> Some hd
```

ou un type `value` qu'on définie :
```ocaml
type 'a value = Erreur of string | Value of 'a
```

```ocaml
let head = function
  | [] -> Erreur " Liste vide "
  | a :: l -> Value a
```

```ocaml
head []
(* Error "Liste vide" *)
```

```ocaml
head [1; 2; 3]
(* Value 1 *)
```

### Pas une bonne solution

L'accès aux valeurs est indirecte :

```ocaml
let div a b =
    if b = 0 then
       Erreur " Division par zéro "
    else
	Value ( a / b );;
```
```ocaml
( div 3 0) + 4;;
```
est une erreur de type
```
Characters 0 -9:
( div 3 0) + 4;;
^^^^^^^^^
This expression has type int value but is here used with type int
```

```ocaml
let plus a b = match a, b with
  | Value a , Value b -> Value ( a + b )
  | Erreur s , Value _ -> Erreur s
  | Value _ , Erreur s -> Erreur s
  | Erreur s1 , Erreur s2 -> Erreur ( s1 ^ " - " ^ s2 );;
```

```ocaml
let div a b = match a , b with
  | Value a , Value b -> if b = 0 then Erreur " Division par zéro " else Value ( a / b )
  | Erreur s , Value _ -> Erreur s
  | Value _ , Erreur s -> Erreur s
  | Erreur s1 , Erreur s2 -> Erreur ( s1 ^ " - " ^ s2 );;
```

```ocaml
plus ( div ( Value 3) ( Value 0)) ( Value 2);;
(* Erreur " Division par zéro " *)
```

On peut s’en sortir en définissant quelques fonctions et avec une syntaxe
appropriée (avec des monades, par exemple Haskell, ou quelques bibliothèques
OCaml comme `Result`).

### Un autre problème : comment interrompre ?

```ocaml
List.map (fun x -> div 10 x) [1; 2; 0; 2; 4]
(* [Value 10; Value 5; Erreur " Division par zéro "; Value 5; Value 2] *)
```

## Définition des exceptions
### Exceptions prédéfinies
Il existe des exceptions prédéfinis. Notamment :

- `Not_found` : levée par les fonctions comme `find` de la librairie
  standard (`List.find` , `List.assoc`, `Hstbl.find` etc..`)

- `Failure` : levée quand aucun résultat ne peut-être produit (`List.hd []` par
  exemple). Il est possible de lever cette exception avec `failwith "mon texte
  d'erreur"`

- `Invalid_argument` : levée en cas d'arguments invalides (`List.nth (-1)` par
  exemple)

### Définir de nouvelles exceptions

Le type d'une exception est `exn`. C'est un type somme extensible. C'est à dire
que c'est un type somme auquelle on peut ajouter de nouveaux constructeurs, en
utilisant `exception`.

```ocaml
exception Erreur
```
```ocaml
exception Invalid_int of int
```

Comme en Java les exceptions sont des valeurs de première classe. On peut ainsi écrire :

```ocaml
let check e = if e = Not_found then raise e;;
(* val check : exn -> unit = <fun> *)
```

```ocaml
let sort_exn (ll : exn list) =  List.sort compare ll;;
```
```ocaml
sort_exn [Not_found; Failure ""; Invalid_argument "Liste vide"; Exit ];;
```
## Lever une exception

Une exception est levée à l'aide de la construction `raise` :

```ocaml
let division a b =
    if b = 0 then
       raise Division_by_zero
    else
	a / b
```

La construction `raise` est une expression comme une autre, mais son typage est
particulier : elle peut prendre n'importe quel type, selon son contexte
d'utilisation.

```ocaml
if x >= 0 then
   2 * x
else
   raise Negatif
```

l'expression `raise Negatif` a le type `int`, de manière à ce que l'expression
complète soit bien typée, alors que dans l'expression

```ocaml
if x < 0 then
   raise Negatif;
2 * x
```

la même expression `raise Negatif` aura le type `unit`.

## Rattraper une exceptions

Il existe deux façons de rattraper une exception :
- avec `try .. with`
- avec `match .. with`

```ocaml
let mem a ll =
  match List.find (fun elt -> elt = a) ll with
  | _ -> true
  | exception Not_found -> false
```
```ocaml
let find_opt a ll =
    try
	let _ = List.find (fun elt -> elt = a) ll in
	true
    with Not_found -> false
```

Dans la documentation OCaml, les exceptions levées sont toujours notées.

```ocaml
let following_char_from str n ch =
  match String.index_from str n ch with
  | exception Not_found -> None
  | exception Invalid_argument _ -> None
  | ind -> (
      match String.get str (ind + 1) with
      | exception Invalid_argument _ -> None
      | c -> Some c)
```
```ocaml
let following_char_from str n ch =
  try
    let ind = String.index_from str n ch in
    Some (String.get str (ind + 1))
  with
  | Not_found -> None
  | Invalid_argument _ -> None
```

Le typage de l'expression `try with` fonctionne comme un `match with` : toutes
les branches doivent avoir le même type. Ici les branches sont
 - l'expression évaluée dans le `try` qui détermine le type
 - les branches du filtrage sur les exceptions qui doivent avoir le type que la branche `try`.

Dans l'exemple précédent, l'expression dans le `try` a type `char option`.
