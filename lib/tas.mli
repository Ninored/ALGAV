(**
 * Définition du fichier de comparaison d'entiers 128 bits
 **)


type t
(** Le type t d'un tas*)

val empty: t

val supprMin : t -> t
(** Suppression du minimum dans un tas *)

val ajout : Cle.t -> t -> t
(** Ajout d'une valeur au tas *)

val constIter : Cle.t list -> t
