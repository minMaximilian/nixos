{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
  ];

  nixpkgs = {
    overlays = [
    ];
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };

  home = {
    username = "max";
    homeDirectory = "/home/max";
    stateVersion = "23.05";
    packages = with pkgs; [
      oh-my-zsh
    ];
  };

  programs.zsh = {
    enable = true;
    oh-my-zsh = {
      enable = true;
    };
  };

  
  programs.neovim = 
  let
    toLua = str: "lua << EOF\n${str}\nEOF\n";
    toLuaFile = file: "lua << EOF\n${builtins.readFile file}\nEOF\n";
  in 
  {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    defaultEditor = true;

    extraPackages = with pkgs; [
      lua-language-server
      rnix-lsp

      xclip
      wl-clipboard
    ];

    plugins = with pkgs.vimPlugins; [
      {
        plugin = nvim-lspconfig;
        config = toLuaFile ../config/nvim/plugin/lsp.lua;
      }

      {
        plugin = comment-nvim;
        config = toLua "require(\"Comment\").setup()";
      }

      {
        plugin = gruvbox-nvim;
        config = "colorscheme gruvbox";
      }

      neodev-nvim
      vim-nix
      nvim-cmp
      rust-tools-nvim
      vim-visual-multi
      nvim-tree-lua
      {
        plugin = nvim-cmp;
        config = toLuaFile ../config/nvim/plugin/cmp.lua;
      }

      {
        plugin = telescope-nvim;
        config = toLuaFile ../config/nvim/plugin/telescope.lua;
      }

      telescope-fzf-native-nvim

      cmp_luasnip
      cmp-nvim-lsp

      luasnip
      friendly-snippets


      lualine-nvim
      nvim-web-devicons

      { 
        plugin = (nvim-treesitter.withPlugins (p: [
          p.tree-sitter-nix
          p.tree-sitter-vim
          p.tree-sitter-bash
          p.tree-sitter-lua
          p.tree-sitter-python
          p.tree-sitter-json
          p.tree-sitter-yaml
          p.tree-sitter-rust
          p.tree-sitter-go
          p.tree-sitter-kotlin
          p.tree-sitter-java
        ]));
	config = toLuaFile ../config/nvim/plugin/treesitter.lua;
      }
    ];

    extraLuaConfig = ''
      ${builtins.readFile ../config/nvim/options.lua}
    ''; 
  };

  programs.home-manager.enable = true;
  programs.git.enable = true;
  programs.waybar.enable = true;
  systemd.user.startServices = "sd-switch";
}
