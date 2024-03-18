let rec char_range lo hi =
  if lo > hi then ""
  else string_cons lo (char_range (char_succ lo) hi)

let rec char_range_rev_cat s lo hi =
  if lo > hi then s
  else char_range_rev_cat (string_cons hi s) lo (char_succ hi)

let char_range_rev lo hi =
  let result = char_range_rev_cat "" lo hi in
  String.sub result 0 (String.length result - 1)

let rec is_palindrome s =
  let len = String.length s in
  if len <= 1 then true
  else if s.[0] = s.[len - 1] then is_palindrome (String.sub s 1 (len - 2))
  else false

let rec pow x n =
  if n = 0 then 1
  else if n mod 2 = 0 then
    let half_pow = pow x (n / 2) in
    half_pow * half_pow
  else
    let half_pow = pow x (n / 2) in
    x * half_pow * half_pow

let rec div n d =
  if n < d then 0
  else 1 + div (n - d) d
