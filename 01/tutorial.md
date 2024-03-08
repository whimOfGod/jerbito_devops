# Expressions et valeurs &mdash; Travaux Pratiques

## Type de données et opérations de base

### Entiers

1. Évaluer les expressions suivantes :
    - `2 * 3 + 5 + 7 * 11`
    - `2 * (3 + 5) + 7 * 11`
    - `2 * 3 + (5 + 7) * 9`

1. Ajouter le moins de parenthèses possible à cette expression :
   ```ocaml
   8 / 2 * 2 + 2
   ```
   pour obtenir les valeurs suivantes :
    - `16`
    - `1`
    - `4`

1. Évaluer les expressions suivantes :
    - `succ 0`
    - `succ (succ 0)`
    - `succ 3 * 5`
    - `succ (3 * 5)`

1. Trouver les constantes définissant le plus petit et le plus grand des entiers
   représentables. Ajouter _1_ au plus grand entier, soustraire _1_ au plus
   petit entier.

1. Calculer _2⁹_ en utilisant l'opération de décalage à gauche

### Flottants

Évaluer les expressions suivantes :
  - `2.0 *. Float.pi`
  - `Float.epsilon`
  - `1.0 /. 0.0` `0.0 /. 0.0`
  - `Float.infinity +. 1.0`
  - `Float.(infinity *. infinity)`
  - `Float.(infinity /. infinity)`
  - `Float.(nan +. infinity)`
  - `Float.(succ pi -. pi)`

### Booléens

Évaluer les expressions suivantes:

* `1 / 0`
* `1 / 0 = 1`
* `true || 1 / 0 = 1`
* `false && 1 / 0 = 1`
* `if true then 5 else 1 / 0`
* `if false then 1 / 0 else 7`
* `2 * if true else 5`
* `"ab" ^ if false then "cd" else "wx"`
* `if true then "cd" else "wx" ^ "yz"`

### Caractères

Évaluer les expressions suivantes:
* `'a'`
* `'a' |> int_of_char`
* `'a' |> int_of_char |> succ`
* `'a' |> int_of_char |> succ |> char_of_int`

### Chaînes de caractères

1. Utiliser la fonction
   [`String.sub`](https://ocaml.org/api/String.hmtl#VALsub) pout extraire le mot
   `"volcano"` du mot `"pneumonoultramicroscopicsilicovolcanoconiosis"`

1. Convertir `true` en `string` puis `"true"` en `bool`

1. Convertir `42` en `string` puis `42` en `string`

1. Convertir `42.0` en `string` puis `42.0` en `string`


## Fonctions et définitions

### Utilisation de fonctions

#### À un seul paramètre

1. À l'aide des opérations du langage, calculer le nombre de bits utilisé pour
   représenter les entiers

#### À plusieurs paramètres

Évaluer les expressions suivantes:
- `( + ) 2 3`
- `( * ) 2 3`
- `( ^ ) "ha " "ha "`

### Définitions globales


### Définitions de fonctions

1. Écrire une fonction
   ```
   char_succ : char -> char
   ```
   telle que:
    - `char_succ '\255' = '\000'`
    - Si `c < '\255'` alors `int_of_char (char_succ c) = succ (int_of_char c)`

   Par exemple, `char_succ 'a'` vaut `'b'`.

1. En utilisant la fonction
   [`String.make`](https://ocaml.org/api/String.hmtl#VALmake), écrire une
   fonction
   ```ocaml
   string_cons : char -> string -> string
   ```
   telle que
   `string_cons c s` retourne une chaîne dont le premier caractère est `c` et
   les suivants sont ceux de `s` (dans le même ordre). Par exemple `string_cons
   'a' "bcd"` vaut `"abcd"`.

### Définitions locales

#### Enchaînements de définitions

1. Réécrire cette expression
   ```ocaml
   int_of_float (sqrt (float_of_int (int_of_string "81")))
   ```
   en utilisant un enchaînement de definitions locales.

#### Imbrications de définitions

1. Écrire et évaluer une expression formée de la concaténation de trois chaînes
   de caractères:
      - Une definition locale `i_u_we` valant `"I scream, you scream, we all scream"`
      - La chaîne `" for ice "`
      - Une definition locale `cr` valant `"cream"`

   Définir `cr` avant `i_u_we`
2. Modifier l'expression précédente de telle sorte à ce que `i_u_we` soit
   définie par l'expression suivante:
   ```ocaml
   "I " ^ sr ^ ", you " ^ sr ^ ", we all " ^ sr
   ```
   où `sr` est une définition locale (imbriquée) valant `"s" ^ cr` dans cette
   expression, mais pas pour l'expression englobante.

#### Masquage interne

#### Masquage

#### Fonctions locales

### Fermetures

1. Évaluer l'expressions suivante: `(let a = 7 in fun x -> a * x) 2`
1. Effectuer les opérations suivantes :
      - Saisir la définition `let f = let a = 7 in fun x -> a * x`
      - Évaluer `f 2`
1. Effectuer les opérations suivantes :
      - Saisir la définition `let g x = let a = 7 in a * x`
      - Évaluer `g 2`

### Fonctions récursives

1. En utilisant les fonction `char_succ` et `string_cons` définies précédemment,
   écrire une fonction `char_range` de type `char -> char -> string` telle que
   `char_range lo hi` renvoie une chaîne de caractères formé de tous les
   caractères de `lo` à `hi` (en ordre croissant). Par exemple, `char_range 'a'
   'd'` renvoie `"abcd"`.
1. En utilisant les fonction `char_succ` et `string_cons` définies précédemment,
   écrire une fonction `char_range_rev_cat` de type `string -> char -> char ->
   string` telle que `char_range s lo hi` renvoie une chaîne de caractères formé
   de tous les caractères de `hi` à `lo` (en ordre décroissant) puis ceux de
   `s`. Par exemple, `char_range_rev_cat "123" 'a' 'd'` renvoie `"dcba123"`.
1. En réutilisant le corps de la fonction précédente et une définition locale,
   écrire une fonction `char_range_rev` de type `char -> char -> string` telle
   que `char_range lo hi` renvoie une chaîne de caractères formé de tous les
   caractères de à `hi` à `lo` (en ordre décroissant). Par exemple,
   `char_range_rev 'a' 'd'` renvoie `"dcba"`.
1. Écrire une fonction recursive `is_palindrome` de type `string -> bool` telle
   que `is_palindrome s` ne renvoie `true` que si dans `s` : le premier
   caractère de est égal au dernier, le deuxième à l'avant dernier, _etc._ Par
   exemple, `is_palindrome "tenet"` vaut `true` alors que `is_palindrome
   "opera"` vaut `false`.
1. Écrire une fonction récursive `pow` de type `int -> int -> int` telle que
   `pow x n` calcule _x<sup>n</sup>_. Cette fonction doit utiliser l'algorithme
   de l'exponentiation rapide:
     - _x<sup>0</sup> = 1_
     - _x<sup>n</sup> = (x<sup>n/2</sup>)<sup>2</sup>_ si _n_ est pair
     - _x<sup>n</sup> = x &times; (x<sup>n/2</sup>)<sup>2</sup>_ si _n_ est impair
1. Écrire une fonction récursive `div` de type `int -> int -> int` telle que
   `div n d` calcule _n/d_ en utilisant l'algorithme d'Euclide:
     - _n/d = 0_ si _n < d_
     - _n/d = 1 + (n - d) / d_ si _n >= d_
