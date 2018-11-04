open Printf
open Lib

let () =
  if Array.length Sys.argv = 1 then
    failwith "Error no file specified"
  else
    printf "Opening %s\n"  Sys.argv.(1);
    let filename = Sys.argv.(1) in
    List.iter
    (
      fun v ->
        let (a,b) = Cle.to_string_pair v in
        printf "%s | %s\n" a b
    )
    (Lib.Loader.load_file filename)

