{ pkgs, lib, config, ... }:

with lib;
let cfg = config.modules.vscode;

in {
  options.modules.vscode = { enable = mkEnableOption "vscode"; };
  config = mkIf cfg.enable {
    home.packages = with pkgs; [ vscode ];

    programs.vscode = {
      enable = true;
      extensions = with pkgs.vscode-extensions; [
        dracula-theme.theme-dracula
        vscodevim.vim
        yzhang.markdown-all-in-one
        github.copilot
      ];
    };

  };

}
