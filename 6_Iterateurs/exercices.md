# Exercices sur les itérateurs

Devinez, à partir de chacun des types ci-dessous, ce que fait la fonction, et implémentez-là :

1. `('a -> 'b) -> 'a list -> 'b list`
2. `(int -> 'a -> 'b) -> 'a list -> 'b list`
3. `('acc -> 'a -> 'acc) -> 'acc -> 'a list -> 'acc`
4. `('a -> 'acc -> 'acc) -> 'a list -> 'acc -> 'acc`
5. `('a -> bool) -> 'a list -> 'a list`
6. `('a -> 'b option) -> 'a list -> 'b list`
7. `('acc -> 'a -> 'acc * 'b) -> 'acc -> 'a list -> 'acc * 'b list`
8. `('a -> 'b list) -> 'a list -> 'b list`
9. `'a option -> ('a -> 'b) -> 'b option`
10. `'a option -> ('a -> 'b option) -> 'b option`
11. `unit -> 'a list`
