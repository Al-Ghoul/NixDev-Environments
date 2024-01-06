{
  description = "A collection of development environments and templates";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # https://github.com/nix-community/nixGL (for reference)
    nixgl.url = "github:guibou/nixGL";
  };

  outputs = { self, nixpkgs, nixgl }:
  let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
        config.android_sdk.accept_license = true;
        overlays = [ nixgl.overlay ];
      };
      templatesDIR = "templates";
    in { 
      inherit (import ./shells/index.nix { inherit pkgs nixgl; }) cpp-dev nextjs-dev laravel-dev django-dev reactnative-dev;

      templates = {
        react-native = {
          path = ./${templatesDIR}/ReactNative;
          description = "A React Native development environment with emulator included";
        };

        cpp-dev = {
          path = ./${templatesDIR}/Cpp;
          description = "A Cpp development environment with boost libraries included";
        };

        django-dev = {
          path = ./${templatesDIR}/Python/Django;
          description = "A Django development environment with python3.11 and other dependencies";
        };

        nextjs-dev = {
          path = ./${templatesDIR}/Javascript/NextJS;
          description = "A NextJS development environment";
        };
      };
    };
}
