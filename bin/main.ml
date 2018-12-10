open Printf

module Cle = Lib.Cle.Cle128
module Loader = Lib.Tools.Loader(Cle)
module Tas = Lib.Tas.Tas_arbre(Cle)

let file_to_list_cle filename =
  fun () -> Loader.load_file filename


let create_tas_arbre lst =
  Tas.constIter lst


let () =
  if Array.length Sys.argv = 1 then
    failwith "Error no file specified"
  else
    printf "Opening %s: "  Sys.argv.(1);
    let filename = Sys.argv.(1) in
    let lst = Loader.load_file filename in
    let _ = (Lib.Tools.time_fun (fun () -> create_tas_arbre lst) ) in
    print_string "\n"
