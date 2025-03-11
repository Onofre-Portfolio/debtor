# shell.nix
{ compiler ? "ghc942" }:
let
  pkgs = import <nixpkgs> {};
  haskellPackages = pkgs.haskell.packages.${compiler}.override {
    overrides = self: super: {

    };
  };
in
haskellPackages.shellFor {
  packages = p: [];
  buildInputs = with haskellPackages; [
    cabal-install
    hlint
    haskell-language-server
  ];
  withHoogle = true;
}
