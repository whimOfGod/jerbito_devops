module CharMap = Map.Make(Char)

let char_digit i = char_of_int (i + 48)
let init = List.init 10 (fun i -> char_digit i, 0) |> CharMap.of_list

let lead_digit n = (string_of_int n).[0]

let record_lead_digit dico n =
  let lead = lead_digit n in
  let prev_count = CharMap.find lead dico in
  let next_count = prev_count + 1 in
  CharMap.add lead next_count dico

let distrib n =
  List.init n Fun.id
  |> List.fold_left record_lead_digit init
  |> CharMap.to_list
  |> List.map (fun (c, count) -> (c, 100. *. float_of_int count /. float_of_int n))
  |> List.sort (fun (_, a) (_, b) -> compare b a)

let rec int_fold f x n = if n = 0 then x else int_fold f (f x (n - 1)) (n - 1)

let rec lead_digit' n = if n < 10 then n else lead_digit' (n / 10)

let record_lead_digit' dico n =
  let lead = char_digit (lead_digit' n) in
  let prev_count = CharMap.find lead dico in
  let next_count = prev_count + 1 in
  CharMap.add lead next_count dico

let distrib' n =
  n
  |> int_fold record_lead_digit' init
  |> CharMap.to_list
  |> List.map (fun (c, count) -> (c, 100. *. float_of_int count /. float_of_int n))
  |> List.sort (fun (_, a) (_, b) -> compare b a)
