
type t
(** Type d'une clé *)

val of_string_pair : (string * string) -> t
(** Conversion d'une string en clé *)

val to_int_pair : t -> (int * int)
(** Conversion d'une clé en paire d'int *)

val to_string_pair : t -> (string * string)
(** Conversion d'une clé en paire de string *)

val inf : t -> t -> bool
(** Teste d'infériorité entre deux clé *)

val eg : t -> t -> bool
(** Teste d'égalité entre deux clé *)
