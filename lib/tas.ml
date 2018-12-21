open Type

module Tas_arbre (C: Cle_type) :
  (Tas_type with type c = C.t) =
  struct

    (* Type d'une clé *)
    type c = C.t

    (* Type d'un tas arbre
     * F -> Feuille
     * N -> arbre gauche * clé * arbre droit * rang
     *)
    type t =
      | F
      | N of t * C.t * t * int

    (* Fonction retournant le rang d'un noeud *)
    let rank = function
      | F -> 0
      | N (_, _, _, r) -> r

    (* Fonction de création d'un noeud *)
    let singleton k = N(F, k, F, 1)

    (* Fonction d'union de deux tas *)
    let rec union a b =
      match a,b with
      | F, t | t, F -> t
      | N (l, k1, r, _), N (_, k2, _, _) ->
          if C.inf k2 k1 then union b a
          else
            let merged = union r b in
            let rank_l = rank l and rank_r = rank merged in
            if rank_l >= rank_r then
              N (l, k1, merged, rank_r+1)
            else
              N (merged, k1, l, rank_l+1)

    (* Fonction de suppression du Minimum *)
    let supprMin = function
      | F -> failwith "Le tas est vide"
      | N (g, _, d, _) -> union g d

    (* Fonction d'ajout d'une cle dans un tas *)
    let ajout k t = union (singleton k) t

    (* Fonction de création à partir d'une liste *)
    let constIter lst =
      List.fold_left
        (fun acc v -> union acc (singleton v))
        F
        lst

    let print_tas t =
      let rec aux b depth =
        match b with
        | F -> ()
        | N(g, k, d, r) ->
            aux g (depth+1);
            print_string ( string_of_int depth ^ " :(" ^ C.to_string k ^ "[" ^
            string_of_int r ^ "])\n");
            aux d (depth+1);
      in
      aux t 0
  end

  module Tas_tableau ( C: Cle_type ):
    (Tas_type with type c = C.t) =
    struct

      (* Type d'une clé *)
      type c = C.t

      (* Type d'un tas tableau *)
      type t = {
        mutable t: c array;
        mutable length: int
      }

      (* Fonction d'ajout d'une cle dans un tas *)
      let ajout k t =
        let tas = if (t.length + 1) >= Array.length t.t then
            let tmp = Array.make (t.length*2) C.none in
            Array.blit t.t 0 tmp 0 t.length; tmp
          else
            t.t
        in
        let rec calcul_place b i =
          let pere = (i-1)/2 in
          if ( C.inf k (Array.get b pere)) && (i > 0) then
            let _ = Array.set b i (Array.get b pere) in
            calcul_place b pere
          else
            i
        in
        let place = calcul_place tas t.length in
        t.length <- (t.length +1);
        Array.set t.t place k;
        { t = tas; length = t.length}

      (* Creation d'un seule element*)
      let singleton c = {t = Array.make 10 c ; length = 1}

      (* Fonction de suppression du minimum *)
      let supprMin t =
        (* On positionne le dernière element en haut du tas *)
        Array.set t.t 0 (Array.get t.t (t.length - 1));
        Array.set t.t (t.length-1) C.none;

        (* On le fait descendre *)
        let descendre v i =
          let gauche = (i*2) + 1 and droit = (i*2) + 2 in
          if C.inf (Array.get t.t gauche) (Array.get t.t i) then
            let fils = Array.get t.t gauche in
            Array.set t.t gauche v;
            Array.set t.t i fils;
          else
            let fils = Array.get t.t gauche in
            Array.set t.t droit v;
            Array.set t.t i fils;
        in
        descendre (Array.get t.t 0) 0;
        t.length <- t.length - 1;
        t

      (* Fonction d'union de deux tas *)
      let union a b =
        let out = { t = Array.make (a.length + b.length) C.none; length = a.length } in
        Array.blit a.t 0 out.t 0 a.length;
        Array.iter ( fun x -> let _ = ajout x out in () ) b.t;
        out

      (* Fonction de création d'un tas à partir d'une liste *)
      let constIter lst =
        let tas = {t = (Array.make (List.length lst) C.none); length= 0} in
        List.iter (fun v -> let _ = ajout v tas in ()) lst;
        tas

      (* Fonction d'affichage d'un tas *)
      let print_tas t =
        Array.iter (fun x -> print_string ( (C.to_string x) ^ ";\n")) t.t

  end
