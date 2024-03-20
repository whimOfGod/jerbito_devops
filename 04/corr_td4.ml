(* Q1 *)
let first (x, _) = x
let second (_, y) = y

(* Q2 *)
let sum (a, b) (c, d) = (a + c, b ^ d)

(**)
let suffix_prefix str c =
  let splitted = String.split_on_char c str in
  match splitted with
  | [] -> failwith "Liste vide"
  | x :: [] -> None, None
  | suf :: pre :: res -> (Some suf,
                          let sep = String.make 1 c in
                          Some (pre ^ sep ^ (String.concat sep res)))

let suffix_prefix str c =
  let splitted = String.split_on_char c str in
  match splitted with
  | [] -> failwith "Liste vide"
  | _ :: [] -> None, None
  | "" :: "" :: _ -> ( None, None)
  | suf :: "" :: _ -> (Some (String.get suf (String.length suf -1 )), None)
  | "" :: pre  :: _ -> (None, Some (String.get pre 0))
  | suf :: pre :: _ -> (Some (String.get suf (String.length suf -1 )), Some (String.get pre 0))

(* Q3 *)
let rec zip l1 l2 =
  match (l1, l2) with
  | [], [] -> []
  | [], _ | _, [] -> raise (Invalid_argument "Listes de taille différente")
  | x :: xs, y :: ys -> (x, y) :: zip xs ys

let rec unzip ll =
  match ll with
  | [] -> ([], [])
  | (x, y) :: rest ->
      let xs, ys = unzip rest in
      (x :: xs, y :: ys)

let unzip ll =
  let rec aux l1 l2 ll =
    match ll with
    | [] -> (List.rev l1, List.rev l2)
    | (a, b) :: xs -> aux (a :: l1) (b :: l2) xs
  in
  aux [] [] ll

(* Q4 *)

exception Empty

let rec min_max ll =
  match ll with
  | [] -> raise Empty
  | head :: _ ->
      List.fold_left
        (fun (min, max) elt ->
          if elt < min then (elt, max)
          else if elt > max then (min, elt)
          else (min, max))
        (head, head) ll

let min_max ll =
  let rec aux (min, max) = function
    | [] -> (min, max)
    | head :: tail ->
        aux
          (if head < min then (head, max)
           else if head > max then (min, head)
           else (min, max))
          tail
  in
  match ll with [] -> raise Empty | head :: tail -> aux (head, head) tail

let optimize inputs f =
  let precomputed = List.map (fun elt -> (elt, f elt)) inputs in
  fun x ->
    match List.assoc_opt x precomputed with None -> f x | Some res -> res

let rec fibo n = if n = 0 || n = 1 then 1 else fibo (n - 1) + fibo (n - 2)

let fibo' n =
  let rec aux ind prev1 prev2 =
    if ind = n then prev1 + prev2 else aux (ind + 1) prev2 (prev1 + prev2)
  in
  aux 2 1 1

let opti_fibo = optimize (List.init 40 Fun.id) fibo

(* Q5 *)

type subject = Math | English | History | Sport
type grade = int
type report = (subject * grade list) list

let add_subject subject (report : report) : report = (subject, []) :: report

exception Subject_not_found
exception No_grade of subject

let rec add_grade subject grade (report : report) : report =
  match report with
  | [] -> raise Subject_not_found
  | (sub, grades) :: rest when sub = subject -> (sub, grade :: grades) :: rest
  | x :: rest -> x :: add_grade subject grade rest

let rec get_grades subject (report : report) : grade list =
  match report with
  | [] -> raise Subject_not_found
  | (sub, grades) :: rest when sub = subject -> grades
  | _ :: rest -> get_grades subject rest

let rec get_best_grade subject (report:report) : grade =
  match report with
  | [] -> raise Subject_not_found
  | (sub, grades) :: rest when sub = subject -> (
      try min_max grades |> snd with Empty -> raise (No_grade English))
  | x :: rest -> get_best_grade subject rest

let rec get_best_grade_opt subject report =
  match report with
  | [] -> None
  | (sub, grades) :: rest when sub = subject -> (
      try
        let _, max = min_max grades in
        Some max
      with Empty -> None)
  | x :: rest -> get_best_grade_opt subject rest

let rec change_grades (cheat_function : int -> int) subject report =
  match report with
  | [] -> []
  | (sub, grades) :: rest when sub = subject ->
      let new_grades = List.map cheat_function grades in
      (sub, new_grades) :: rest
  | x :: rest -> x :: change_grades cheat_function subject rest

let rec compute_avg subject (report:report) : float =
  match report with
  | [] -> raise Subject_not_found
  | (sub, []) :: _ when sub = subject -> raise (No_grade English)
  | (sub, grades) :: _ when sub = subject ->
      let somme = List.fold_left (fun acc elt -> elt + acc) 0 grades in
      Float.of_int somme /. Float.of_int (List.length grades)
  | _ :: rest -> compute_avg subject rest

let get_best_grades_in subjects (report:report) =
  List.fold_left
    (fun acc subject ->
      try (subject, get_best_grade subject report) :: acc with
      | No_grade elt -> acc
      | Subject_not_found -> acc)
    [] subjects
