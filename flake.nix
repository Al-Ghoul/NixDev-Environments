{
  description = "A collection of development environments and templates";

  outputs = { self}:
  {
    templates = {
      react-native = {
        path = ./ReactNative;
        description = "A React Native development environment with emulator included";
      };
    };
  };
}
