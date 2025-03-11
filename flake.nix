{
  description = "Debtor Shell";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";  

  outputs = { nixpkgs, ... }:
    let
      system = builtin.currentSystem;
      pkgs = import nixpkgs { inherit system; };
      haskellPackages = pkgs.haskell.packages.ghc944;  # Change GHC version if needed
    in
    {
      devShells.${system}.default = haskellPackages.shellFor {
        packages = p: [];  # Add project packages if needed
        buildInputs = with haskellPackages; [
          cabal-install
          hlint
          haskell-language-server
        ];
        withHoogle = true;
      };
    };
}

