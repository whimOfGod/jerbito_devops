(* FAMILIARISATION AVEC LA SYNTAXE DES LISTES ET DES TABLEAUX *)

let a = [1;2;3];;
val a : int list = [1; 2; 3]

utop # let list = [];;
val list : 'a list = []

let list_vide = [];;
(* Réponse : *)val list_vide : 'a list = []


let list_int = [1;2;3;4;5] ;;
val list_int : int list = [1; 2; 3; 4; 5]

let list_char = ["paul";"gautier";"jean"] ;;
(* Réponse : *)val list_char : string list = ["paul"; "gautier"; "jean"]

let new_list = 0 :: list_int;;
(* Réponse : *)val new_list : int list = [0; 1; 2; 3; 4; 5]

list_char :: "monsieur";;

list_char = "monsieur" :: list_char;;
(* Réponse : *)- : bool = false

list_char ;;
(* Réponse : *)- : string list = ["paul"; "gautier"; "jean"]

let new_list_char = "monsieur" @ list_char ;;
let new_list_char = list_char @ "monsieur";;


let new_list_int = list_int @ [4;5;6];;
(* Réponse : *)val new_list_int : int list = [1; 2; 3; 4; 5; 4; 5; 6]

let fist_element_list = List.hd list_int ;;
(* Réponse : *)val fist_element_list : int = 1

let rest_list = List.hd list_int ;; 
(* Réponse : *)val rest_list : int = 1



(* EXERCICE 1 *)
 let last lst =
       match List.rev lst with
       | [] -> failwith "La liste est vide"
       | hd :: _ -> hd ;;
(* Premier cas d'utilisation *)
last [1;2;3;4;5];;
(* Réponse : *) : int = 5

(* Deuxième cas d'utilisation *)
last ["martin";"luther";"king"];;
(* Réponse : *) : string = "king"



(* EXERCICE 2 : il s'agira là d'écrire un programme qui permettra d'intervertir le ou les valeurs contenues dans un tableau *)

(* first method *)
let swap lst =
 match lst with
 | [] | [_] -> lst  
 | x :: y :: reste -> y :: x :: reste ;;

(* second method *)
 let swap = function
 | x :: y :: reste -> y :: x :: reste
 | lst -> lst

 (* Cas d'utilisation *)
 swap [1;2;3] ;;
 (* Réponse : *) : int list = [2; 1; 3]



(* EXERCICE 3 *)

let repeat element n =
if n < 0 then []
else List.init n (fun _ -> elem);;
 (* Cas d'utilisation *)
repeat "hello world" 5;;


(* EXERCICE 4 *)
let range_i arg1 arg2 =
if arg1 > arg2 then []
else List.init (arg2 - arg1 + 1) (fun index -> arg1 + index);;
 (* Cas d'utilisation *)
range_i 15 35 ;;

(* Exercice 6 *) 

let liste_initiale = [3; 7; 10; 2; 5];;
val liste_initiale : int list = [3; 7; 10; 2; 5]

decrement_list liste_initiale ;;

utop # let rec rev lst =
       let rec rev_acc acc = function
       | [] -> acc
       | hd :: tl -> rev_acc (hd :: acc) tl
       in
       rev_acc [] lst;;

val rev : 'a list -> 'a list = <fun>

utop # let rec mem elem lst =
       match lst with
      | [] -> false
      | hd :: tl -> hd = elem || mem elem tl ;;

val mem : 'a -> 'a list -> bool = <fun>
─( 15:07:23 )─< command 101 >─────────────────────────────────{ counter: 0 }─
utop # let rec append lst1 lst2 =
       match lst1 with
       | [] -> lst2
       | hd :: tl -> hd :: append tl lst2;;

val append : 'a list -> 'a list -> 'a list = <fun>