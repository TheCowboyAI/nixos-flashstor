{ modulesPath, self, ... }:
{
  # simplified configuration to run nixos-anywhere without kexec
  # the default only has 4G ram if we don't upgrade it
  system.stateVersion = "24.05";
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  # disable coredump that could be exploited
  # slows down the system if something crashes
  systemd.coredump.enable = false;

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
