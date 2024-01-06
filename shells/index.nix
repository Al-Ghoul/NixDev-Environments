
with pkgs; {
  cpp-dev = (mkShell.override { stdenv = clangStdenv; }) {
    name = "Cpp development shell";

    packages = [
      boost 
      clang-tools 
      vscode-extensions.vadimcn.vscode-lldb.adapter 
      nodejs # For neovim's LSP to function properly
    ];

    shellHook = ''
      echo "The cpp-dev was set successfully";
      exec fish
    '';
  };

  nextjs-dev = mkShell {
    name = "NextJS development shell";
    
    packages = [
      nodejs_21
      yarn
    ];

    shellHook = ''
      echo "The nextjs-dev shell was set successfully"
      exec fish
    '';
  };

  laravel-dev = mkShell {
    name = "Laravel development shell";

    packages = [
      php
      phpPackages.composer
      nodejs # For neovim's LSP to function properly
    ];

    shellHook = ''
      echo "The laravel-dev shell was set successfully"
      exec fish
    '';
  };

  django-dev = mkShell rec {
    name = "Django development shell"; 

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
    
    packages = [
      python3
      django
      asgiref
      sqlparse
      nodejs # For neovim's LSP (Remove it if you're not using neovim)
    ];

    shellHook = ''
        echo "Django's development template env was set successfully"
        echo "`${python3.interpreter} --version`"
        echo "Django version: `${python3.interpreter} -m django --version`"
        exec fish
    '';
  };


  reactnative-dev = 
  let
    # These specific versions are REQUIRED by react native
    # Please do NOT mess with them unless you know what you're doing.
  buildToolsVersion =  "33.0.0";
  androidComposition = pkgs.androidenv.composeAndroidPackages {
    toolsVersion = null;
    platformVersions = [ "33" ];
    buildToolsVersions =  [ buildToolsVersion "30.0.3" ];
    includeNDK = true;
    ndkVersions = [ "23.1.7779620" ];
    cmakeVersions = [ "3.22.1" ];
  };
  in
    mkShell rec {
      name = "React native development shell";
      
      packages = [
        nodejs_21
        jdk17
        watchman # Required for 'metro' for better performance 
        androidComposition.platform-tools # Expose platform tools (aka adb & other executables)
        pkgs.nixgl.nixGLIntel # Fixes GPU usage issue; GLIntel only supports AMD & Intel GPUs, for Nvidia you might wanna use other options.
        nodePackages.eas-cli # Expo's EAS Update CLI
      ];
      
      # Expose required ENV variables
      ANDROID_SDK_ROOT = "${androidComposition.androidsdk}/libexec/android-sdk";
      ANDROID_NDK_ROOT = "${ANDROID_SDK_ROOT}/ndk-bundle";
      GRADLE_OPTS = "-Dorg.gradle.project.android.aapt2FromMavenOverride=${ANDROID_SDK_ROOT}/build-tools/${buildToolsVersion}/aapt2";

      # Pre-setup an emulator
      # Usually available @ $android/bin/
      android = pkgs.androidenv.emulateApp {
        configOptions =  { "hw.gpu.enabled" = "yes"; }; # Enable GPU acceleration
        name = "AlGhoul's-Emulator";
        platformVersion = "29";
        abiVersion = "x86";
        systemImageType = "google_apis_playstore";
        # Resolution could be anything you want, keep the others if your Hardware supports KVM (for better performance)
        androidEmulatorFlags = "-skin 720x1280 -accel on -gpu host -qemu -enable-kvm";
      };

      shellHook = ''
        echo "Node: `${nodejs_21}/bin/node --version`" # Shows Node version on shell start
        echo 'To launch the emulator run: nixGLIntel $android/bin/run-test-emulator'  # Launch the emulator (Replace nixGLIntel accordingly, for info refer to nixGL docs)
        echo "If you're on nvidia replace 'nixGLIntel' accordingly"
        exec fish  # You can remove this if you're using normal bash
      '';
  };
}
