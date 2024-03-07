# Expressions et valeurs

## Type de données et opérations de base

### Entiers

Les entiers on le type `int`

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

### Flottants

Les nombres flottants ont le type `float`

```ocaml
2.0 *. Float.pi
```

Opérations disponibles: `+.`, `-.`, `*.`, `/.`

L'expression `2 + 2.0` n'est pas valide. Pas de conversions de type implicites.

### Booléens

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

Pas d'opérateur ternaire de test. En OCaml, tout ce qui s'éxecute est une expression.

### Chaînes de caractères

```ocaml
"Hello world!"
```

```ocaml
"Hello" ^ " " ^ "world!"
```

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

En OCaml on appelle une fonction de la même manière qu'une commande en ligne: sans parenthèses. On sépare les arguments avec des espaces.

#### À plusieurs paramètres

Parentheses!

```ocaml
pow
```

```ocaml
pow 2.0 10.0
```

```ocaml
max (21 * 2) (int_of_string "713")
```

```ocaml
int_of_float (sqrt (float_of_int (int_of_string "81")))
```

```ocaml
"81" |> int_of_string |> float_of_int |> sqrt |> int_of_float
```

### Définitions globales

```ocaml
let a = 11
```

```ocaml
a * 4 - 1
```

### Définition de fonctions

```ocaml
let sq x = x * x
```

```ocaml
let float_sq x = x *. x
```

### Définitions locales

```ocaml
let d = 2 * 3 in d * 7
```

Observer que `d` est libre

#### Enchaînements de défintions

```ocaml
let d = 2 * 3 in
let e = d * 7 in
d * e
```

Observer que `d` et `e` sont libres

#### Imbrications de défintions

```ocaml
let d =
    let e = 2 * 3 in
    e * 5 in
  d * 7
```

Observer que `d` et `e` sont libres

#### Masquage interne

```ocaml
let i = 21
```

```ocaml
let i = 7 in i * 2;;
```

Observer la valeur de `i`

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

Après, `sq` est libre

### Fermeture

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

Les expressions suivantes sont équivalentes
```ocaml
let x = 2 * 3 in 7 * x
```

```ocaml
(fun x -> 7 * x) (2 * 3)
```