type 'a t
val empty : 'a t
val is_empty : 'a t -> bool
val hd : 'a t -> 'a
val snoc : 'a -> 'a t -> 'a t
val tl : 'a t -> 'a t
val uncons : 'a t -> ('a * 'a t) option
val of_list : 'a list -> 'a t
val to_list : 'a t -> 'a list
val equal : 'a t -> 'a t -> bool
val length : 'a t -> int
val rev : 'a t -> 'a t
val append : 'a t -> 'a t -> 'a t
val concat : 'a t t -> 'a t
val filter : ('a -> bool) -> 'a t -> 'a t
val map : ('a -> 'b) -> 'a t -> 'b t
val concat_map : ('a -> 'b t) -> 'a t -> 'b t
val fold : ('b -> 'a -> 'b) -> 'b -> 'a t -> 'b
