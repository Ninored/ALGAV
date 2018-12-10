open Stdint

module Cleint : (Type.Cle_type with type t = int)
module Cle128 : (Type.Cle_type with type t = (Uint64.t * Uint64.t) option)
