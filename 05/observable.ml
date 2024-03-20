type 'a tstamp = { data : 'a; date : float; }

let tstamp_map f { data; date } = { data = f data; date }

let tstamp_join { data = { data = a ; date = s }; date = t } =
    { data = a; date = max s t }

let tstamp_dupe data = { data; date = data.date }

let tstamp_bind f u = u |> tstamp_map f |> tstamp_join

type 'a obs = 'a tstamp list

let obs_map f (s : 'a obs) : 'b obs = List.map (tstamp_map f) s

let list_last u = List.(hd (rev u))

let obs_concat (u : 'a obs) (v : 'a obs) = match u, v with
| [], [] -> []
| [], v -> v
| u, v ->
    let u_lst = (list_last u).date in
    let v_fst = (List.hd v).date in
    let delay = max 0.0 (u_lst -. v_fst) in
    u @ List.map (fun { data; date } -> { data; date = date +. delay } ) v

let obs_concat_list (u : 'a obs obs) : 'a obs =
    List.fold_left (fun a b -> obs_concat a b.data) [] u

let obs_concat_map f u = u |> obs_map f |> obs_concat_list

let rec obs_merge (u : 'a obs) (v : 'a obs) = match u, v with
| a :: u, b :: v ->
    if a.date < b.date then
        a :: obs_merge u (b :: v)
    else
        b :: obs_merge (a :: u) v
| [], v -> v
| u, [] -> u

let obs_merge_list (u : 'a obs obs) : 'a obs =
    List.fold_left (fun a b -> obs_merge a b.data) [] u

let obs_merge_map f u = u |> obs_map f |> obs_merge_list

let obs_switch (u : 'a obs) (v : 'a obs) = match v with
| [] -> u
| fst :: v -> List.filter (fun e -> e.date <= fst.date) u @ v

let obs_switch_list u = List.fold_left (fun a b -> obs_switch a b.data) [] u

let obs_switch_map f u = u |> obs_map f |> obs_switch_list

let obs_exhaust (u : 'a obs) (v : 'a obs) = match u with
| [] -> v
| u ->
  let lst = list_last u in
  u @ List.filter (fun e -> e.date >= lst.date) v

let obs_exhaust_list u = List.fold_left (fun a b -> obs_exhaust a b.data) [] u

let obs_exhaust_map f u = u |> obs_map f |> obs_exhaust_list

let obs_reduce f (u : 'a obs obs) = List.fold_left (fun a b -> f a b.data) ([] : 'a obs) u

let obs_concat_map f u = u |> obs_map f |> obs_reduce obs_concat
let obs_merge_map f u = u |> obs_map f |> obs_reduce obs_merge
let obs_switch_map f u = u |> obs_map f |> obs_reduce obs_switch
let obs_exhaust_map f u = u |> obs_map f |> obs_reduce obs_exhaust
