# FideOS nix flake for reproducible and consistent development environments
# Provides necessary tools and language servers for developing FideOS
# Supports x86_64 and aarch64 CPU architectures
# To enter the development environment, run:
#   nix develop
# This will launch an isolated shell with all specified tools ready for
# coding, building, and testing FideOS.



{
  description = "FideOS development flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = inputs@{ nixpkgs, flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" "aarch64-linux" ];

      perSystem = { system, ... }:
        let
          pkgs = import nixpkgs { inherit system; };
        in {
          devShells.default = pkgs.mkShell {
            buildInputs = with pkgs; [
              rustc
              cargo
              gcc
              clang
              clang-tools
              cmake
              ninja
              gnumake
              bashInteractive
              python3
              python3Packages.python-lsp-server
              git
              vim
              tmux
              curl
              wget
              unzip
              zip
              p7zip
              jq
              shellcheck
              coreutils
              util-linux
              pkgconfig
              openssl
              openssh
              qemu_kvm 
            ];

            shellHook = ''
              echo "Welcome to FideOS development environment!"
              export EDITOR=vim
              export TERM=xterm-256color
            '';
          };
        };
    };
}
