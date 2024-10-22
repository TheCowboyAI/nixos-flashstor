{ modulesPath, self, lib, ... }:
{
  # simplified configuration to run nixos-anywhere without kexec
  # the default only has 4G ram if we don't upgrade it
  system.stateVersion = "24.05";
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # this flags the system so nixos-anywhere avoids kexec
  # see: https://github.com/NixOS/nixpkgs/blob/master/nixos/modules/profiles/installation-device.nix
  system.nixos.variant_id = lib.mkDefault "installer";

  # we probably need/want a swap file, it helps with zcache
  zramSwap = {
    enable = true;
    memoryPercent = 100;
  };

  imports =
    [
      "${modulesPath}/profiles/hardened.nix"
      ./hardware-configuration.nix
      ./networking.nix
      ./packages.nix
      ./services.nix
      ./programs.nix
      ./users.nix
    ];

}
