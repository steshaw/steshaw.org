{ nixpkgs ? import <nixpkgs> {}, compiler ? "default" }:

let

  inherit (nixpkgs) pkgs;

  f = { mkDerivation, aeson-pretty, base, bytestring, containers
      , filepath, hakyll, hjsmin, parsec, stdenv, text, time
      , time-locale-compat
      }:
      mkDerivation {
        pname = "steshaw-org";
        version = "0.1.0.0";
        src = ./.;
        isLibrary = false;
        isExecutable = true;
        executableHaskellDepends = [
          aeson-pretty base bytestring containers filepath hakyll hjsmin
          parsec text time time-locale-compat
        ];
        homepage = "http://steshaw.org";
        description = "Hakyll site builder for steshaw.org";
        license = stdenv.lib.licenses.bsd2;
      };

  haskellPackages = if compiler == "default"
                       then pkgs.haskell.packages.lts-5_15
                       else pkgs.haskell.packages.${compiler};

  drv = haskellPackages.callPackage f {};

in

  if pkgs.lib.inNixShell then drv.env else drv
