# Polymorphisme Paramétrique &mdash; Cours

## Types prédéfinis

Les types `option` est `list` sont des variants avec des paramètres de type.
```ocaml
#show_type option
```

```ocaml
#show_type list
```

Ils ont des _paramètres de type_. On peut former `string list`, `int list`,
`float option` ou `bool list list`. Les noms `list` et `option` sont un peu
comme des nom de fonctions, avec les différences suivantes:
- Les résultats sont des types et non pas des valeurs
- L'argument est écrit en premier au lieu d'être écrit en second
- Les opérations sur les types ont lieu exclusivement pendant la compilation



Des fonctions telles que `List.map` ou `Option.join` ont également des
paramètres de type.
```ocaml
List.map
```

```ocaml
Option.join
```

On se contente d'écrire:
```ocaml
List.map float_of_int [1; 2; 3; 4];;
```

Mais en réalité `List.map` a quatre paramètres:
<ol reversed>
  <li>La liste <tt>[1; 2; 3; 4]</tt> &mdash; paramètre de donnée</li>
  <li>La fonction <tt>float_of_int</tt> &mdash; paramètre de donné</li>
  <li>Le type <tt>int</tt> &mdash; paramètre de type</li>
  <li>Le type <tt>float</tt> &mdash; paramètre de type</li>
</ol>

Quand on utilise `List.map` comme ci-dessus il est inutile (et impossible) de
passer `int` et `float`, le compilateur s'en charge automatiquement. Cependant,
on peut écrire ceci:
```ocaml
let int_float_map : (int -> float) -> int list -> float list = List.map
```

Algorithmiquement, la fonction `int_map` est la même que la fonction `List.map`.
Cependant les paramètres de types ont été spécifiés alors que les paramètres de
données ne l'ont pas été.

**Remarque**:
* Dans d'autres langages de programmation, le polymorphisme paramétrique est
souvent appelé _généricité_. On parle de types et de fonctions génériques.
C'est notamment le cas en Java, Scala, Kotlin, Swift, Go et Rust. Les paramètres
de types sont souvent indiqués entre des chevrons : `<` et `>`.
* Il existe d'autres formes de polymorphisme, notamment:
    - Le _polymorphisme ad-hoc_ permet de donner le même nom a des fonctions
      différentes mais manipulant des données apparentées. C'est le
      polymorphisme de la résolution des méthodes dans les langages orientés
      objet.
    - Le _row polymorphism_ (également appelé _duck typing_) permet à une même
      fonction d'accepter des enregistrements de type différents, mais ayant au
      moins certains champs. Il existe aussi une version pour les variants.
* Dans les langages avec types et fonctions génériques, il souvent possible de
ne pas spécifier les paramètres de types quand on appelle une fonction
générique. Mais pas toujours! Parfois, il faut indiquer au compilateur quels
sont paramètres de types.
* Les types `option` et `list` sont des variants avec paramètres de types. Il
  existe aussi des _variants polymorphes_ en OCaml, mais c'est autre chose, qui
  n'est pas présenté de ce cours.

## 

Quelques fonctions `map`
- `List.map`
- `Option.map`
- `Array.map`
- `Seq.map`

Des fonction `fold`
- `List.fold_left` et `List.fold_right`
- `Option.fold`
- `Array.fold_left` et `Array.fold_right`
- `Seq.fold_left`

Des fonction `concat` ou `join`
- `List.concat`
- `Option.join`
- Pas de `concat` pour les tableaux
- `Seq.concat`

Des fonction `concat_map` ou `bind`
- `List.concat_map`
- `Option.bind`
- Pas de `concat_map` pour les tableaux
- `Seq.concat_map`

```ocaml
let list_bind f x = List.(x |> map f |> concat)
```

```ocaml
let option_bind f x = Option.(x |> map f |> join)
```

```ocaml
let array_join x = Array.(x |> to_list |> concat)
```

```ocaml
let array_bind f x = Array.(x |> map f |> array_join)
```

```ocaml
let seq_bind f x = Seq.(x |> map f |> concat)
```

## Itérateurs

```ocaml
let twice f x = f (f x)

let thrice f x = f (f (f x))

let rec iter f n x = if n = 0 then x else iter f (n - 1) (f x);;

let rec fix f x = let y = f x in if x = y then x else fix f y

let rec fix f x = f (fix f) x

let fact_step k n = if n = 0 then 1 else n * k (n - 1)

let fact n = (fix fact_step) n
```

```ocaml
let rec loop f x = Either.(match f x with
  | Left x -> x
  | Right x -> loop f x);;

let fact_step (f, n) = match n with
  | 0 -> Either.Left f
  | n -> Either.Right (n * f, n - 1)

let fact n = loop fact_step (1, n)
```

## File (LIFO)

```ocaml
type 'a queue = {
  front : 'a list;
  rear_rev : 'a list
}

let empty = { front = []; rear_rev = [] }

let is_empty q = q.front = []

let hd q = List.hd q.front

let check = function (* private *)
| { front = []; rear_rev } -> { front = List.rev rear_rev; rear_rev = [] }
| q -> q

let snoc x q = check { q with rear_rev = x :: q.rear_rev }

let tl q = check { q with front = List.tl q.front }

let uncons = function
| { front = x :: front; _ } as q -> Some (x, { q with front })
| _ -> None
```
