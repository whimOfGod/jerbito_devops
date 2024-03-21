type 'a queue = {
  front : 'a list;
  rear_rev : 'a list
}

let empty = { front = []; rear_rev = [] }

let is_empty q = q.front = []

let hd q = List.hd q.front

let check = function (* private *)
| { front = []; rear_rev } -> { front = List.rev rear_rev; rear_rev = [] }
| q -> q

let snoc x q = check { q with rear_rev = x :: q.rear_rev }

let tl q = check { q with front = List.tl q.front }

let uncons = function
| { front = x :: front; _ } as q -> Some (x, { q with front })
| _ -> None

let rec of_list q = function
| [] -> q
| x :: u -> of_list (snoc x q) u

let of_list u = of_list empty u

let rec to_list q = if is_empty q then [] else hd q :: to_list (tl q)

let rec equal q1 q2 = match uncons q1, uncons q2 with
| None, None -> true
| Some (hd1, tl1), Some (hd2, tl2) -> hd1 = hd2 && equal tl1 tl2
| _ -> false
