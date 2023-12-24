{
  description = "React Native development shell";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # https://github.com/nix-community/nixGL (for reference)
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

    in pkgs.mkShell rec {
      packages = with pkgs; [
        nodejs_18
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
        echo "Node: `${pkgs.nodejs_20}/bin/node --version`" # Shows Node version on shell start
        echo "To launch the emulator run: nixGLIntel $android/bin/run-test-emulator"  # Launch the emulator (Replace nixGLIntel accordingly, for info refer to nixGL docs)
        echo "If you're on nvidia replace 'nixGLIntel' accordingly"
        exec fish  # You can remove this if you're using normal bash
        '';
    };
  };
}
