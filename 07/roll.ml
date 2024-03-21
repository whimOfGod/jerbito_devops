type 'a t = 'a * 'a list

let empty = []

let unit x = (x, empty)
let cons x (y, u) = x, y :: u
let hd (x, _) = x
let tl (_, u) = match u with
  | [] -> failwith "tl"
  | x :: u -> (x, u)
let length (_, u) = 1 + List.length u 
