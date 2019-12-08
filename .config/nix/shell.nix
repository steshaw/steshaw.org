let
  #
  # See
  #  https://nixos.wiki/wiki/FAQ/Pinning_Nixpkgs.
  #  https://vaibhavsagar.com/blog/2018/05/27/quick-easy-nixpkgs-pinning/
  #
  pinnedVersion = builtins.fromJSON (builtins.readFile ./.nixpkgs-version.json);
  pinnedPkgs = import (builtins.fetchGit {
    inherit (pinnedVersion) url rev;

    ref = "nixos-unstable";
  }) {};
in { pkgs ? pinnedPkgs }:
with pkgs; mkShell {
  buildInputs = [
    cacert
    emacs
    shellcheck
    stack
#    texlive.beamer # FIXME: broken.
    vim
  ];

  shellHook = ''
    source .config/environment
  '';
}
