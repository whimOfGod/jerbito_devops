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





(* EXERCICE 5 *))
utop # let rec decrement_list array_list =
 match array_list with
| [] -> []
| hd :: tl -> (hd - 1) :: decrement_list tl;;





(* EXERCICE 6 *) 
let liste_initiale = [3; 7; 10; 2; 5];;
val liste_initiale : int list = [3; 7; 10; 2; 5]

decrement_list liste_initiale ;;

       let rec rev lst =
       let rec rev_acc acc = function
       | [] -> acc
       | hd :: tl -> rev_acc (hd :: acc) tl
       in
       rev_acc [] lst;;

val rev : 'a list -> 'a list = <fun>

       let rec mem elem lst =
       match lst with
        | [] -> false
        | hd :: tl -> hd = elem || mem elem tl ;;
  
       let rec append lst1 lst2 =
       match lst1 with
         | [] -> lst2
         | hd :: tl -> hd :: append tl lst2;;

val append : 'a list -> 'a list -> 'a list = <fun>

(* QUELQUES MANUPULATION *) 

(* 
utop #  let last my_new_list =
       match List.rev my_new_list with
       | [] -> failwith "La liste est vide"
       | hd :: _ -> hd ;;
val last : 'a list -> 'a = <fun>
─( 10:07:38 )─< command 30 >──────────────────────────────────────────────{ counter: 0 }─
utop # last [5;4;9;8;4;1;5;4;9] ;;
- : int = 9
─( 10:12:52 )─< command 31 >──────────────────────────────────────────────{ counter: 0 }─
utop # let first_element_of_list = List.hd my_new_list ;;
val first_element_of_list : int = 1
─( 10:13:51 )─< command 32 >──────────────────────────────────────────────{ counter: 0 }─
utop # let reverse_element_of_list = List.rev my_new_list ;;
val reverse_element_of_list : int list = [8; 7; 6; 5; 4; 3; 2; 1]
─( 10:15:09 )─< command 33 >──────────────────────────────────────────────{ counter: 0 }─
utop # let last_element_of_list =  List.hd reverse_element_of_list;;
val last_element_of_list : int = 8 *)