# ALGAV Project

## Installation

Il faut installer `opam` puis switcher sur le contexte `4.06.1`:

```sh
opam switch 4.06.1
```

Ensuite il faut install les modules pratiques de compilation et pour le REPL:

- dune
- utop

```sh
opam install dune utop
```

Commande pour lancer le REPL avec nos modules compilés:
```sh
dune utop lib
```

Dans le utop pour charger un fichier `ml` avec les types et autre pour tester:

```ocaml
use "lib/tas.ml"
```

## Organisation des dossiers

- `Lib` contient toutes les libraries
- `Bin` sont nos fichiers main
