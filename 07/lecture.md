# Modules &mdash; Cours

Un module `Toto` est groupe composé de:
- types
- définitions
- modules (les sous-modules)
Tous composants d'un module ont des noms de la forme `Toto.machin` ou `Toto.truc`.

**Avertissement** Les modules ne sont pas des classes
- Il n'y a pas de relation d'héritage entre les modules
- Les modules n'ont pas d'instances

## Visite de la bibliothèque standard

Quelques modules à visualiser avec `#show`
- `Option`
- `List`
- `Printf`
- `Buffer` Observer la valeur de `Buffer.create 32`
- `Stdlib`

## Ouvertture de module

Il existe trois manière d'ouvrir un module:
- Ouverture globale: `open Printf`
- Ouverture locale
  * Avec `let ... in` : `let open List in`
  * Avec la notation pointée :

Par défaut le module `Stdlib` est ouvert. Tout ce passe comme si tous les fichers
OCaml commençaient avec un `open Stdlib`.

## Créer et compiler un module

Un ficher `toto.ml` défini un module appelé `Toto`

Voir l'exemple `roll.ml` qui défini le module `Roll`.
- Pour le compiler: `dune build`
- Pour le charger dans `utop`: `dune build utop`

**Remarque**: l'outil Dune crée un module `M07` à partir du répertoire `07`.
Dans `utop` le module défini par le fichier `roll.ml` a donc le nom `M07.Roll`.

## Signatures

La signature d'un module est la liste de ses composants. Dans `utop` ont
l'affiche à l'aide de `#show Roll;;` appliqué a un nom de module. En ligne de
commande on peut faire `ocamlc -c -i roll.ml` pour afficher la signature d'un
module.

## Fonction privées et types abstraits

Pour chaque fichier `toto.ml` ont peut créer un fichier `toto.mli` qui liste le
contenu du module `Toto`.

Si une définition est présente dans le fichier `toto.ml` mais sont type est
absent dans le ficher `toto.mli`, la définition est *privée*

Pour les définition de types il possible d'écrire `type foo` dans le fichier
`.mli`. Dans ce cas, le type devient *abstrait*.

Exemple:
- `Stdlib.Buffer.t` type abstrait
- `Roll.t` type abstrait
- `Roll.empty` définition privée

On peut aussi avoir des types privés

Exercices `Roll`, `Queue` et dictionnaire

## Sous-Modules

On peut définir un module à l'intérieur d'un module
```ocaml
module Nat = struct
  type t = unit list
  let zero = []
  let succ n = () :: n
  let rec plus m n = match n with [] -> m | () :: n -> succ (plus m n)
  let rec mult m n = match n with [] -> [] | () :: n -> plus m (mult m n)
  let rec of_int i = if i = 0 then [] else succ (of_int (i - 1))
  let rec to_int n = match n with [] -> 0 | () :: n -> 1 + (to_int n)
end
```

Il est également possible de définir l'interface d'un sous-module

```ocaml
module Peano : sig
  type t
  val zero : t
  val succ : t -> t
  val plus : t -> t -> t
  val mult : t -> t -> t
  val of_int : int -> t
  val to_int : t -> int
end = struct
  type t = unit list
  let zero = []
  let succ n = () :: n
  let rec plus m n = match n with [] -> m | () :: n -> succ (plus m n)
  let rec mult m n = match n with [] -> [] | () :: n -> plus m (mult m n)
  let rec of_int i = if i = 0 then [] else succ (of_int (i - 1))
  let rec to_int n = match n with [] -> 0 | () :: n -> 1 + (to_int n)
end
```

Mais il possible de donner un nom a un type d'interface.
```ocaml
module type PeanoType = sig
  type t
  val zero : t
  val succ : t -> t
  val plus : t -> t -> t
  val mult : t -> t -> t
  val of_int : int -> t
  val to_int : t -> int
end
```

Ce qui permet d'écrire les chose suivantes:
```ocaml
module PeanoNat : PeanoType = Nat

module PeanoInt : PeanoType = struct
  type t = int
  let zero = 0
  let succ n = n + 1
  let plus a b = a + b
  let mult a b = a * b
  let of_int i = i
  let to_int i = i
end
```

## Utiliser le foncteur `Set.Make`

Opératiions sur les ensembles

Dans OCaml, il y a des « fonction » qui prennent des modules en entrée et
produisent des module en sortie, on les appelle des foncteurs.
```ocaml
module IntSet = Set.Make(struct
  type t = int
  let compare a b = a - b
end)

module StringSet = Set.Make(struct
  type t = string
  let compare a b = if a < b then (-1) else if a > b then 1 else 0
end)
```

N'importe quel module vérifiant la signature `Set.OrderedType` peut être
appliqué au foncteur `Set.Make`
```ocaml
module IntSet = Set.Make(Int)
module StringSet = Set.Make(String)
module FloatSet = Set.Make(Float)
```

## Utiliser le foncteur `Map.Make`

Opérations sur des dictionnaires

Le foncteur `Map.Make` prend en entrée un module ayant la même signature que
pour une `Set`. Il faut juste un type `t` et une fonction `compare : t -> t ->
int`.

Cependant, le type `t` est le type de _clés_ les fonctions

Définition de dictionnaires dans un module:
```ocaml
module IntMap = Map.Make(Int)
module StringMap = Map.Make(String)
```

Déclaration de dictionnaire dans une interface:
```ocaml
module IntMap : Map.S with type key = int
module StringMap : Map.S with type key = string
```
