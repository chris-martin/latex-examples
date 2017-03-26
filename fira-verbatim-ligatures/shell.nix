{ pkgs ? import <nixpkgs> {}, ghc ? null }:

let
  name = "latex-example-fira-verbatim-ligatures";

  inherit (pkgs) stdenv;
  inherit (stdenv) mkDerivation;

  tex = let inherit (pkgs) texlive; in texlive.combine {
    inherit (texlive) luatex scheme-medium fontspec;
  };

  fonts = mkDerivation {
    name = "fonts-for-${name}";
    unpackPhase = "true";
    installPhase = with pkgs; ''
      fonts="$out/share/fonts"
      mkdir -p "$fonts"
      ln -s "${fira-code}" "$fonts/fira-code"
    '';
  };

in

mkDerivation {
  inherit name;
  unpackPhase = "true";
  buildInputs = [ tex ];
  OSFONTDIR = "${fonts}/share/fonts";
}
