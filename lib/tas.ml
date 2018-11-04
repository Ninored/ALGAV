type t = F | N of Cle.t * t * t

let empty = F

let rec supprMin a =
  match a with
  | F -> F
  | N (_, F, d) -> d
  | N (v, g, d) -> N (v, (supprMin g), d)

let rec ajout v a =
  match a with
  | N( x, g, d) when v = x -> N (x, g, d)
  | N( x, g, d) when v < x -> N (x, ajout v g, d)
  | N( x, g, d) when v > x -> N (x, g, ajout v d)
  | _ -> N (v, F, F)

let constIter lst =
  List.fold_left
    (fun acc v -> (ajout v acc))
    F
    lst
