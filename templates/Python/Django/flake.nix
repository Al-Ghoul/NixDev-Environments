{
  description = "Django development environment";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; };
    django = with pkgs.python3Packages; buildPythonPackage rec {
      pname = "Django";
      version = "5.0";
      src = fetchPypi {
        inherit pname version;
        sha256 = "sha256-fSnhTfvBnLapWkvWae294R9dTGpx/apCwtQLaEboB/c=";
      };
      doCheck = false;
   };
   asgiref = with pkgs.python3Packages; buildPythonPackage rec {
    pname = "asgiref";
    version = "3.7.2";
    src = fetchPypi {
      inherit pname version;
      sha256 = "sha256-ngzjqpOoGbpbRRICFrI4eM9uhSXrOEhlNFK0GSuSr+0=";
    };
    doCheck = false;
   };
   sqlparse = with pkgs.python3Packages; buildPythonPackage rec {
    pname = "sqlparse";
    version = "0.4.4";
    format = "wheel";

    src = fetchPypi {
      inherit pname version format;
      dist = "py3";
      python = "py3";
      sha256 = "5430a4fe2ac7d0f93e66f1efc6e1338a41884b7ddf2a350cedd20ccc4d9d28f3";
    };
    doCheck = false;
   };
  in
  {
    devShells."${system}".default = pkgs.mkShell {
      packages = with pkgs; [
        python3
        django
        asgiref
        sqlparse
        nodejs # For neovim's LSP (Remove it if you're not using neovim)
      ];

      shellHook = ''
        echo "Django's development template env was set successfully"
        echo "`${pkgs.python3.interpreter} --version`"
        echo "Django version: `${pkgs.python3.interpreter} -m django --version`"
      '';
    };
  };
}
