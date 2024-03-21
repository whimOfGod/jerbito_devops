# Modules &mdash; Travaux pratiques

## Liste non vide

Compléter les fichiers `roll.ml` et `roll.mli` pour ajouter les fonction suivantes:
- `length : 'a t -> int`
- `append : 'a t -> 'a t -> 'a t`
- `concat : 'a t t -> 'a t`
- `rev : 'a t -> 'a t`
- `map : ('a -> 'b) -> 'a t -> 'b t`
- `concat_map : ('a -> 'b t) -> 'a t -> 'b t`

## File d'attente

Créer des fichier `queue.ml` et `queue.mli` reprenant les définitions données
dans le cour et les exercices. Faire en sorte que :
- Le type `Queue.t` soit abstrait
- La fonction `Queue.check` soit privée

## Dictionnaire 1

Créer un fichier `dico1.mli` avec le contenu suivant:
```ocaml
type 'a t
val empty : 'a t
val find : int -> 'a t -> 'a
val add : int * 'a -> 'a t -> 'a t
val del : int -> 'a t -> 'a t
```

Créer un fichier `dico1.ml`. Poser `type 'a t = (int * 'a) list` et utiliser la
fonction `List.assoc` pour écrire `find` et trouver des fonctions dans le module
`List` pour écrire `add` et `del`

## Dictionnaire 2

Créer un fichier `dico2.ml` avec le contenu suivant:
```ocaml
type 'a t = int -> 'a
let empty _ = raise Not_found
let find key dico = dico key
let add (key, value) dico = fun x -> if key = x then value else dico x
let del key dico = fun x -> if key = x then raise Not_found else dico x
```

Créer une copier du fichier `dico1.mli` appelée `dico2.mli`

Dans `utop` évaluer les expressions suivantes:
```ocaml
let d1 = Dico1.(empty |> add (1, "rouge") |> add (1, "vert") |> add (1, "bleu"))
```

```ocaml
let d2 = Dico2.(empty |> add (1, "rouge") |> add (1, "vert") |> add (1, "bleu"))
```

```ocaml
Dico1.find 1 d1
```

```ocaml
Dico2.find 1 d2
```

```ocaml
Dico1.find 5 d1
```

```ocaml
Dico2.find 5 d2
```

## Utilisation du foncteur `Set`

Pour écrire les fonctions suivantes, vous devez utiliser le foncteur `Set`

* Écrire une fonction `has_dupes : int list -> bool` qui décide si une liste
contient des doublons.
* Écrire une fonction `uniq : int list -> int list` qui retourne une liste où
  tous les doublons de la liste d'entrée ont été supprimés

Écrire les mêmes fonctions pour les ensembles de chaînes de caractères.

Définir un module `Int2Set` pour des ensemble de paires d'entiers (le type `int * int`).
Écrire les fonctions suivantes:
- `split : Int2Set.t -> IntSet.t * IntSet.t`
- `combine : IntSet.t -> IntSet.t -> Int2Set.t`

## Utilisation du foncteur `Map`

1. Définir le module `CharMap` dont le clés sont des `Char`

1. Écrire une fonction `char_digit : int -> char` telle que :
  * `char_digit 0 = '0'`
  * `char_digit 1 = '1'`
  * `char_digit 2 = '2'`
  * et de même jusqu'à 9.

1. Utiliser les fonction `List.init`, `char_digit` et `CharMap.of_list` pour
   créer un dictionnaire de longueur 10 associant 0 à chaque caractère
   numérique. Appeler ce dictionnaire `init`. Un tel dictionnaire représente le
   nombre de fois où on a compté les chiffres `'0'`, `'1'`, `'2'`, _etc._

1. Écrire une fonction `lead_digit : int -> char` qui renvoie le chiffre de
   poids le plus fort d'un entier. Par exemple `lead_digit 713` est `'7'`

1. Écrire une fonction `record_lead_digit : int CharMap.t -> int -> int
   CharMap.t` telle que `record_lead_digit dico n` retourne un dictionnaire où
   le compte associé au chiffre de poids le plus fort de `n` est incrémenté de 1.

1. Écrire une fonction `distrib : int -> (char * float) int` telle que `distrib
   n` renvoie liste de paires `char * float` où on trouve, pour tous les nombre
   inférieurs à `n`
   - La proportion de ces nombres de le chiffre de poids le plus fort est `0`
   - La proportion de ces nombres de le chiffre de poids le plus fort est `1`
   - La proportion de ces nombres de le chiffre de poids le plus fort est `2`
   - _etc._

    La liste est retournée triée en ordre de proportion décroissante.

    L'idée est de construire un dictionnaire qui contient, pour chacun des 10
    chiffre, le compte de nombres où il est le chiffre de poids le plus fort.
      1. Construire la liste des entiers de 0 à `n - 1`
      1. Utiliser un itérateur de list pour construire un dictionaire pour ces
         entiers à l'aide de la fonction `record_lead_digit`
      1. Extraire le contenu du dictionnaire
      1. Mapper pour calculer les pourcentages
      1. Trier




