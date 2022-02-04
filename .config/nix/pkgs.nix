#
# See https://nixos.wiki/wiki/FAQ/Pinning_Nixpkgs.
#
import (
  builtins.fetchGit {
    url = "https://github.com/NixOS/nixpkgs";
    # `git ls-remote https://github.com/NixOS/nixpkgs-channels nixpkgs-unstable`
    rev = "362be9608c3e0dc5216e9d1d5f5c1a5643b7f7b1";
  }
)
