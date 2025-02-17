{
  stdenv,
  cmake,
  pkgs,
}:
stdenv.mkDerivation rec {
  pname = "chatterino7";
  version = "7.4.3";
  src = pkgs.fetchFromGitHub {
    owner = "SevenTV";
    repo = pname;
    rev = "a86fa75325a5ff697f71dad0ba55a0c02674cf8d";
    sha256 = "sha256-I9c0KfNZC2gXDylDe2zMDa9PPQTRgxNwD5xcwsYVFZU=";
    fetchSubmodules = true;
  };
  nativeBuildInputs = with pkgs; [cmake pkg-config libsForQt5.qt5.wrapQtAppsHook];
  buildInputs = with pkgs; [libsForQt5.qt5.qtbase libsForQt5.qt5.qtsvg libsForQt5.qt5.qtmultimedia libsForQt5.qt5.qtimageformats libsForQt5.qt5.qttools boost openssl libsecret];
  configurationPhase = ''
    mkdir build && cd build
    cmake ..
  '';
  buildPhase = ''
    make
  '';
  installPhase =
    ''
      mkdir -p "$out/bin"
      mv "bin/chatterino" "$out/bin"
    ''
    + ''
      mkdir -p $out/share/icons/hicolor/256x256/apps
      cp $src/resources/icon.png $out/share/icons/hicolor/256x256/apps/chatterino.png
    '';
}
