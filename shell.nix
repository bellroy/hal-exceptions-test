{ sources ? import ./nix/sources.nix { } }:
let
  pkgs = (import sources."haskell.nix" { }).pkgs-unstable;
in
pkgs.mkShell {
  name = "haskell-exception-test";
  buildInputs = with pkgs; [ awscli2 nixpkgs-fmt nodejs ];
}
