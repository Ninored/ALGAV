module type Cle_type =
  sig
    (* Type d'une cle *)
    type t

    (* Fonction d'inferiorité *)
    val inf : t -> t -> bool

    (* Fonction d'égalité *)
    val eg : t -> t -> bool

    (* Fonction de création d'une cle à partir d'une pair de string*)
    val of_string_pair: (string * string) -> t

    (* Function retournant une cle non présente *)
    val none: t

    (* Function de conversion vers string*)
    val to_string: t -> string

  end

module type Tas_type =
  sig
    (* Type d'un tas *)
    type t

    (* Type d'une clé *)
    type c

    (* Fonction de suppression du minimum *)
    val supprMin : t -> t

    (* Fonction d'ajout d'une clé dans un tas *)
    val ajout: c -> t -> t

    (* Fonction de creation de tas à partie d'une liste de clé *)
    val constIter : c list -> t

    (* Fonction d'union de deux tas *)
    val union : t -> t -> t

    (* Fonction de creation d'un singleton *)
    val singleton : c -> t

    (* Fonction d'affichage d'un tas *)
    val print_tas : t -> unit
  end

module type Loader_type =
  sig
    (* Type d'une clé *)
    type c

    (* Fonction de chargement d'un fichier de clé *)
    val load_file : string -> c list
  end

module type Tester_type =
  sig
    val run: string -> string option -> unit
end
