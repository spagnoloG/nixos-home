{ pkgs, lib, config, ... }:

with lib;
let cfg = config.modules.kanshi;

in {
  options.modules.kanshi = { enable = mkEnableOption "kanshi"; };
  config = mkIf cfg.enable {
    home.packages = with pkgs; [ kanshi ];

    services.kanshi = {
      enable = true;

      systemdTarget = "xdg-desktop-portal-hyprland.service";

      profiles = {
        profile1 = {
          outputs = [
            {
              criteria = "Dell Inc. DELL P2419HC H565L03";
              position = "0,0";
            }
            {
              criteria = "eDP-1";
              status = "disable";
            }
          ];
        };

        yoga = {
          outputs = [{
            criteria = "California Institute of Technology 0x1410 Unknown";
            mode = "3072x1920@120Hz";
            scale = 1.5;
          }];
        };

        lj_setup = {
          outputs = [
            {
              criteria = "Samsung Electric Company C34H89x H4ZRB05512";
              mode = "3440x1440@100Hz";
            }
            {
              criteria = "California Institute of Technology 0x1410 Unknown";
              status = "disable";
            }
          ];
        };

        portable_monitor = {
          outputs = [
            {
              criteria = "California Institute of Technology 0x1410 Unknown";
              mode = "3072x1920@120Hz";
              scale = 1.0;
              position = "1128,3130";
            }
            {
              criteria = "Avolites Ltd ARZOPA -S1 0000000000000";
              mode = "1920x1080@60Hz";
              position = "1690,2050";
            }
          ];
        };

        portable_monitor_2 = {
          outputs = [
            {
              criteria = "AU Optronics 0x313D Unknown";
              mode = "1920x1080@60Hz";
              scale = 1.0;
              position = "1920,1080";
            }
            {
              criteria = "Avolites Ltd ARZOPA -S1 0000000000000";
              mode = "1920x1080@60Hz";
              position = "1920,0";
            }
          ];
        };

        lj_setup_2 = {
          outputs = [
            {
              criteria = "AU Optronics 0x313D Unknown";
              status = "disable";
            }
            {
              criteria = "Samsung Electric Company C34H89x H4ZRB05512";
              mode = "3440x1440@60Hz";
            }
          ];
        };

        hs_1 = {
          outputs = [
            {
              criteria = "AU Optronics 0x313D Unknown";
              #mode = "1920x1080@60Hz";
              #scale = 1.0;
              #position = "0,1080";
              status = "disable";
            }
            {
              criteria = "Samsung Electric Company S24D330 0x00005B31";
              mode = "1920x1080@60Hz";
              position = "0,0";
            }
          ];

        };

        hs_22 = {
          outputs = [
            {
              criteria =
                "Philips Consumer Electronics Company PHL27M1N3200Z UK02329015881";
              mode = "1920x1080@144";
            }
            {
              criteria = "California Institute of Technology 0x1410 Unknown";
              status = "disable";
            }
          ];
        };

        profile7 = {
          outputs = [{
            criteria = "AU Optronics 0x313D Unknown";
            mode = "1920x1080@60Hz";
            scale = 1.0;
          }];
        };
      };
    };

  };
}
