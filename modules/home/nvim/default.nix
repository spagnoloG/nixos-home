{ lib, config, pkgs, ... }:
with lib;
let cfg = config.modules.nvim;
in {
  options.modules.nvim = { enable = mkEnableOption "nvim"; };
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      neovim
      nodejs
      python311Packages.pynvim
      luaformatter
      nodePackages.prettier
      perl536Packages.LatexIndent
    ];
    home.file.".config/nvim" = {
      source = ./config;
      recursive = true;
    };
  };

}
