let carre n = n * n ;;

let f () () () () = ();;
let f (pint_int 1 ) (pint_int 2 ) (pint_int 3 ) (pint_int 4 ) = () ;;


let carre n = print_endline " hello, world ! " ;
 n * n ;;
 (* cas d'utilisation *)
carre 5 + carre 7 ;;

let print_int_option = function 
| Some n -> print_int n 
| None -> print_endline "None";;

type json =
| Null
| Bool of bool
| Int of int
| Float of float
| String of string
| Array of json list
| Object of (string * json) list ;;


let rec print_json_value = function
| Null -> print_endline "null"
| Bool b -> print_endline (if b then "true" else "false")
| Int n -> print_int n; print_newline ()
| Float f -> print_float f; print_newline ()
| String s -> print_endline s
| Array lst ->
    print_endline "["; 
    List.iter (fun json -> print_json_value json; print_string ", ") lst; 
    print_endline "]"
| Object lst ->
    print_endline "{"; 
    List.iter (fun (key, json) -> print_string (key ^ ": "); print_json_value json) lst; 
    print_endline "}" ;;
(*  *)


