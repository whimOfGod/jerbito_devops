# Expressions et Valeurs

## Type de données et opérations de base

### Entiers
```ocaml
2 + 2
```

```ocaml
2 * 3 * 7
```

```ocaml
2 * (20 + 1)
```

### Floatants
```ocaml
2.0 *. Float.pi
```

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
### Chaînes de caractères

```ocaml
"Hello world!"
```

```ocaml
"Hello" ^ " " ^ "world!"
```

## Fonctions et definitions

### Utilisation de fonctions

#### Un seul paramètre

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

#### Plusieurs parametres

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

### Definitions globales

```ocaml
let a = 11
```

```ocaml
a * 4 - 1
```

### Definition de fonctions

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

#### Enchaînements
```ocaml
let d = 2 * 3 in
let e = d * 7 in
d * e
```

Observer que `d` et sont `e` sont libres

#### Imbrications
```ocaml
let d =
    let e = 2 * 3 in
    e * 5 in
  d * 7
```

Observer que `d` et sont `e` sont libres

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

Vérifier que `sq` est non

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

Try to guess the output of `k 7` before evaluating it.

### Trivia

Les expressions suivantes sont équivalentes
```ocaml
let x = 2 * 3 in 7 * x
```

```ocaml
(fun x -> 7 * x) (2 * 3)
```