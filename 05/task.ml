type 'a queue = {
               front : 'a list;
               rear_rev : 'a list 
                             };;
type 'a queue = { front : 'a list; rear_rev : 'a list; }
let empty = {front = []; rear_rev = [] };;
val empty : 'a queue = {front = []; rear_rev = []}


let rec to_list q = if is_empty q then [] else hd q :: lo_list (tl q);;

type 'a queue = {
  front : 'a list;
  rear_rev : 'a list
}

let empty = { front = []; rear_rev = [] }

let is_empty q = q.front = []

let hd q = match q.front with
  | [] -> failwith "hd : queue vide"
  | x::_ -> x



let check = function 
  | { front = []; rear_rev } -> { front = List.rev rear_rev; rear_rev = [] }
  | q -> q

  

let snoc x q = check { q with rear_rev = x :: q.rear_rev }



let tl q = check { q with front = List.tl q.front }


let uncons = function
  | { front = x :: front; _ } as q -> Some (x, { q with front })
  | _ -> None




let rec to_list q =
  match uncons q with
  | Some (x, q') -> x :: to_list q'
  | None -> []




(* let of_list lst =
  let rec loop q = function
    | [] -> q
    | x::xs -> *)