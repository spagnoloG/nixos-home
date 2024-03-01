{ config, pkgs, inputs, lib, user, hostname, ... }:

{

  nixpkgs.config.allowUnfree = true;

  # Remove unecessary preinstalled packages
  environment.defaultPackages = [ ];

  virtualisation.docker.enable = true;

  services.openssh = {
    enable = true;
    passwordAuthentication = true;
    allowTcpForwarding = true;
    x11Forwarding = true;
    port = 22;
  };

  programs.ssh.startAgent = true;
  services.hardware.bolt.enable = true;

  programs.dconf.enable = true;
  services.dbus.packages = with pkgs; [ dconf ];
  services.dbus.enable = true;

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

  boot = {
    tmp.cleanOnBoot = true;
    loader = {
      systemd-boot.enable = true;
      systemd-boot.editor = false;
      efi.canTouchEfiVariables = true;
      timeout = 0;
    };
  };

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

  # Set up networking and secure it
  networking = {
    networkmanager.enable = true;
    hostName = "${hostname}";
    firewall.enable = false;
    extraHosts = ""; # For adding hosts.
  };

  # Set environment variables
  environment.variables = {
    NIXOS_CONFIG_DIR = "$HOME/.config/nixos/";
    XDG_DATA_HOME = "$HOME/.local/share";
    EDITOR = "nvim";
    DIRENV_LOG_FORMAT = "";
    NIXPKGS_ALLOW_UNFREE = "1";
  };

  environment.localBinInPath = true;
  # Security 
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

  # Do not touch
  system.stateVersion = "23.11";

}
