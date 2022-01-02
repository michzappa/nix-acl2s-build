{
  description = "preliminary acl2s build";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = nixpkgs.legacyPackages.${system};
          acl2s = pkgs.callPackage ./acl2s.nix {};

          buildInputs = with pkgs; [ sbcl openssl libressl z3 gcc pkg-config zlib clang ];
      in
        {
          devShell = pkgs.mkShell {
            buildInputs = with pkgs; [
              sbcl
              openssl
              z3
              z3.lib
              gcc
              pkg-config
              zlib
              clang
              # for presentation
              texlive.combined.scheme-full
            ];
            LD_LIBRARY_PATH = "${pkgs.openssl}:${pkgs.stdenv.cc.cc.lib}:${pkgs.stdenv.cc.cc.lib}/lib:${pkgs.z3.lib}/lib:${pkgs.z3.lib}:$LD_LIBRARY_PATH";
          };
        }
    );
}
