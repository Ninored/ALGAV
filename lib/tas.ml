open Type

module Tas_arbre (C: Cle_type) :
  (Tas_type with type c = C.t) =
  struct

    (* Type d'une clé *)
    type c = C.t

    (* Type d'un tas arbre *)
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
            print_string ( string_of_int depth ^ " :(" ^ C.to_string k ^ "[" ^
            string_of_int r ^ "])\n");
            aux g (depth+1);
            aux d (depth+1);
      in
      aux t 0
  end

  (*

  module Tas_tableau ( C: Cle_type ) : Tas_type =
    struct

      type c = C.t

      (* Type d'un tas tableau *)
      type t = {
        t: int array;
        mutable length: int
      }

      (* Fonction d'ajout d'une cle dans un tas *)
      let ajout k t =
        let rec calcul_place b i =
          let pere = (i-1)/2 in
          if (k < (Array.get b pere)) && (i > 0) then
            let _ = Array.set b i (Array.get b pere) in
            calcul_place b pere
          else
            i
        in
        let pltce = calcul_place t.t t.length in
        t.length <- (t.length +1);
        Array.set t.t pltce k;
        t


      (* Fonction de suppression du minimum *)
      let suppMin t =
        (* On positionne le dernière element en haut du tas *)
        Array.set t.t 0 (Array.get t.t (t.length - 1));
        Array.set t.t (t.length-1) (-1);

        (* On le fait descendre *)
        let rec descendre v i =
          let gauche = (i*2) + 1 and droit = (i*2) + 2 in
          if Array.get t.t gauche < Array.get t.t i then
            let fils = Array.get t.t gauche in
            Array.set t.t gauche v;
            Array.set t.t i fils;
          else if Array.get t.t droit < Array.get t.t i then
            let fils = Array.get t.t gauche in
            Array.set t.t droit v;
            Array.set t.t i fils;
        in
        descendre (Array.get t.t 0) 0;
        t.length <- t.length - 1

      (* Fonction d'union de deux tas *)
      let union a b =
        let out = { t = Array.make (a.length + b.length+10) C.none; length = a.length } in
        Array.blit a.t 0 out.t 0 a.length;
        Array.iter ( fun x -> let _ = ajout x out in () ) b.t;
        out

      let constIter lst =
        let out = Array.make (List.length lst) C.none in
        List.iter
        (fun v -> let _ = ajout v {t = out; length = List.length lst} in ())
        lst;
        out


  end
  *)
