{ sources ? import ../nix/sources.nix { } }:
let
  pkgs = (import sources."haskell.nix" { }).pkgs-unstable;
  pkgsMusl = (import sources."haskell.nix" {
    system = "x86_64-linux";
  }).pkgs-unstable.pkgsCross.musl64;

  project = pkgsMusl.haskell-nix.project {
    compiler-nix-name = "ghc8107";
    src = pkgs.haskell-nix.haskellLib.cleanGit {
      name = "runtime";
      src = ./.;
    };
    modules = [{
      packages.runtime.dontStrip = false;
    }];
  };
  lambdaBinary = "${project.runtime.components.exes.runtime}/bin/runtime";
  runtime = pkgs.runCommand "haskell-exception-test-runtime" { } ''
    mkdir $out
    ${pkgs.upx}/bin/upx -9 -o $out/bootstrap ${lambdaBinary}
  '';
in
runtime
