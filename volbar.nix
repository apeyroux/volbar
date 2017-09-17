{ mkDerivation, alsa-mixer, base, shelly, stdenv, text }:
mkDerivation {
  pname = "volbar";
  version = "1.0.0.0";
  src = ./.;
  isLibrary = false;
  isExecutable = true;
  executableHaskellDepends = [ alsa-mixer base shelly text ];
  homepage = "https://github.com/apeyroux/volbar#readme";
  description = "xmonad volume bar";
  license = stdenv.lib.licenses.bsd3;
}
