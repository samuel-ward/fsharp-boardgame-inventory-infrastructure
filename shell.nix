{ pkgs ? import <nixpkgs> {} }:

with pkgs;

stdenv.mkDerivation {
  name = "games-shelf-infra-shell";
  buildInputs = [
    awscli
    terraform
  ];
}
