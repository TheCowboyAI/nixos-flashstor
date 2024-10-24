# hardware specific
{ lib, pkgs, modulesPath, ... }:
{
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot = {
    kernelModules = [ "kvm-intel" ];
    kernelParams = [ ];
    kernelPackages = pkgs.linuxPackages;
    extraModulePackages = [ ];

    initrd = {
      kernelModules = [ ];
      # These are considerably more than the nix generator finds...
      # nixos-facter may do better, but isn't necessary here.
      availableKernelModules = [
        "zfs"
        "ext4"
        "vfat"
        "ahci"
        "xhci_pci"
        "sdhci_acpi"
        "nvme"
        "usb_storage"
        "sd_mod"
        "sr_mod"
        "rtsx_pci_sdmmc"
        "ehci_hcd"
        "uhci_hcd"
        "mmc_block"
        "i915"
      ];
      # enable filesystems and usb/sd or it probably won't boot
      supportedFilesystems = [ "ext4" "vfat" "zfs" ];
    };

    loader = {
      grub.enable = false;
      systemd-boot.enable = lib.mkForce true;
      efi.canTouchEfiVariables = true;
    };
  };

  powerManagement.cpuFreqGovernor = lib.mkDefault "performance";
}
