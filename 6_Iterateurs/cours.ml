let rec length l = match l with [] -> 0 | _ :: q -> 1 + length q
let grande_liste = List.init 100000000 (fun _ -> 0)
let t = length grande_liste

let length l =
  let rec length acc l =
    match l with [] -> acc | _ :: q -> length (acc + 1) q
  in
  length 0 l

let t = length grande_liste
