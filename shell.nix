{pkgs ? import <nixpkgs> {}}:
pkgs.mkShell {
  packages = with pkgs; [
    youplot
    duckdb
    gnumake
    curl
    gzip
  ];
}
