{
  description = "A collection of development environments and templates";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }: rec
  {
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
      };
      inherit (import ./environments/envs.nix { inherit pkgs; }) cpp-dev; 
      templatesDIR = "templates";

      templates = {
        react-native = {
          path = ./${templatesDIR}/ReactNative;
          description = "A React Native development environment with emulator included";
        };

        cpp-dev = {
          path = ./${templatesDIR}/Cpp;
          description = "A Cpp development environment with boost libraries included";
        };
      };
    };
}
