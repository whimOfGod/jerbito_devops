(* Plusieurs solutions sont proposées pour certains exercices. *)

(* Q1 *)
let last ll = List.rev ll |> List.hd

let last ll =
  match List.rev ll with [] -> failwith "Liste vide" | hd :: _ -> hd

(* Q2 *)
let swap ll =
  match ll with [] -> [] | _ :: [] -> ll | x :: y :: rest -> y :: x :: rest


let swap_n n ll =
  assert (n >= 0);
  match ll with
  | [] -> failwith "Liste trop courte"
  | head :: xs ->
    let rec aux n (acc, _) ll = match ll with
      | [] -> failwith "Liste trop courte"
      | x :: xs when n = 0 -> (List.rev (head :: acc) @ xs , Some x)
      | x :: xs -> aux (n-1) (x :: acc, None) xs
    in
    let list, yopt = aux (n-1) ([], None) xs in
    Option.get yopt :: list


(* Q3 *)
let repeat elt len = List.init len (fun _ -> elt)

(* Q4 *)
let range_i_j ii jj =
  if ii > jj then [] else List.init (jj - ii + 1) (fun ind -> ind + ii)

(* Q5 *)
let rec decr_list ll =
  match ll with [] -> [] | x :: xs -> (x - 1) :: decr_list xs

(* Q6 *)
let rev ll =
  let rec aux acc ll =
    match ll with [] -> acc | x :: xs -> aux (x :: acc) xs
  in
  aux [] ll

let rec rev ll = match ll with x :: xs -> rev xs @ [ x ] | [] -> []
let rec append l1 l2 = match l1 with [] -> l2 | x :: xs -> x :: append xs l2

let rec append l1 l2 =
  match (l1, l2) with
  | _, [] -> l1
  | [], _ -> l2
  | x :: xs, _ -> x :: append xs l2

let rec mem elt l1 =
  match l1 with
  | [] -> false
  | x :: _ when x = elt -> true
  | _ :: xs -> mem elt xs

let rec repeat elt n = match n with 0 -> [] | _ -> elt :: repeat elt (n - 1)

(* Q7 *)
let rec flat ll = match ll with [] -> [] | l1 :: xs -> l1 @ flat xs

(* Q8 *)
let rec interpose elt ll =
  match ll with
  | [] | _ :: [] -> ll
  | x :: y :: rest -> x :: elt :: interpose elt (y :: rest)

(* Q9 *)
let rec stutter ll =
  match ll with [] -> [] | hd :: tail -> hd :: hd :: stutter tail

(* Q10 *)
let rec add_list l1 l2 =
  match (l1, l2) with
  | [], [] -> []
  | rest, [] | [], rest -> rest
  | x :: xs, y :: ys -> (x + y) :: add_list xs ys

(* Q11 *)
let rec remove_dup xs =
  match xs with
  | [] | _ :: [] -> xs
  | x :: y :: xs when x = y -> remove_dup (y :: xs)
  | x :: xs -> x :: remove_dup xs

(* Q12 *)
let rec is_sorted l =
  match l with
  | [] | [ _ ] -> true
  | x :: y :: xs when x <= y -> is_sorted (y :: xs)
  | _ -> false

(* Q13 *)
let incr_list ll = List.map (fun elt -> elt + 1) ll

(* Q14 *)
let only_less_then_5 ll = List.filter (fun elt -> elt < 5) ll

(* Q15 *)
let rev ll = List.fold_left (fun acc elt -> elt :: acc) [] ll
let append ll1 ll2 = List.fold_right (fun elt acc -> elt :: acc) ll1 ll2

(* Q16 *)
let max ll =
  match ll with
  | [] -> failwith "Liste vide"
  | hd :: tail ->
      List.fold_left (fun max elt -> if elt > max then elt else max) hd tail

(* Q17 *)
let is_sorted ll =
  match ll with
  | [] -> true
  | hd :: xs ->
      List.fold_left
        (fun (prev, acc) elt ->
          if prev <= elt then (elt, acc) else (elt, false && acc))
        (hd, true) xs
      |> snd

(* Q18 *)
let remove_dup ll =
  match ll with
  | [] -> []
  | hd :: xs ->
      List.fold_right
        (fun elt (prev, acc) ->
          if prev = elt then (elt, acc) else (elt, elt :: acc))
        xs (hd, [])
      |> snd
