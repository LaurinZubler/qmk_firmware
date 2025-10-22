# run with 'nix develop'
{
  description = "QMK development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      pkgs = import nixpkgs { system = "x86_64-linux"; };
    in {
      devShells.x86_64-linux.default = pkgs.mkShell {
        name = "qmk-env";

        buildInputs = with pkgs; [
          qmk
          python3
          dfu-programmer
          dfu-util
          avrdude
          gcc
          gnumake
          gcc-arm-embedded
        ];

        shellHook = ''
          echo "🧠 QMK firmware environment ready."
          qmk config user.keyboard=crkbd/rev4_1/standard
          qmk config user.keymap=LaurinZubler
        '';
      };
    };
}

