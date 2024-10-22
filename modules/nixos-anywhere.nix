{ modulesPath, self, lib, ... }:
{
  # simplified configuration to run nixos-anywhere without kexec
  # the default only has 4G ram if we don't upgrade it
  system.stateVersion = "24.05";
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.nixos.variant_id = lib.mkDefault "installer";

  # we probably need a swap file
  zramSwap = {
    enable = true;
    memoryPercent = 100;
  };

  imports =
    [
      #self.inputs.disko.nixosModules.disko
      "${modulesPath}/profiles/hardened.nix"
      ./hardware-configuration.nix
      ./networking.nix
      ./packages.nix
      ./services.nix
      ./programs.nix
      ./users.nix
    ];

}
