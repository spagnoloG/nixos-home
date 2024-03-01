{ config, pkgs, inputs, lib, user, hostname, ... }:

{

  nixpkgs.config.allowUnfree = true;

  # Remove unecessary preinstalled packages
  environment.defaultPackages = [ ];

  environment.sessionVariables = { GTK_USE_PORTAL = "1"; };

  services.printing.enable = true;

  programs.zsh.enable = true;

  # Docker
  virtualisation.docker.enable = true;

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command =
          "${pkgs.greetd.tuigreet}/bin/tuigreet --time --greeting 'Welcome to NixOS!' --cmd Hyprland";
        user = "${user}";
      };
    };
  };

  services.openssh.enable = true;
  systemd.services.sshd.wantedBy = lib.mkForce [ ];

  programs.ssh.startAgent = true;

  services.hardware.bolt.enable = true;

  hardware.logitech.wireless.enable = true;
  hardware.logitech.wireless.enableGraphical = true;

  programs.hyprland.xwayland.enable = true;

  virtualisation.libvirtd.enable = true;
  fonts = {
    packages = with pkgs; [
      jetbrains-mono
      roboto
      openmoji-color
      (nerdfonts.override { fonts = [ "FiraCode" "FantasqueSansMono" ]; })
      fira-code
      fira
      cooper-hewitt
      ibm-plex
      iosevka
      spleen
      fira-code-symbols
      powerline-fonts
      nerdfonts
    ];

    fontconfig = {
      hinting.autohint = true;
      defaultFonts = { emoji = [ "OpenMoji Color" ]; };
    };
  };

  xdg = {
    icons.enable = true;
    portal = {
      enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-hyprland
        xdg-desktop-portal-gtk
      ];
    };
  };

  xdg.portal.config.common.default = "*";

  programs.dconf.enable = true;
  services.dbus.packages = with pkgs; [ dconf ];
  services.dbus.enable = true;

  services.gvfs = {
    enable = true;
    package = lib.mkForce pkgs.gnome3.gvfs;
  };

  # Firmware Updater
  services.fwupd.enable = true;

  # Nix settings, auto cleanup and enable flakes
  nix = {
    settings.auto-optimise-store = true;
    settings.allowed-users = [ "${user}" ];
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
    };
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs = true
      keep-derivations = true
    '';
  };

  # Boot settings: clean /tmp/, latest kernel and enable bootloader
  boot = {
    tmp.cleanOnBoot = true;
    loader = {
      systemd-boot.enable = true;
      systemd-boot.editor = false;
      efi.canTouchEfiVariables = true;
      timeout = 0;
    };
  };

  # Set up locales (timezone and keyboard layout)
  time.timeZone = "Europe/Ljubljana";
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "en";
  };

  # Set up user and enable sudo
  users.users.${user} = {
    isNormalUser = true;
    extraGroups =
      [ "input" "wheel" "networkmanager" "libvirtd" "wireshark" "docker" ];
    initialHashedPassword =
      "$6$wqCHereET3WM6UIA$XeJIgGkmO2/zAkktN2JCx5hLNS3kSj6seVQBdSWoMeJ5MOrIha6B/HiDjHI4oKDKYhYVwjgQFqGpncU6OI7Ud/"; # password: d3fault
    shell = pkgs.zsh;
  };

  networking = {
    networkmanager.enable = true;
    hostName = "${hostname}";
    firewall.enable = false;
    extraHosts = ""; # For adding hosts.
  };

  # Set environment variables
  environment.variables = {
    NIXOS_CONFIG_DIR = "$HOME/.config/nixos/";
    NIXPKGS_ALLOW_INSECURE = "1";
    XDG_DATA_HOME = "$HOME/.local/share";
    GTK_RC_FILES = "$HOME/.local/share/gtk-1.0/gtkrc";
    GTK2_RC_FILES = "$HOME/.local/share/gtk-2.0/gtkrc";
    MOZ_ENABLE_WAYLAND = "1";
    EDITOR = "nvim";
    DIRENV_LOG_FORMAT = "";
    ANKI_WAYLAND = "1";
    DISABLE_QT5_COMPAT = "0";
    LIBSEAT_BACKEND = "logind";
    GTK_USE_PORTAL = "1";
  };

  environment.localBinInPath = true;

  security = {
    sudo.enable = true;
    # Extra security
    protectKernelImage = true;
    pam.services.gtklock.text =
      lib.readFile "${pkgs.gtklock}/etc/pam.d/gtklock";
  };

  # Sound (PipeWire)
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  hardware = {
    bluetooth = {
      enable = true;
      settings.General.Experimental = true; # battery level feature
    };
  };

  # Enable OpenGL
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  programs.gnupg.agent = {
    enable = true;
    pinentryFlavor = "gtk2";
  };

  services.blueman.enable = true;
  # Do not touch
  system.stateVersion = "23.11";

}
