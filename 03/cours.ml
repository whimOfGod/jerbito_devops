#show bool

type mon_bool = true | false
type mon_bool = Vrai | Faux

type maille =
  | Endroit
  | Envers
  | Glisse
  | Jete
  | Augmente (*                         *)

let esthetique maille =
  match maille with
  | Endroit -> 1.3
  | Envers -> 1.2
  | Glisse -> 1.
  | Jete -> 2.
  | Augmente -> 3.

let retournement maille =
  match maille with Endroit -> Envers | Envers -> Endroit

(** Types énumérés *)

type resultat = Gagne | Nul | Perdu

let point resultat =
  match resultat with Gagne -> 1. | Nul -> 0.5 | Perdu -> 0.
;;

point Gagne;;
point Perdu;;
point Nul

type semaine = Lundi | Mardi | Mercredi | Jeudi | Vendredi | Samedi | Dimanche

let est_un_weekend jour =
  match jour with Samedi | Dimanche -> true | _ -> false

type etat = Metro | Boulot | Dodo | Vacance

let etat_suivant etat =
  match etat with
  | Metro -> Boulot
  | Boulot -> Dodo
  | Dodo -> Metro
  | Vacance -> Vacance

type carte =
  | Coeur_A
  | Coeur_K
  | Coeur_Q
  | Coeur_J
  | Coeur_Dix
  | Coeur_Neuf
  | Coeur_Huit
  | Coeur_Sept
  | Trefle_As
  | Trefle_K
  | Trefle_Q
  | Trefle_J
  | Trefle_Dix
  | Trefle_Neuf
  | Trefle_Huit
  | Trefle_Sept
  | Carreaux_As
  | Carreaux_K
  | Carreaux_Q
  | Carreaux_J
  | Carreaux_Dix
  | Carreaux_Neuf
  | Carreaux_Huit
  | Carreaux_Sept
  | Pique_As
  | Pique_K
  | Pique_Q
  | Pique_J
  | Pique_Dix
  | Pique_Neuf
  | Pique_Huit
  | Pique_Sept

let est_rouge carte =
  match carte with
  | Coeur_A | Coeur_K | Coeur_Q | Coeur_J | Coeur_Dix | Coeur_Neuf | Coeur_Huit
  | Coeur_Sept | Carreaux_As | Carreaux_K | Carreaux_Q | Carreaux_J
  | Carreaux_Dix | Carreaux_Neuf | Carreaux_Huit | Carreaux_Sept ->
      true
  | _ -> false

let est_une_tete carte =
  match carte with
  | Trefle_K | Trefle_Q | Trefle_J | Pique_K | Pique_Q | Pique_J | Coeur_K
  | Coeur_Q | Coeur_J | Carreau_K | Carreau_Q | Carreau_J ->
      true
  | _ -> false

let score_normal carte =
  match carte with
  | Trefle_K | Carreaux_K | Pique_K | Coeur_K -> 4
  | Trefle_Q | Carreaux_Q | Pique_Q | Coeur_Q -> 3
  | Trefle_J | Carreaux_J | Pique_J | Coeur_J -> 2

type temperature_dimensionnee = Celsius of float | Farenheit of float

let temp_corporelle = Celsius 37.

let en_farenheit t =
  match t with Farenheit f -> f | Celsius c -> (c *. 9. /. 5.) +. 32.

type json =
  | Null
  | Bool of bool
  | Int of int
  | Float of float
  | String of string
  | Array of json list
  | Object of (string * json) list

let json1 = Array [ Null; Int 10; Bool true ]

(** Constructeurs avec données *)

type nombre = Entier of int | Flottant of float

let somme a b =
  match (a, b) with
  | Entier x, Entier y -> Entier (x + y)
  | Flottant x, Flottant y -> Flottant (x +. y)
  | Entier x, Flottant y | Flottant y, Entier x -> Flottant (float_of_int x +. y)

let division a b =
  match (a, b) with
  | Entier x, Entier y ->
      if x mod y = 0 then Entier (x / y)
      else Flottant (float_of_int x /. float_of_int y)
  | Flottant x, Flottant y -> Flottant (x /. y)
  | Entier x, Flottant y | Flottant y, Entier x -> Flottant (float_of_int x /. y)

type famille = Pique | Coeur | Carreaux | Trefle

type carte =
  | As of famille
  | K of famille
  | Q of famille
  | J of famille
  | Dix of famille
  | Neuf of famille
  | Huit of famille
  | Sept of famille

let est_une_tete c = match c with K _ | Q _ | J _ -> true | _ -> false
let est_rouge c = match c with K (Coeur | Carreaux) -> true | _ -> _

type point = { x : float; y : float }
type couleur = Pique | Coeur | Carreau | Trefle
type force = A | K | Q | J | Dix | Neuf | Huit | Sept
type carte = { couleur : couleur; force : force }

let est_une_tete c =
  match c with { couleur = _; force = K | Q | J } -> true | _ -> false

let resultat = est_une_tete { force = A; couleur = Carreau }

let compare_carte c1 c2 =
  let int_of_force x =
    match x with
    | A -> 7
    | K -> 6
    | Q -> 5
    | J -> 4
    | Dix -> 3
    | Neuf -> 2
    | Huit -> 1
    | Sept -> 0
  in
  if c1.couleur <> c2.couleur then (true : bool)
  else int_of_force c1.force > int_of_force c2.force

type carte_ou_joker = Joker | Carte_normale of carte
