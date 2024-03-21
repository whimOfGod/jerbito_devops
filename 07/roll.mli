type 'a t

val unit : 'a -> 'a t
val cons : 'a -> 'a t -> 'a t
val hd : 'a t -> 'a
val tl : 'a t -> 'a t

val length : 'a t -> int