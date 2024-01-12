{
  description = "NextJS development environment";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; };
  in
  {
    devShells."${system}".default = pkgs.mkShell {
      packages = with pkgs; [
        nodejs # For neovim's LSP (Remove it if you're not using neovim)
      ];

      shellHook = ''
        echo "NextJS's development template env was set successfully"
        echo "`${pkgs.nodejs}/bin/node --version`"
      '';
    };
  };
}
