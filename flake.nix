{
  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        packageName = "unity";

        unity = pkgs.stdenv.mkDerivation {
          name = packageName;
          src = ./.;
          installPhase = ''
            mkdir -p $out
            cp -rv $src/* $out
          '';
        };
      in
      {
        packages.${system} = unity;
        defaultPackage = self.packages.${system};
        packages.default = unity;
      }
    );
}

