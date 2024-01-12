{
  description = "Cpp development shell";
  
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }: 
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; };
  in
  {
    devShells."${system}".default = (pkgs.mkShell.override { stdenv = pkgs.clangStdenv; }) {
      packages = with pkgs; [
        boost
        clang-tools
        vscode-extensions.vadimcn.vscode-lldb.adapter
        nodejs # For neovim's LSP (Remove it if you're not using neovim)
      ];

      shellHook = ''
        echo "The cpp-dev template env was set successfully";
      '';
    };
  };
}
