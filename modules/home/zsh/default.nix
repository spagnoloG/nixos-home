{ pkgs, lib, config, ... }:

with lib;
let cfg = config.modules.zsh;

in {
  options.modules.zsh = { enable = mkEnableOption "zsh"; };
  config = mkIf cfg.enable {
    home.packages = with pkgs; [ zsh fzf lsd grc eza ];

    programs.zsh = {
      enable = true;
      shellAliases = {
        md-notes = "cd ~/Documents/md-notes/ && nvim .";
        rm = "rm -i";
        night = "brightnessctl s 1%";
        rot13 = "tr 'A-Za-z' 'N-ZA-Mn-za-m'";
        ls = "lsd";
        sus = "systemctl suspend";
        sur = "systemctl reboot";
        sup = "power off";
        ss = "grc ss";
        tree = "eza --tree";
        vi = "nvim";
        vim = "nvim";
        ndevelop = "nix develop -c $SHELL";
        rebuild-os =
          "sudo nixos-rebuild switch --flake ${config.home.homeDirectory}/.config/home-manager#yoga";
      };
      initExtra = ''
        export EDITOR='nvim'
        source "$(fzf-share)/key-bindings.zsh"
        source "$(fzf-share)/completion.zsh"

        bin_txt() {
            curl -X PUT --data "$1" https://p.spanskiduh.dev
        }

        bin_file() {
            curl -X PUT --data-binary "@$1" https://p.spanskiduh.dev
        }

        cleanup-os() {
            sudo nix-env --list-generations --profile /nix/var/nix/profiles/system
            sudo nix-env --delete-generations old --profile /nix/var/nix/profiles/system
            sudo nix-collect-garbage -d
            sudo nix-store --optimize
            sudo nix-env --list-generations --profile /nix/var/nix/profiles/system

        }
      '';
      oh-my-zsh = {
        enable = true;
        theme = "cypher";
        plugins = [
          "sudo"
          "terraform"
          "systemadmin"
          "vi-mode"
          "z"
          "colorize"
          "compleat"
          "ansible"
        ];
      };

      plugins = [
        {
          name = "zsh-autosuggestions";
          src = pkgs.fetchFromGitHub {
            owner = "zsh-users";
            repo = "zsh-autosuggestions";
            rev = "v0.4.0";
            sha256 = "0z6i9wjjklb4lvr7zjhbphibsyx51psv50gm07mbb0kj9058j6kc";
          };
        }
        {
          name = "fzf-tab";
          src = pkgs.fetchFromGitHub {
            owner = "Aloxaf";
            repo = "fzf-tab";
            rev = "b06e7574577cd729c629419a62029d31d0565a7a";
            sha256 = "sha256-ilUavAIWmLiMh2PumtErMCpOcR71ZMlQkKhVOTDdHZw=";
          };
        }
        {
          name = "warhol";
          src = pkgs.fetchFromGitHub {
            owner = "unixorn";
            repo = "warhol.plugin.zsh";
            rev = "49a2fb6789179c789f54b95221c91fdc1bd5f804";
            sha256 = "sha256-cL7qfgoJseS/epWPyzUy0Ul4GMtyPzYkZ5tsHbRjcRI=";
          };
        }
      ];

    };

  };
}
