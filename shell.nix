with (import <nixpkgs> {});
let
    love = stdenv.mkDerivation rec {
    name = "love-${version}";
    version = "11.5";
    src = fetchurl {
      url = "https://github.com/love2d/love/releases/download/${version}/love-${version}-macos.zip";
      sha256 = "sha256-Z5W7OhZWr2ov3+dB4VB4e0gYhtOigDJ6Jho/3e1YaRM";
    };
    buildInputs = [ unzip ];
    phases = [ "installPhase" ];
    installPhase = ''
      mkdir -p $out/bin
      unzip $src -d $out/bin
      ln -s $out/bin/love.app/Contents/MacOS/love $out/bin/love
    '';
  };
in
mkShell {
  buildInputs = [
    fennel
    fnlfmt
    lua5_4
    love
  ];
}
