(* set up command 

cd  07
dune build
open M07
ls 

dune utop (* une fois en édition , ouvrir fichier *)
open M07.Roll ;;

#show Roll ;; (* pour vour le contenu ou les méthodes implémenté *)

unit 2 |> cons 3 |> cons 4 |> length ;; (* cas d'utilisation *)

let dico = empty |> add (1, "monocle") |> add (2, "monggomerry") |> add (3, " ah merde") |> find 2 ;; (* cas d'utilisation *)

let dico = empty |> add (1, "monocle") |> add (2, "monggomerry") |> add (3, " ah merde") ;; (* cas d'utilisation *)

find 2 dico ;; (* cas d'utilisation *)

let dico = empty |> add (1, "monocle") |> add (2, "monggomerry") |> add (3, " ah merde") |> del 1;; (* cas d'utilisation *)




 *)