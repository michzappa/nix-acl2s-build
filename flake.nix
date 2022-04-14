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
          buildInputs = with pkgs; [ sbcl openssl ];
          LD_LIBRARY_PATH =
            "${pkgs.openssl.out}/lib:$LD_LIBRARY_PATH";
        };
      });
}
