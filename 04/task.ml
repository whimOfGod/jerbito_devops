       let x = 10 in let y = "Hello" in
       let my_pair = (x, y) in
       let first_element = fst my_pair in
       let second_element = snd my_pair in
       print_int first_element;
       print_string second_element; ;;

       let first a = match a with (x,_) -> x ;;
       let first (x,_) = x ;;
       let second (y,_) = y;;


       (* Exercice 3 : suffixe et préfixe *)

       let suffix_prefix str c =
          let index = String.index_opt str c in
          match index with  | None -> (None, None)
            | Some i ->
            let prefix = if i > 0 then Some str.[i - 1]                else None in
            let suffix = if i < String.length str - 1                  then Some str.[i + 1] else None in
            (prefix, suffix) ;;

          (* Cas d'utilisation *)
          suffix_prefix "manone" 'n';;

          (* Deuxième méthed  *)

          let suffixprefix str c =
          let mot_sans_c = String.split_on_char c str                in
          match mot_sans_c with
          | [] | [] -> (None, None) 
          | first :: _ ->
            let prev = 
              if first = "" then None 
              else Some first.[String.length first-1]                 in
            let rest = String.concat (String.make 1 c) (List.tl mot_sans_c) in
            let next = 
              if rest = "" then None 
              else Some rest.[0] in
            (prev, next) ;;


          (* d'Exercice sur les suffixes et les préfixe *)

  let split_on_char c s =
   let rec split_acc acc curr = function
       | -1 -> List.rev curr :: acc
       | i ->
         if s.[i] = c then
         split_acc (List.rev curr :: acc) [] (i -1)
           else
         split_acc acc (s.[i] :: curr) (i - 1)
           in
         split_acc [] [] (String.length s - 1) ;;

       (* cas d'utilisation  *)

       split_on_char 'l' "libellule" ;;


  (* Exercice zip and unzip *)
  
  (* zip *)
    let rec zip first_list second_list =
      match first_list, second_list with
      | [], [] -> []
      | [], _ | _, [] -> raise (Invalid_argument "Listes de taille différente")
      | hd1::tl1, hd2::tl2 -> (hd1, hd2) :: zip tl1 tl2 ;;
  (* cas d'utilisation *)
  zip [1;2;3] [4;5;6];;

  (* unzip *)
    let rec unzip list_given =
      match list_given with
        | [] -> ([], [])
        | (x, y)::tl ->
          let xs, ys = unzip tl in
          (x::xs, y::ys) ;;
  (* cas d'utilisation *)
    

  
  