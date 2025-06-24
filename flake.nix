# FideOS nix flake for consistent and reproducible development environments
# Provides necessary tools and libraries for building, debugging, and testing the OS
# Supports both x86_64 and ARM64 architectures for cross-platform development
# Uses rust-overlay to provide up-to-date Rust toolchains with rust-analyzer and sources
# Includes common development utilities, build tools, networking and version control software
# Ensures environment variables are set for a smooth terminal and editor experience
# To enter the FideOS development environment, run:
#   nix develop
# This command will open an isolated shell with all specified tools and dependencies available.
# You can start coding, building, and testing your project immediately within this environment.



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
