# NeoVim Configurations

<div align="center">
  
[![Lua](https://img.shields.io/badge/Made%20With-Lua-2C2D72?style=for-the-badge&logo=lua&logoColor=white)]()
[![Repo_Size](https://img.shields.io/github/languages/code-size/shaunsingh/nyoom.nvim?color=orange&label=Repo%20Size&style=for-the-badge)]()
[![Neovim Minimum Version](https://img.shields.io/badge/Neovim-0.6+-blueviolet.svg?style=flat-square&logo=Neovim&logoColor=white)](https://github.com/neovim/neovim)

</div>

## Showcase

<img width="1450" alt="image" src="https://user-images.githubusercontent.com/71196912/144915258-dc6652cf-64e4-458f-8f01-8f17dbb33756.png">

## Install

### Using nix:

Requires nix version > 21.11, with experimental features `flakes` and `nix-commands` enabled

```bash
git clone --depth 1 shaunsingh/nyoom.nvim && cd nyoom.nvim
nix develop
nvim
```

Then run `:PackerSync`

### Regular:

Install the following dependencies:

- neovim-nightly (or neovim stable)
- luajit
- ripgrep
- nodejs (optional, for copilot)

Then run `:PackerSync`

## Features

## TODO

- ~~Rewrite statusline w/o plugins (+async)~~
- ~~Redo Cmp/LspConfig/Copilot configs and integrations~~
- ~~Rewrite theme to use `nvim_set_hl`~~
- Check all plugins are lazyloaded.
