# Expressions and Values

## Basic Data Type and Operations

### Integers
```ocaml
2 + 2
```

```ocaml
2 * 3 * 7
```

```ocaml
2 * (20 + 1)
```

### Floats
```ocaml
2.0 *. Float.pi
```

### Booleans

```ocaml
true
```

```ocaml
false
```

```ocaml
3 > 5
```

```ocaml
2 + 2 = 4
```

```ocaml
if 0 = 1 then 3 else 7
```

```ocaml
2 * if true then 3 else 7
```
### Strings

```ocaml
"Hello world!"
```

```ocaml
"Hello" ^ " " ^ "world!"
```

## Functions and Definitions

### Using Functions

#### Single Parameter

```ocaml
int_of_float
```

```ocaml
int_of_float 42.0
```

```ocaml
float_of_int
```

```ocaml
float_of_int 42
```

#### Multiple Parameters

Parentheses!

```ocaml
pow
```

```ocaml
pow 2.0 10.0
```

```ocaml
max (21 * 2) (int_of_string "713")
```

```ocaml
int_of_float (sqrt (float_of_int (int_of_string "81")))
```

```ocaml
"81" |> int_of_string |> float_of_int |> sqrt |> int_of_float
```

### Global Definitions

```ocaml
let a = 11
```

```ocaml
a * 4 - 1
```

### Defining Functions

```ocaml
let sq x = x * x
```

```ocaml
let float_sq x = x *. x
```

### Local Definitions

```ocaml
let d = 2 * 3 in d * 7
```

Check if `d` is unbound

#### Chaining
```ocaml
let d = 2 * 3 in
let e = d * 7 in
d * e
```

Check if `d` and `e` are unbound

#### Nesting
```ocaml
let d =
    let e = 2 * 3 in
    e * 5 in
  d * 7
```

Check if `d` and `e` are unbound

#### Inner Shadowing

```ocaml
let i = 21
```

```ocaml
let i = 7 in i * 2;;
```

Check the value of `i`

#### Same-Level Shadowing

```ocaml
let h = 2 * 3
```

```ocaml
let e = h * 7
```

```ocaml
let h = 7
```

Check the value of `e` hasn't changed.

#### Local Functions

```ocaml
let sq x = x * x in sq 7 * sq 7
```

Check that `sq` is not bound.

### Closures

```ocaml
let j = 6
```

```ocaml
let k x = x * j
```

```ocaml
k 7
```

```ocaml
let j = 7
```

```ocaml
k 7
```

Try to guess the output of `k 7` before evaluating it.
