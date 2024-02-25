{ config, pkgs, lib, ... }: {

  environment.systemPackages = with pkgs; [
    acpi
    pciutils
    greetd.tuigreet
    glib-networking
  ];

  services.auto-cpufreq.enable = true;
  services.auto-cpufreq.settings = {
    battery = {
      governor = "powersave";
      turbo = "never";
    };
    charger = {
      governor = "performance";
      turbo = "auto";
    };
  };

}
