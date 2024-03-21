type 'a t = (int * 'a) list 

let empty = []
let find key dico = List.assoc key dico
let add ( key, values ) dico = (key, values)::dico 
let del key dico = List.filter ( fun (find_key,_) -> find_key <> key) dico 