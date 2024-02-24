{ pkgs, lib, config, ... }:

with lib;
let cfg = config.modules.alacritty;

in {
  options.modules.alacritty = { enable = mkEnableOption "alacritty"; };
  config = mkIf cfg.enable {
    home.packages = with pkgs; [ alacritty ];

    programs.alacritty = {
      enable = true;

      settings = {
        window = {
          opacity = 0.7;
          padding = {
            x = 5;
            y = 5;
          };
        };

        font = {
          normal = {
            family = "Iosevka";
            style = "Regular";
          };
          size = 12;
        };

        liveConfigReload = true;
        dynamicPadding = true;

        colors = {
          primary = {
            background = "#1c1e26";
            foreground = "#e0e0e0";
            dim_foreground = "#e0e0e0";
            bright_foreground = "#e0e0e0";
          };

          cursor = {
            text = "#1c1e26";
            cursor = "#e95678";
          };

          vi_mode_cursor = {
            text = "#1c1e26";
            cursor = "#26bbd9"; # Using Horizon Dark blue for visual distinction
          };

          search = {
            matches = {
              foreground = "#1c1e26";
              background = "#fab795"; # Horizon Dark yellow for contrast
            };
            focused_match = {
              foreground = "#1c1e26";
              background = "#29d398"; # Horizon Dark green for visibility
            };
            footer_bar = {
              foreground = "#1c1e26";
              background = "#fab795"; # Horizon Dark yellow for consistency
            };
          };

          hints = {
            start = {
              foreground = "#1c1e26";
              background = "#ee64ac"; # Horizon Dark magenta for visibility
            };
            end = {
              foreground = "#1c1e26";
              background = "#26bbd9"; # Horizon Dark blue for consistency
            };
          };

          selection = {
            text = "#1c1e26";
            background = "#e95678"; # Horizon Dark red for visibility
          };

          normal = {
            black = "#16161c";
            red = "#e95678";
            green = "#29d398";
            yellow = "#fab795";
            blue = "#26bbd9";
            magenta = "#ee64ac";
            cyan = "#59e1e3";
            white = "#d5d8da";
          };

          bright = {
            black = "#5b5858";
            red = "#ec6a88";
            green = "#3fdaa4";
            yellow = "#fbc3a7";
            blue = "#3fc4de";
            magenta = "#f075b5";
            cyan = "#6be4e6";
            white = "#d5d8da";
          };

          dim = {
            black = "#16161c";
            red = "#e95678";
            green = "#29d398";
            yellow = "#fab795";
            blue = "#26bbd9";
            magenta = "#ee64ac";
            cyan = "#59e1e3";
            white = "#d5d8da";
          };

          indexed_colors = [
            {
              index = 16;
              color = "#f5a97f";
            }
            {
              index = 17;
              color = "#f4dbd6";
            }
          ];
        };

      };
    };

  };

}
