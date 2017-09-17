{nixpkgs ? import <nixpkgs> { }, ghc ? nixpkgs.ghc}:

with nixpkgs;

let ghc = "ghc802"; in haskell.packages.${ghc}.callPackage ./volbar.nix { }
