let carre n =
  print_string "Appel de carre avec : ";
  print_int n;
  print_newline ();
  n * n

let resultat = carre 2 + carre 10
let helloworld () () = print_endline "Helloworld"
let f () () () = ()
let _ = f (print_int 1) (print_int 2) (print_int 3)

let print_int_option x =
  match x with
  | None -> print_endline "None"
  | Some x ->
      print_string "Some ";
      print_int x;
      print_newline ()

type json =
  | Null
  | Bool of bool
  | Int of int
  | Float of float
  | String of string
  | Array of json list
  | Object of (string * json) list

let rec json_print j =
  match j with
  | Null -> print_string "null"
  | Bool b -> print_string (string_of_bool b)
  | Int i -> print_int i
  | Float f -> print_float f
  | String s ->
      print_string "\"";
      print_string s;
      print_string "\""
  | Array a ->
      print_string "[";
      List.iter
        (fun j ->
          json_print j;
          print_string ",")
        a;
      print_string "]"
  | Object o ->
      print_string "{";
      List.iter
        (fun (cle, j) ->
          print_string cle;
          print_string " : ";
          json_print j;
          print_string ";")
        o;
      print_string "}"
