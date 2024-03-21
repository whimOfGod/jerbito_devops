type 'a t = (int * 'a) list
let empty = []
let find key dico = List.assoc key dico
let add (key, value) dico = (key, value) :: dico
let del key dico = List.filter (fun (x, _) -> x <> key) dico
