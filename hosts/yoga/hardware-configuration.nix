# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.

let

  # Use this script to find the IOMMU groups
  # Resource: https://astrid.tech/2022/09/22/0/nixos-gpu-vfio/
  # Additional resource: https://wiki.archlinux.org/title/PCI_passthrough_via_OVMF
  #!/bin/bash
  #   shopt -s nullglob
  #   for g in $(find /sys/kernel/iommu_groups/* -maxdepth 0 -type d | sort -V); do
  #       echo "IOMMU Group ${g##*/}:"
  #       for d in $g/devices/*; do
  #           echo -e "\t$(lspci -nns ${d##*/})"
  #       done;
  #   done;

  # IOMMU Group 12:
  #        01:00.0 VGA compatible controller [0300]: NVIDIA Corporation GA107BM [GeForce RTX 3050 Mobile] [10de:25e2] (rev a1)

  # Vagrant passtrough
  # config.vm.provider :libvirt do |libvirt|
  #  libvirt.qemu_use_session = false
  #  # Setup for GPU passthrough
  #  libvirt.pci :bus => '0x01', :slot => '0x00', :function => '0x0'
  #  libvirt.nested = true 
  #  libvirt.kvm_hidden = true
  #  libvirt.cpu_mode = "host-passthrough"
  # end

  # Lets fucking go:
  # When sshd into vagrant box: 00:04.0 VGA compatible controller: NVIDIA Corporation GA107BM [GeForce RTX 3050 Mobile] (rev a1)

  # Setup cuda and cudnn: https://gist.github.com/denguir/b21aa66ae7fb1089655dd9de8351a202

  rtx3050_pci = "10de:25e2";

in { config, lib, pkgs, modulesPath, ... }:

{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot.initrd.availableKernelModules =
    [ "nvme" "xhci_pci" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules =
    [ "vfio_pci" "vfio" "vfio_iommu_type1" "vfio_virqfd" ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.kernelParams = [ "amd_iommu=on" "vfio-pci.ids=${rtx3050_pci}" ];
  boot.blacklistedKernelModules = [ "nouveau" ];
  hardware.opengl.enable = true;

  #boot.extraModulePackages = [ pkgs.linuxPackages.nvidia_x11 ];
  services.xserver.videoDrivers = [ "amdgpu" "nvidia" ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/0899771d-54fe-4a08-917d-4e31fc6b4d3d";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/D414-BBFF";
    fsType = "vfat";
  };

  swapDevices =
    [{ device = "/dev/disk/by-uuid/a439d0f1-e65c-4178-abd8-d0d31dc9ba18"; }];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp2s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode =
    lib.mkDefault config.hardware.enableRedistributableFirmware;
}
