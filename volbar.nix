{ mkDerivation, alsa-mixer, base, stdenv, text }:
mkDerivation {
  pname = "volbar";
  version = "0.1.0.0";
  src = ./.;
  isLibrary = false;
  isExecutable = true;
  executableHaskellDepends = [ alsa-mixer base text ];
  homepage = "https://github.com/apeyroux/volbar#readme";
  description = "xmonad volume bar";
  license = stdenv.lib.licenses.bsd3;
}
