{
  description = "acl2s build";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:NixOs/nixpkgs/nixpkgs-unstable";
  };

  outputs = { self, ... }@inputs:
    with inputs;
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = (import nixpkgs {
          inherit system;
          config = { allowUnfree = true; };
        });
      in {
        devShell = pkgs.mkShell {
          buildInputs = with pkgs;
            [
              sbcl
              # TODO might need more dependencies eventually
              # openssl
              # z3
              # z3.lib
              # gcc
              # pkg-config
              # zlib
              # clang
              # for presentation
              # texlive.combined.scheme-full
            ];
          # LD_LIBRARY_PATH =
          # "${pkgs.openssl}:${pkgs.stdenv.cc.cc.lib}:${pkgs.stdenv.cc.cc.lib}/lib:${pkgs.z3.lib}/lib:${pkgs.z3.lib}:$LD_LIBRARY_PATH";
        };
      });
}
