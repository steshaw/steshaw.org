{ ghc }:

let pkgs = import <nixpkgs> {};
in with pkgs;

let ghc1 = nur.repos.mpickering.ghc.mkGhc {
  url = "https://downloads.haskell.org/~ghc/7.10.3/ghc-7.10.3-i386-deb8-linux.tar.xz";
  hash = "sha256:08s5f7ly67hg2nxm9yj6p1yfysln5pz5jzmiv7a3w0sh96xqmp8z";
};
in
let ghc1 = nur.repos.mpickering.ghc.ghc801;
in haskell.lib.buildStackProject {
  name = "myEnv";
  buildInputs = [
    gmp
    ncurses
    zlib

    haskellPackages.alex
    haskellPackages.happy
  ];
  shellHook = ''
  '';
  inherit ghc;
}
