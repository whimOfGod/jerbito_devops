type fin_partie =
  | Victoire
  | Nul
  | Defaite

let score_partie = function
  | Victoire -> 1.0
  | Nul -> 0.5
  | Defaite -> 0.0

semaine 

type semaine =
  | Lundi | Mardi | Mercredi | Jeudi | Vendredi | Samedi | Dimanche

let est_un_weekend = function
  | Samedi | Dimanche -> true
  | _ -> false


métro


type etat_mb =
  | Metro | Boulot | Dodo

let action_suivante = function
  | Metro -> Boulot
  | Boulot -> Dodo
  | Dodo -> Metro



type point = { x : float; y : float }


type valeur = As | Roi | Dame | Valet | Dix | Neuf | Huit | Sept | Joker
type couleur = Pique | Coeur | Carreau | Trefle
type carte_a_jouer = { valeur : valeur; couleur : couleur option }


let return x y =
  if y = 0 then None
  else Some (x / y)



type json =
  | Entier of int
  | Flottant of float
  | Chaine of string
  | Tableau of json list
  | Objet of (string * json) list

let rec vers_chaine = function
  | Entier n -> string_of_int n
  | Flottant f -> string_of_float f
  | Chaine s -> "\"" ^ s ^ "\""
  | Tableau lst -> "[" ^ String.concat ", " (List.map vers_chaine lst) ^ "]"
  | Objet fields ->
      "{" ^ String.concat ", " (List.map (fun (k, v) -> "\"" ^ k ^ "\": " ^ vers_chaine v) fields) ^ "}"


(* cas d'utilisation : *) 

let resultat_partie = Victoire in
let score = score_partie resultat_partie in
Printf.printf "Score de la partie : %.1f\n" score

(* cas d'utilisation semaine : *)

let jour = Samedi in
if est_un_weekend jour then
  print_endline "C'est le week-end !"
else
  print_endline "Ce n'est pas le week-end."

(* 

utop # 
    let resultat_partie = Victoire in
    let score = score_partie resultat_partie in
    Printf.printf "Score de la partie : %.1f\n" score ;;
Error: Unbound constructor Victoire
─( 08:55:32 )─< command 3 >───────────────────────────────────{ counter: 0 }─
utop # type fin_partie =
  | Victoire
  | Nul
  | Defaite ;

let score_partie = function
  | Victoire -> 1.0
  | Nul -> 0.5
  | Defaite -> 0.0 ;;
Error: Syntax error
─( 08:56:48 )─< command 4 >───────────────────────────────────{ counter: 0 }─
utop # type fin_partie =
  | Victoire
  | Nul
  | Defaite ;;
type fin_partie = Victoire | Nul | Defaite
─( 08:57:50 )─< command 5 >───────────────────────────────────{ counter: 0 }─
utop # let score_partie = function
  | Victoire -> 1.0
  | Nul -> 0.5
  | Defaite -> 0.0 ;;
val score_partie : fin_partie -> float = <fun>
─( 08:58:03 )─< command 6 >───────────────────────────────────{ counter: 0 }─
utop # type semaine =
  | Lundi | Mardi | Mercredi | Jeudi | Vendredi | Samedi | Dimanche ;;
type semaine =
    Lundi
  | Mardi
  | Mercredi
  | Jeudi
  | Vendredi
  | Samedi
  | Dimanche
─( 08:58:15 )─< command 7 >───────────────────────────────────{ counter: 0 }─
utop # 
let est_un_weekend = function
  | Samedi | Dimanche -> true
  | _ -> false ;;
val est_un_weekend : semaine -> bool = <fun>
─( 08:58:30 )─< command 8 >───────────────────────────────────{ counter: 0 }─
utop # type etat_mb =
  | Metro | Boulot | Dodo ;;
type etat_mb = Metro | Boulot | Dodo
─( 08:58:48 )─< command 9 >───────────────────────────────────{ counter: 0 }─
utop # let action_suivante = function
  | Metro -> Boulot
  | Boulot -> Dodo
  | Dodo -> Metro ;;
val action_suivante : etat_mb -> etat_mb = <fun>
─( 08:59:22 )─< command 10 >──────────────────────────────────{ counter: 0 }─
utop # type point = { x : flot ; y : float  };;
Error: Unbound type constructor flot
Hint: Did you mean float?
─( 08:59:45 )─< command 11 >──────────────────────────────────{ counter: 0 }─
utop # type point = { x : float ; y : float  };;
type point = { x : float; y : float; }
─( 09:03:01 )─< command 12 >──────────────────────────────────{ counter: 0 }─
utop # type valeur = As | Roi | Dame | Valet | Dix | Neuf | Huit | Sept | Joker ;; 
type valeur = As | Roi | Dame | Valet | Dix | Neuf | Huit | Sept | Joker
─( 09:03:12 )─< command 13 >──────────────────────────────────{ counter: 0 }─
utop # type couleur = Pique | Coeur | Carreau | Trefle ;;
type couleur = Pique | Coeur | Carreau | Trefle
─( 09:05:36 )─< command 14 >──────────────────────────────────{ counter: 0 }─
utop # type carte_a_jouer = { valeur : valeur ; couleur : couleur option };;
type carte_a_jouer = { valeur : valeur; couleur : couleur option; }
─( 09:06:45 )─< command 15 >──────────────────────────────────{ counter: 0 }─
utop # let return x y = 
       if y = o then none
       else Some (x/y);;
Error: Unbound value o
─( 09:08:37 )─< command 16 >──────────────────────────────────{ counter: 0 }─
utop # let return x y =
  if y = 0 then None
  else Some (x / y) ;;
val return : int -> int -> int option = <fun>
─( 09:10:17 )─< command 17 >──────────────────────────────────{ counter: 0 }─
utop # type json =
  | Entier of int
  | Flottant of float
  | Chaine of string
  | Tableau of json list
  | Objet of (string * json) list ;;
type json =
    Entier of int
  | Flottant of float
  | Chaine of string
  | Tableau of json list
  | Objet of (string * json) list
─( 09:10:38 )─< command 18 >──────────────────────────────────{ counter: 0 }─
utop # let rec vers_chaine = function
  | Entier n -> string_of_int n
  | Flottant f -> string_of_float f
  | Chaine s -> "\"" ^ s ^ "\""
  | Tableau lst -> "[" ^ String.concat ", " (List.map vers_chaine lst) ^ "]"
  | Objet fields ->
      "{" ^ String.concat ", " (List.map (fun (k, v) -> "\"" ^ k ^ "\": " ^ vers_chaine v) fields) ^ "}" ;;
val vers_chaine : json -> string = <fun>
─( 09:11:03 )─< command 19 >──────────────────────────────────{ counter: 0 }─
utop # let resultat_partie = Victoire in
let score = score_partie resultat_partie in
Printf.printf "Score de la partie : %.1f\n" score ;;
Score de la partie : 1.0
- : unit = ()
─( 09:11:37 )─< command 20 >──────────────────────────────────{ counter: 0 }─
utop # let jour = Samedi in
if est_un_weekend jour then
  print_endline "C'est le week-end !"
else
  print_endline "Ce n'est pas le week-end." ;;
C'est le week-end !
- : unit = ()
─( 09:14:34 )─< command 21 >──────────────────────────────────────────────{ counter: 0 }─


*)