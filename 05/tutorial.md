# Polymorphisme Paramétrique &mdash; Travaux pratiques

### Files

Écrire les fonctions suivantes pour le type `'a queue`:
* `equal : 'a queue -> 'a queue -> bool` dont le résultat est `true` si les deux files comparées contiennent les mêmes valeurs dans le même ordre et `false` dans tous les autres cas
* `of_list : 'a list -> 'a queue` Cette fonction doit vérifier les propriété suivantes :
    - `equal (u @ [x] |> of_list) (snoc x (of_list u))`
    - `hd (of_list (x :: u)) = x`
* `to_list : 'a queue -> 'a list` Cette fonction doit vérifier la propriété suivante :
    - `equal (to_list (snoc x q)) (to_list q @ [x])`
* `rev : 'a queue -> 'a queue`
* `append : 'a queue -> 'a queue -> 'a queue`
* `concat : 'a queue queue -> 'a queue`
* `filter : ('a -> bool) -> 'a queue -> 'a queue`
* `map : ('a -> 'b) -> 'a queue -> 'b queue`
* `fold : ('b -> 'a -> 'b) -> 'b -> 'a queue -> 'b`

### Fonction d'association

Écrire une fonction `def : ('a -> 'b) -> 'a -> 'b -> 'a -> 'b` telle que
* `def f x y x = y`
* `def f x y z = f z` si `x` &ne; `z`

En utilisant la fonction `def` écrire une fonction `sq : int -> int` telle que `sq x` = `x * x` si et seulement si `x` &le; 10. Si `x` > 10, la fonction `sq` lève une exception `Failure` avec le message `"undefined"`.

En utilisant `def` écrire une fonction `bogus_sq : int -> int` telle que `sq x` = `x * x` pour tous les entiers, sauf 42, où `sq 42 = 42`.

Écrire une fonction `sq'` ayant le même comportement que `sq` en utilisant `List.assoc`.

### `tstamp`
Le type suivant représente la disponibilité d'une donnée à une certaine date.
```ocaml
type 'a tstamp = { data : 'a; date : float; }
```
* Le champ `data` stocke la donnée, qui peut être d'un type quelconque
* Le champ `date` représente la date de disponibilité de la donnée

Définir les fonctions suivantes:
* `tstamp_join : 'a tstamp tstamp -> 'a tstamp`
* `tstamp_dupe : 'a tstamp -> 'a tstamp tstamp`
* `tstamp_map : ('a -> 'b) -> 'a tstamp -> 'b tstamp`

Dans le cas de `tstamp_join`,  on prend la date la plus récente.

### Observable

Le type suivant représente une suite d'évènements où une donnée devient
disponible.
```ocaml
type 'a obs = 'a tstamp list
```

On suppose que les évènements sont triés en ordre chronologique, les plus
anciens en tête de liste, les plus récents en fin de liste.

Définir la fonction suivante `obs_map : ('a -> 'b) -> 'a obs -> 'b obs`

### Fonctions utilitaires et de test

Définir une fonction `list_last : 'a list -> 'a` qui retourne le dernier élément
d'une liste ou lève une exception `Failure` si la liste est vide.

Définir une fonction `range : int -> int ->z int list` telle que, par exemple:
`range 3 7` a pour résultat `[3; 4; 5; 6; 7]`.

Pour générer des observables à des fins de tests, on fournit les fonctions
suivantes:
```ocaml
let tstamp_now data = { data; date = Unix.gettimeofday () }
```

```ocaml
let obs_pulse n freq d =
    List.init n (fun i -> {
        data = (d.data, i);
        date = d.date +. float_of_int i  *. freq
    })
```

### `concat_map`

Définir une fonction `obs_concat : 'a obs -> 'a obs -> 'a obs`. Le résultat de
`obs_concat u v` est un observable où les évènements de `u` sont en tête et les
évènements de `v` suivent et ont tous subi le même retard, de la telle sorte à
ce que le dernier évènement de `u` et le premier évènement de `v` se produisent
en même temps.

Définir une fonction `obs_concat_list : 'a obs obs -> 'a obs`. Cette fonction
réduit une liste de listes d'événements en une liste d'évènements « aplatie. »
On aplatit de proche en proche, en commençants avec la liste vide et en ajoutant
chacune des listes d'événements de la liste de listes d'évènements. Chaque ajout
est effectué en utilisant `obs_concat`.

Définir une fonction `obs_concat_map : ('a -> 'b obs) -> 'a obs -> 'b obs`.
Cette fonction est définie de la même manière que `List.concat_map` ou
`Option.bind`.

### `merge_map`

Définir une fonction `obs_merge : 'a obs -> 'a obs -> 'a obs`. Le résultat de
`obs_merge u v` est un observable où les évènements de `u` et `v` sont
entrelacés de telle sorte à ce que la liste résultante respecte l'ordre
chronologique. Les dates des évènements résultants sont inchangées.

De la même façon que précédemment, définir ensuite les fonctions:
* `obs_merge_list : : 'a obs obs -> 'a obs`
* `obs_merge_map : ('a -> 'b obs) -> 'a obs -> 'b obs`

### `switch_map`

Définir une fonction `obs_switch : 'a obs -> 'a obs -> 'a obs`. Le résultat de
`obs_switch u v` est un observable contenant tous les évènements de `v` précédés
par ceux de `u` qui se produisent avant le premier évènement de `v`. La liste
produite respecte l'ordre chronologique. Les dates des évènements résultants
sont inchangées.

De la même façon que précédemment, définir ensuite les fonctions:
* `obs_switch_list : : 'a obs obs -> 'a obs`
* `obs_switch_map : ('a -> 'b obs) -> 'a obs -> 'b obs`

### `exhaust_map`

Définir une fonction `obs_exhaust : 'a obs -> 'a obs -> 'a obs`. Le résultat de
`obs_exhaust u v` est un observable contenant tous les évènements de `u` suivit
par ceux de `v` qui se produisent après le dernier le dernier évènement de `u`.
La liste produite respecte l'ordre chronologique. Les dates des évènements
résultants sont inchangées.


De la même façon que précédemment, définir ensuite les fonctions:
* `obs_exhaust_list : : 'a obs obs -> 'a obs`
* `obs_exhaust_map : ('a -> 'b obs) -> 'a obs -> 'b obs`

### _refactoring_

Définir une fonction d'ordre supérieur de telle sorte à ne pas définir les
fonctions `obs_concat_list`, `obs_merge_list`, `obs_switch_list` et
`obs_exhaust_list`. Cette fonction permet d'utiliser directement:
* `obs_concat` dans la définition de `obs_concat_map`
* `obs_merge` dans la définition de `obs_merge_map`
* `obs_switch` dans la définition de `obs_switch_map`
* `obs_exhaust` dans la définition de `obs_exhaust_map`

On appellera cette fonction `obs_reduce`.

Ajouter des annotations de type à la définition de `obs_reduce` de telle sorte à
rendre son type plus adapté a son contexte d'utilisation et plus facile à
comprendre.

