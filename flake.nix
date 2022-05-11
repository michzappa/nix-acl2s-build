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
        });
      in
      {
        devShell = pkgs.mkShell {
          buildInputs = with pkgs; [ sbcl openssl parallel ];
          LD_LIBRARY_PATH = "${pkgs.openssl.out}/lib";
          shellHook = ''
            export PATH=$PWD/bin:$PATH
            export ACL2_SYSTEM_BOOKS=$PWD/acl2/books
            export ACL2S_SCRIPTS=$PWD/scripts
            export ACL2_LISP=sbcl
            export ACL2S_NUM_JOBS=8
          '';
        };
      });
}
