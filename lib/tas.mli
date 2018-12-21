module Tas_arbre (C: Type.Cle_type) :
  (Type.Tas_type with type c = C.t)

module Tas_tableau(C: Type.Cle_type):
  (Type.Tas_type with type c = C.t)
