للعربية اضغط هنا: [الوثائق](/docs/ar)

# Intro

This is a collection of my personal development environments, feel free to use any of them;
if you've any questions or concerns I suggest reading the docs accordingly, otherwise you can message me on discord (preferred)
or somewhere else. If you have any issues with the provided templates and/or environments you can [open an issue](https://github.com/Al-Ghoul/NixDev-Environments/issues/new/choose),
we don't have any templates (yet) for issues but please keep it simple and ask the full question with error logs provided.

## Available Envs & Templates

The following table summarizes what this repo provides:

| Name                                   | Shell              | Template           | Description                                 |
| -------------------------------------- | ------------------ | ------------------ | ------------------------------------------- |
| [react-native](/templates/ReactNative) | :white_check_mark: | :white_check_mark: | A shell for react native and expo projects. |
| cpp-dev                                | :white_check_mark: | :white_check_mark: | A 'clang' shell for c/c++ projects.         |
| nextjs-dev                             | :white_check_mark: | :x:                | A shell for nextjs, js & ts projects.       |
| laravel-dev                            | :white_check_mark: | :x:                | A shell for laravel & php projects.         |
| django-dev                             | :white_check_mark: | :white_check_mark: | A shell for django projects.                |

## Usage guide

[Nix Flakes](https://nixos.wiki/wiki/Flakes) makes it easier than ever to store and access development environments and templates
and put them under version control systems.

### Templates

For example to get a template from a vcs (github in this context) you can run the following:

```bash
nix flake init --template "github:<username>/<repository_name>#<template_name>"
```

replacing `username`, `repository_name` and `template_name` accordingly; For example to get an identical,
reproducible environment/template for c/cpp development as mine you can run the following:

```bash
nix flake init --template "github:Al-Ghoul/NixDev-Environments#cpp-dev"
```

This copies the whole template to your current working directory.

### Environments

To get just an environment with no boilerplate nor flakes copied to your current working directory or repository, you can run the following:

```bash
nix develop "github:<username>/repository_name#<environment_name>"
```

replacing `username`, `repository_name` and `environment_name` accordingly; For example to get an identical,
reproducible environment for c/cpp development as mine you can run the following:

```bash
nix develop "github:Al-Ghoul/NixDev-Environments#cpp-dev"
```

This is going to get all the packages required and set the environment for you automatically.
