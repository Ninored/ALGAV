
module Test_tas
  (C: Type.Cle_type)
  (T: Type.Tas_type with type c = C.t)
  (L: Type.Loader_type with type c = C.t)
  :
  Type.Tester_type =
  struct

    (* Creation d'un tas
     * - suppression de tous ses elements
     *)
    let test_supprMin lst nb =
      let tas = T.constIter lst in
      let times = ref [] and i = ref 0 in
      while !i < nb do
        let start = Unix.gettimeofday () in
        let _ = T.supprMin tas in
          let time = (Unix.gettimeofday () -. start ) in
            times := List.cons time !times;
        i := !i+1
      done;
      let moyenne = (List.fold_left (+.) 0.0 !times) /. (float_of_int (List.length !times)) in
      Printf.printf "SupprMin:\t%d\t%e\n" nb moyenne


    (* Ajout successif dans un tas *)
    let test_Ajout lst nb =
      let(_, times) = List.fold_left
      (fun (tas, times) x ->
        let t = Unix.gettimeofday () in
        let newtas = T.ajout x tas in
        (newtas, List.cons (Unix.gettimeofday () -. t) times)
      )
      ((T.singleton (List.hd lst)), [])
      (List.tl lst) in
      let moyenne = (List.fold_left (+.) 0.0 times) /. (float_of_int nb) in
      Printf.printf "Ajout:\t%d\t%e \n" nb moyenne

    (* Ajout a partir d'une liste *)
    let test_ConstIter lst nb =
      let t = Unix.gettimeofday () in
      let _ = T.constIter lst in
        Printf.printf "ConstIter:\t%d\t%e\n" nb (Unix.gettimeofday () -. t)

    (* Union de deux tas *)
    let test_Union lst lst2 nb nb2 =
      let
        tas1 = T.constIter lst and
        tas2 = T.constIter lst2
      in
        let t = Unix.gettimeofday () in
        let _ = T.union tas1 tas2 in
        Printf.printf "Union\t%d\t%e" (nb+nb2) (Unix.gettimeofday () -.t )

    let run filename1 filename2 =
      let _ = filename2 in
      let lst = L.load_file filename1 in
      let nb = List.length lst in
      test_supprMin lst nb;
      test_Ajout lst nb;
      test_ConstIter lst nb;
      match filename2 with
      | None -> ()
      | Some f2 ->
          let lst2 = L.load_file f2 in
          let nb2 = List.length lst2 in
          test_Union lst lst2 nb nb2;

      end
