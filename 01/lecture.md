# Expressions et valeurs &mdash; Cours

**Note** Toutes les expressions présentées dans le cours doivent être évaluées
dans `utop`.

## Type de données et opérations de base

### Entiers

Les entiers ont le type `int`

```ocaml
2 + 2
```

```ocaml
2 * 3 * 7
```

```ocaml
2 * (20 + 1)
```

Opérations disponibles: `+`, `-`, `*`, `/`, `mod`

Voir les modules [`Stdlib`](https://ocaml.org/api/Stdlib.html) et
[`Int`](https://ocaml.org/api/Int.html).

### Flottants

Les nombres flottants ont le type `float`.

```ocaml
2.0 *. Float.pi
```

Voir les modules [`Stdlib`](https://ocaml.org/api/Stdlib.html) et
[`Float`](https://ocaml.org/api/Float.html).

Opérations disponibles: `+.`, `-.`, `*.`, `/.`

L'expression `2 + 2.0` n'est pas valide. Pas de conversions de type implicites.

### Booléens

Les Booléens ont le type `bool`. Ce ne sont pas des entiers.

```ocaml
true
```

```ocaml
false
```
```ocaml
3 > 5
```

```ocaml
2 + 2 = 4
```

```ocaml
if 0 = 1 then 3 else 7
```

```ocaml
2 * if true then 3 else 7
```

Opérations disponibles:
- `not` (négation « non »)
- `&&` (conjonction « et »)
- `||` (disjonction « ou »).

Pas d'opérateur ternaire de test. En OCaml, tout ce qui s'exécute est une
expression, `if ... then ... else ...` aussi.

Voir les modules [`Stdlib`](https://ocaml.org/api/Stdlib.html) et
[`Bool`](https://ocaml.org/api/Bool.html).

### Caractères

Les caractères ont le type `char`.

```ocaml
'a'
```

Voir les modules [`Stdlib`](https://ocaml.org/api/Stdlib.html) et
[`Char`](https://ocaml.org/api/Char.html).

### Chaînes de caractères

Les chaînes de caractères ont le type `string`. Les chaînes sont _immutables_
elles ne peuvent pas êtres modifiées. Les opérations dont les résultats sont des
chaînes créent de nouvelles chaînes, elles laissent leurs paramètres inchangés.

```ocaml
"Hello world!"
```

```ocaml
"\u{1F42B}"
```

```ocaml
"Hello" ^ " " ^ "world!"
```

```ocaml
"abcdefghijk".[4]
```

```ocaml
let a = "bonjour"
```

```ocaml
String.lowercase_ascii a
```

```ocaml
a
```

Voir les modules [`Stdlib`](https://ocaml.org/api/Stdlib.html) et
[`String`](https://ocaml.org/api/String.html).


## Fonctions et définitions

### Utilisation de fonctions

#### À un seul paramètre

```ocaml
int_of_float
```

```ocaml
int_of_float 42.0
```

```ocaml
float_of_int
```

```ocaml
float_of_int 42
```

En OCaml on appelle une fonction de la même manière qu'une commande en ligne :
sans parenthèses. On sépare les arguments avec des espaces.

#### À plusieurs paramètres

Parenthèses !

```ocaml
pow
```

```ocaml
pow 2.0 10.0
```

```ocaml
Int.max (21 * 2) (int_of_string "713")
```

```ocaml
int_of_float (sqrt (float_of_int (int_of_string "81")))
```

```ocaml
"81" |> int_of_string |> float_of_int |> sqrt |> int_of_float
```

### Définitions globales

Toutes les définitions entrées directement dans `utop` sont globales.

```ocaml
let a = 11
```

```ocaml
a * 4 - 1
```

### Définition de fonctions

Les fonctions sont des objets comme les autres :

```ocaml
fun x -> x * x
```

On peut utiliser une fonction sans lui donner de nom :

```ocaml
(fun x -> x * x) 3
```

```ocaml
let sq = fun x -> x * x
```

```ocaml
sq 3
```

```ocaml
let sq x = x * x
```

```ocaml
sq 3
```

```ocaml
let float_sq x = x *. x
```

### Définitions locales

```ocaml
let d = 2 * 3 in d * 7
```

Observer que `d` est libre.

#### Enchaînements de définitions

```ocaml
let d = 2 * 3 in
let e = d * 7 in
d * e
```

Observer que `d` et `e` sont libres.

#### Imbrications de définitions

```ocaml
let d =
    let e = 2 * 3 in
    e * 5 in
  d * 7
```

Observer que `d` et `e` sont libres.

#### Masquage interne

```ocaml
let i = 21
```

```ocaml
let i = 7 in i * 2;;
```

Observer la valeur de `i`.

#### Masquage

```ocaml
let h = 2 * 3
```

```ocaml
let e = h * 7
```

```ocaml
let h = 7
```

La valeur de `e` n'a pas changé.

#### Fonctions locales

```ocaml
let sq x = x * x in sq 7 * sq 7
```

Après, `sq` est libre.

### Fermetures

```ocaml
let j = 6
```

```ocaml
let k x = x * j
```

```ocaml
k 7
```

```ocaml
let j = 7
```

```ocaml
k 7
```

Essayer de deviner la valeur de `k 7` avant de l'évaluer.

### Trivia

Les expressions suivantes sont équivalentes :
```ocaml
let x = 2 * 3 in 7 * x
```

```ocaml
(fun x -> 7 * x) (2 * 3)
```

### Fonctions Récursives

Les fonction récursives ne peuvent pas être anonymes et doivent être définies en
utilisant le mot clé `rec`.

```ocaml
let rec string_repeat s n = if n > 0 then s ^ string_repeat s (n - 1) else ""
```

```ocaml
let rec zioup s n = if n > 0 then s ^ ", " ^ \ zioup s (n - 1) else "."
```

```ocaml
let rec piouz s n = if n > 0 then piouz s (n - 1) ^ ", " ^ s else "."
```

```ocaml
let rec par be en i = if i = 0 then "" else be ^ par be en (i - 1) ^ en
```

```ocaml
let rec fact n = if n = 0 then 1 else n * fact (n - 1)
```

```ocaml
let rec fibo n =
  if n = 0 then 0
  else if n = 1 then 1
  else fibo (n - 1) + fibo (n - 2)
```

```ocaml
let rec fibo n = match n with
  | 0 -> 0
  | 1 -> 1
  | n -> fibo (n - 1) + fibo (n - 2)
```
