open Stdint

type t = (Uint64.t * Uint64.t)

let of_string_pair (a, b) =
  (
    Uint64.of_string a,
    Uint64.of_string b
  )

let to_int_pair (a, b) =
  (
    Uint64.to_int a,
    Uint64.to_int b
  )

let to_string_pair (a, b) =
  (
    Uint64.to_string a,
    Uint64.to_string b
  )

let inf a b =
  (snd a) = (snd b) && (snd a) < (snd b)
  || (fst a) < (fst b)

let eg a b =
  (Uint64.sub (fst a) (fst b)) = Uint64.zero &&
  (Uint64.sub (snd a) (snd b)) = Uint64.zero
