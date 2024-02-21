{ inputs, pkgs, lib, config, python3, ... }:

with lib;
let
  cfg = config.modules.packages;
  pyenv = ps:
    with ps; [
      impacket
      dsinternals
      pypykatz
      lsassy
      pip
      ldapdomaindump
      requests
    ];

in {
  options.modules.packages = { enable = mkEnableOption "packages"; };
  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      # Basic Tools
      fzf
      ffmpeg
      gnupg
      libnotify
      git
      file
      wget
      neovim
      gcc
      cmake
      gtklock
      inputs.hypr-contrib.packages.${pkgs.system}.grimblast
      openssl
      cifs-utils
      mlocate
      nfs-utils
      openvpn
      wireguard-tools
      net-snmp
      inetutils
      unrar
      distrobox
      dig
      moreutils
      perl
      binutils
      zlib
      jdk
      # Development
      dbeaver
      libreoffice
      zathura
      okular
      conda
      joplin-desktop
      # Tools / File managenemt
      sshpass
      gparted
      transmission-gtk
      xournalpp
      pdftk
      pandoc
      texlive.combined.scheme-full
      remmina
      pcmanfm
      jq
      feh
      ranger
      uget
      stow
      bat
      eza
      # Statistics
      btop
      nvitop
      cava
      acpi
      brightnessctl
      neofetch
      htop-vim
      # Programming languages
      ansible
      # Database connection tools
      mysql
      sqlite
      postgresql
      # Audio video image
      playerctl
      easyeffects
      krita
      spotify
      shotwell
      fdupes # find image duplicates based on their contents
      mpv
      imagemagick
      vlc
      blueberry # Bluetooth client (GUI)
      # Voice chat
      discord
      zoom-us
      slack
      teams-for-linux
      # Shell extras
      starship
      lsd
      # Learning
      anki-bin
      # Games
      superTuxKart
      # Security
      steghide
      exiftool
      fcrackzip
      ghidra-bin
      tshark
      tcpdump
      gdb
      gef
      nmap
      # Format tools
      black
      nixfmt
      # Maths 
      R
      # Wayland shit 
      wdisplays
      wl-mirror
      # Rofi plugins
      rofi-bluetooth
      # Audo control
      pulsemixer
      pavucontrol
      nextcloud-client
      # Mailing
      thunderbird-bin
      # Flameshot
      xdg-desktop-portal
      xdg-desktop-portal-wlr
      grim
      flameshot
      # Networking statistics
      nload
      # Disk usage
      ncdu
      # Compression
      zip
      unzip
      pigz
      p7zip
      ddrescue
      ripgrep
      # Browsers
      brave
      firefox
      google-chrome
      # colored output in terminal
      grc
      # Fonts
      fira-code
      fira
      cooper-hewitt
      ibm-plex
      jetbrains-mono
      iosevka
      spleen
      fira-code-symbols
      powerline-fonts
      nerdfonts
    ];
  };
}
