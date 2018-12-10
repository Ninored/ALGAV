module type Cle_type =
  sig
    type t
    (* Type d'une cle *)

    val inf : t -> t -> bool
    (* Fonction d'inferiorité *)

    val eg : t -> t -> bool
    (* Fonction d'égalité *)

    val of_string_pair: (string * string) -> t
    (* Fonction de création d'une cle à partir d'une pair de string*)

    val none: t
    (* Function retournant une cle non présente *)

    val to_string: t -> string
    (* Function de conversion vers string*)

  end

module type Tas_type =
  sig
    type t
    type c
    val supprMin : t -> t
    val ajout: c -> t -> t
    val constIter : c list -> t
    val union : t -> t -> t
    val singleton : c -> t
    val print_tas : t -> unit
  end

module type Loader_type =
  sig
    type c
    val load_file : string -> c list
  end
