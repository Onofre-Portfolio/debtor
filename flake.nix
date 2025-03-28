{
  description = "Debtor Shell";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachSystem [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ] (system:
      let
        pkgs = import nixpkgs { inherit system; };
        ghc = "ghc984";
        haskellPackages = pkgs.haskell.packages.${ghc};
      in
      {
        devShells.default = haskellPackages.shellFor {
          packages = p: [];  # Add your project packages here
          buildInputs = with haskellPackages; [
            cabal-install
            hlint
            haskell-language-server
          ];
          withHoogle = true;
        };

        devShells.deploy = pkgs.mkShell {
          buildInputs = with haskellPackages; [
            cabal-install
          ];

          shellHook = ''
            cabal build
            cabal install --installdir=/Users/tiagoonofre/Learning/BIN --overwrite-policy=always
            exit
          '';
        };
      });
}
