type 'a t
val empty : 'a t
val find : int -> 'a t -> 'a
val add : int * 'a -> 'a t -> 'a t
val del : int -> 'a t -> 'a t