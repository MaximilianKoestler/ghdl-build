![](https://img.shields.io/github/license/MaximilianKoestler/ghdl-build)
![](https://github.com/MaximilianKoestler/ghdl-build/workflows/build/badge.svg)
![](https://img.shields.io/github/languages/top/MaximilianKoestler/ghdl-build)
![](https://img.shields.io/github/issues/MaximilianKoestler/ghdl-build)

# GHDL Build under Windows

This repository contains automation scripts to build the [GHDL](https://github.com/ghdl/ghdl) Language Server as a PyInstaller binary for Windows.
The goal is to have a simple deployment of the VSCode extension for windows.

**Everything in this repository is currently WIP**

[GitHub Actions](https://github.com/MaximilianKoestler/ghdl-build/actions?query=workflow%3Abuild) are set up to autmatically run the scripts.

Later, they will also bundle the releases.

# Building Locally
Setup environment variables:
```powershell
$env:GhdlPythonPath = "..."
$env:AppveyorToken = "..."
```