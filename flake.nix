{
  description = "React Native development shell";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixgl.url = "github:guibou/nixGL";
  };

  outputs = { self, nixpkgs, nixgl }:
  let 
    system = "x86_64-linux";
  in
  {
    devShells."${system}".default =
      let
      pkgs = import nixpkgs {
        config.allowUnfree = true;
        config.android_sdk.accept_license = true;
        overlays = [ nixgl.overlay ];
        inherit system;
      };
      
      buildToolsVersion =  "33.0.0";
      androidComposition = pkgs.androidenv.composeAndroidPackages {
        toolsVersion = null;
        platformVersions = [ "33" ];
        buildToolsVersions =  [ buildToolsVersion "30.0.3" ];
        includeNDK = true;
        ndkVersions = [ "23.1.7779620" ];
        cmakeVersions = [ "3.22.1" ];
      };

    in pkgs.mkShell rec {
      packages = with pkgs; [
        nodejs_20
        jdk17
        watchman
        androidComposition.platform-tools
        pkgs.nixgl.nixGLIntel
      ];

      ANDROID_SDK_ROOT = "${androidComposition.androidsdk}/libexec/android-sdk";
      ANDROID_NDK_ROOT = "${ANDROID_SDK_ROOT}/ndk-bundle";
      GRADLE_OPTS = "-Dorg.gradle.project.android.aapt2FromMavenOverride=${ANDROID_SDK_ROOT}/build-tools/${buildToolsVersion}/aapt2";

      android = pkgs.androidenv.emulateApp {
        configOptions =  { "hw.gpu.enabled" = "yes"; };
        name = "AlGhoul's-Emulator";
        platformVersion = "29";
        abiVersion = "x86";
        systemImageType = "google_apis_playstore";
        androidEmulatorFlags = "-skin 720x1280 -accel on -gpu host -qemu -enable-kvm ";
      };

      shellHook = ''
        echo "Node: `${pkgs.nodejs_20}/bin/node --version`"
        nixGLIntel ${android}/bin/run-test-emulator
        exec fish
        '';
    };
  };
}
