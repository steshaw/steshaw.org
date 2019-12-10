let
  pinnedPkgs = import ./pkgs.nix {};
in
{
  pkgs ? pinnedPkgs,
  enableDev ? false,
  enableTalks ? enableDev,
}:
  with pkgs;
  let
    optPkgs = enable: pkgs: if enable then pkgs else [];
    beamer = texlive.combine {
      inherit (texlive)
        scheme-medium

        beamer
        ;
    };
    devPkgs = optPkgs enableDev [
      emacs
      neovim
      shellcheck
    ];
    talksPkgs = optPkgs enableTalks [
        beamer
        docker
    ];
  in
    mkShell {
      buildInputs = [
        cabal2nix
        cacert
        perl
        stack
      ] ++ devPkgs ++ talksPkgs;

      shellHook = ''
        source .config/environment
      '';
    }
