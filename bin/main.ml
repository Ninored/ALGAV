open Printf

module Cle = Lib.Cle.Cle128
module Loader = Lib.Tools.Loader(Cle)
module Tasarb = Lib.Tas.Tas_arbre(Cle)
module Tastab = Lib.Tas.Tas_tableau(Cle)

module TesterTab = Lib.Test.Test_tas(Cle)(Tastab)(Loader)
module TesterArb = Lib.Test.Test_tas(Cle)(Tasarb)(Loader)

let file_to_list_cle filename =
  fun () -> Loader.load_file filename


let sort filename =
  List.sort (fun a b -> if Cle.inf a b then 1 else if Cle.eg a b then 0 else -1)
  (Loader.load_file filename)

let () =
  if Array.length Sys.argv = 1 then
failwith "Error no file specified"
  else
    printf "Opening %s: \n"  Sys.argv.(1);
    let filename = Sys.argv.(1) in
    let filename2 =
      if (Array.length Sys.argv) > 2 then Some Sys.argv.(2)
      else None in
    let _ = TesterArb.run filename filename2 in ();
    print_string "\n"
