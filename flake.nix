# SPDX-FileCopyrightText: 2020 Serokell <https://serokell.io>
#
# SPDX-License-Identifier: MPL-2.0

{
  description = "build Pandoc documents with Nix";

  nixConfig.flake-registry =
    "https://github.com/serokell/flake-registry/raw/master/flake-registry.json";

  outputs = { self, nixpkgs, flake-utils }:
    {

      overlay = final: prev: { mkDoc = final.callPackage ./mkDoc.nix { }; };

      templates.presentation-serokell = {
        description = "A typical Serokell-themed presentation, with minted for code highlighting, Google fonts, Serokell theme, speaker notes and some nice defaults";
        path = ./templates/presentation-serokell;
      };

    } // flake-utils.lib.eachDefaultSystem (system:
      let pkgs = nixpkgs.legacyPackages.${system};
      in {

        mkDoc = pkgs.callPackage ./mkDoc.nix { };

        checks = {
          reuse =
            pkgs.runCommand "reuse-lint" { nativeBuildInputs = [ pkgs.reuse ]; }
            "reuse --root ${./.} lint && touch $out";
          build-readme = self.mkDoc.${system} {
            name = "README.html";
            src = ./README.org;
            phases = [ "buildPhase" ];
            buildPhase = "pandoc --to html -o $out $src";
          };
        };
      });
}
