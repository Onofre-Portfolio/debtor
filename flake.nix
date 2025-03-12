{
  description = "Debtor Shell";

 inputs = {
    #nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, ... }: 
    flake-utils.lib.eachSystem [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ] (system: let
      pkgs = import nixpkgs { inherit system; };
      ghc = "ghc984";
      haskellPackages = pkgs.haskell.packages.${ghc};
    in
    {
      devShell = haskellPackages.shellFor {
        packages = p: [];  # Add project packages if needed
        buildInputs = with haskellPackages; [
          cabal-install
          hlint
          haskell-language-server
        ];
        withHoogle = true;
      };
    });
}
