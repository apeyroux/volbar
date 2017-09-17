with (import <nixpkgs> {});

haskell.lib.buildStackProject {
  inherit ghc;
  name = "volbarEnv";
  buildInputs = [ stack haskellPackages.cabal2nix taglib zlib mp3info alsaLib ];
}
