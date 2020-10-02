# SPDX-FileCopyrightText: 2020 Serokell <https://serokell.io>
#
# SPDX-License-Identifier: MPL-2.0

{
  description = "build Pandoc documents with Nix";

  inputs.nixpkgs.url = "github:serokell/nixpkgs";

  outputs = { self, nixpkgs }: {

    overlay = final: prev: { mkDoc = final.callPackage ./mkDoc.nix { }; };

    mkDoc = builtins.mapAttrs (system: pkgs: pkgs.callPackage ./mkDoc.nix { })
      nixpkgs.legacyPackages;

    checks = builtins.mapAttrs (system: pkgs: {
      reuse =
        pkgs.runCommand "reuse-lint" { nativeBuildInputs = [ pkgs.reuse ]; }
        "reuse --root ${./.} lint && touch $out";
      build-readme = self.mkDoc.${system} {
        name = "README.html";
        src = ./README.org;
        phases = [ "buildPhase" ];
        buildPhase = "pandoc --to html -o $out $src";
      };
    }) nixpkgs.legacyPackages;
  };
}
