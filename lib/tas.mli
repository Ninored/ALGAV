(**
 * Définition du fichier de comparaison d'entiers 128 bits
 **)


type arbre
(** Le type arbre d'un tas*)

val empty: arbre

val supprMin : arbre -> arbre
(** Suppression du minimum dans un tas *)

val ajout : int -> arbre -> arbre
(** Ajout d'une valeur au tas *)
