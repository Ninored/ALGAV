let file_to_listcle f =
  let line = ref [] in
  let chan = open_in f in
  try
    while true do
      line := input_line chan :: !line
    done; !line
  with End_of_file ->
    close_in chan;
    List.rev !line

let split_str s =
  let l = String.length s - 1 - 18 in
  (
    "0x" ^ String.sub s 2 16,
    "0x" ^ String.sub s 19 l
  )


let load_file filename =
  let lst = file_to_listcle filename in
  List.map
  (
    fun v ->
      Cle.of_string_pair (split_str v)
  )
  lst
