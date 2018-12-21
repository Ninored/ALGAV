open Type
open Stdint

(* Module cle entiers *)
module Cleint : (Cle_type with type t = int) = struct
  type t = int
  let inf a b = a < b
  let eg a b = a = b
  let of_string_pair (a, b) =
    int_of_string a + int_of_string b
  let none = -1
  let to_string t = string_of_int t
end

(* Module cle 128 bit*)
module Cle128 : (Cle_type with type t = (Uint64.t * Uint64.t) option ) =
  struct
    type t = (Uint64.t * Uint64.t) option

    let inf a b =
      match a, b with
      | Some (ha, la) , Some (hb, lb) ->
      ha < hb ||
      ha = hb && la < lb
      | _, _ -> false

    let eg a b =
      match a, b with
      | Some (ha, la), Some (hb, lb) ->
      ha = hb &&
      la = lb
      | _, _ -> false

    let of_string_pair (a, b) =
      Some (Uint64.of_string a, Uint64.of_string b)

    let none = None

    let to_string = function
      | Some (h, l) ->
      Uint64.to_string h ^ Uint64.to_string l
      | _ -> "None"

  end
