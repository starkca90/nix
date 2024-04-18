{
  description = "Nix Flake  for a shell environment with nodejs";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { nixpkgs, flake-utils, ... }:
   flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
        };

        buildNodeJs = pkgs.callPackage "${nixpkgs}/pkgs/development/web/nodejs/nodejs.nix" {
          openssl = pkgs.openssl;
          python = pkgs.python3;
          libuv = pkgs.libuv;
          zlib = pkgs.zlib;
          icu = pkgs.icu;
        };

        nodejs = buildNodeJs {
          enableNpm = true;
          version = "20.11.1";
          sha256 = "sha256-d4E+2/P38W0tNdM1NEPe5OYdXuhNnjE4x1OKPAylIJ4=";
          patches = [
            "${nixpkgs}/pkgs/development/web/nodejs/revert-arm64-pointer-auth.patch"
            "${nixpkgs}/pkgs/development/web/nodejs/disable-darwin-v8-system-instrumentation-node19.patch"
            "${nixpkgs}/pkgs/development/web/nodejs/bypass-darwin-xcrun-node16.patch"
            "${nixpkgs}/pkgs/development/web/nodejs/node-npm-build-npm-package-logic.patch"
  ];
        };
      in rec {
        flakedPkgs = pkgs;

        # enables use of `nix shell`
        devShell = pkgs.mkShell {
          # add things you want in your shell here
          buildInputs = with pkgs; [
            nodejs_20
          ];
        };
      }
    );
}
