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
        randwall = "feh --bg-scale --randomize ~/pictures/wallpapers/*";
        zapiski = "~/Documents/faks_git/FRI-ZAPISKI";
        ctf = "cd ~/Documents/ctf/2022";
        faks = "cd ~/Documents/faks";
        faks-git = "cd ~/Documents/faks_git";
        rm = "rm -i";
        night = "brightnessctl s 1%";
        nightlock = "swaylock -c 000000";
        hsrv = "ssh hsrv";
        rs = "export QT_QPA_PLATFORM=xcb; rstudio-bin --no-sandbox &";
        rot13 = "tr 'A-Za-z' 'N-ZA-Mn-za-m'";
        nix-update = "nix-channel --update && nix-env -u";
        ls = "lsd";
        sus = "systemctl suspend";
        sur = "systemctl reboot";
        sup = "power off";
        hg = "history | grep";
        ss = "grc ss";
        tree = "eza --tree";
	ssh = "kitten ssh";
        rebuild-os =
          "sudo nixos-rebuild switch --flake ${config.home.homeDirectory}/.config/home-manager#yoga --impure";
      };
      initExtra = ''
              export EDITOR='nvim'

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

              # Gpg tty
              GPG_TTY=$(tty)
              export GPG_TTY
              export FUNCNEST=500

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
