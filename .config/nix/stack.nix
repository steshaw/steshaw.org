let
  pkgs = import ./pkgs.nix {};
  ghc = pkgs.haskell.compiler.ghc881;
in
#{ ghc ? pkgs.haskell.compiler.ghc881 } :
{ ghc } :

#
# Let's ignore the pkgs parmameter for now in case Stack is passing it
# in?
#
/*
let
  pinnedPkgs = import ./pkgs.nix {};
in {
  pkgs ? pinnedPkgs,
  ghc
}:
*/

/*
# XXX: ghc1 seems to be unused. No doubt an experiment.
let ghc1 = nur.repos.mpickering.ghc.mkGhc {
  url = "https://downloads.haskell.org/~ghc/7.10.3/ghc-7.10.3-i386-deb8-linux.tar.xz";
  hash = "sha256:08s5f7ly67hg2nxm9yj6p1yfysln5pz5jzmiv7a3w0sh96xqmp8z";
};
in
let ghc1 = nur.repos.mpickering.ghc.ghc801; in
*/
with pkgs;
haskell.lib.buildStackProject {
  name = "myEnv";
  buildInputs = [
    gmp
    ncurses
    zlib

    haskellPackages.alex
    haskellPackages.happy
  ] ++ lib.optionals stdenv.isDarwin (with darwin.apple_sdk.frameworks; [
    Cocoa
    CoreServices
  ]);
  shellHook = ''
  '';
  inherit ghc;
}
