{ pkgs }:

{
  cpp-dev = (pkgs.mkShell.override { stdenv = pkgs.clangStdenv; }) {
    name = "Cpp development shell environment";

    packages = with pkgs; [ boost clang-tools vscode-extensions.vadimcn.vscode-lldb.adapter];
    packages = with pkgs; [ boost clang-tools vscode-extensions.vadimcn.vscode-lldb.adapter ];

    shellHook = ''
      echo "The cpp-dev env was set successfully";
      exec fish
    '';
  };
}
