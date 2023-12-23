للعربية اضغط هنا: [بيئة عمل ريأكت نيتف](../docs/ar/بيئة ريأكت نيتف.md).
# Intro
This is a [React Native](https://reactnative.dev/) development environment and it is meant to install and set everything up
automatically for convenient and quicker development.

## Supported Operating Systems
This could be used anywhere that supports Nix including MAC, other Linux distros,
however it does NOT support windows out of the box, yet you can use WSL which supports installing almost any linux distro on windows;
for best support I suggest you refer to [NixOS-WSL](https://github.com/nix-community/NixOS-WSL) project, it is supported and maintained
    by the Nix community.

## Running a quick environment
For a quick rolling development environment with everything you need you'll need the following

- For an existing project follow these steps:
    1. CD to your existing project:    
    ```bash
    cd path/to/my-project # Change my working to directory to the project's path
    ```
    2. afterwards [get the template](#getting-the-template) in that directory.

- OR create a new project, following these steps:
    1. [Get the template](#getting-the-template) in a parental directory (You'll see why following).
    2. Now you can create the project (it creates a new directory with project's files, hence the parental dir mentioned above).
    ```bash
    npx create-expo-app MyAwesomeProject # Expo is the official recommended way to roll new apps nowadays.
    ```

### Getting the template
```bash
nix flake init --template "github:Al-Ghoul/NixDev-Environments#react-native"
```
