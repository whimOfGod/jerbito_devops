type 'a t = int -> 'a
let empty _ = raise Not_found
let find key dico = dico key
let add (key, value) dico = fun x -> if key = x then value else dico x
let del key dico = fun x -> if key = x then raise Not_found else dico x
