#
# See https://nixos.wiki/wiki/FAQ/Pinning_Nixpkgs.
#
import (
  builtins.fetchGit {
    # Descriptive name to make the store path easier to identify.
    name = "nixpkgs-unstable-2019-07-12";
    url = https://github.com/NixOS/nixpkgs-channels.git;
    # `git ls-remote https://github.com/NixOS/nixpkgs-channels nixpkgs-unstable`
    rev = "362be9608c3e0dc5216e9d1d5f5c1a5643b7f7b1";
  }
)
