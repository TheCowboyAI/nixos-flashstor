{ ... }:
{
  system.stateVersion = "24.05";
  system.copySystemConfiguration = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  # disable coredump that could be exploited
  # slows down the system if something crashes
  systemd.coredump.enable = false;

  imports =
    [
      "${modulesPath}/profiles/hardened.nix"
      ./hardware-configuration.nix
      ./networking.nix
      ./packages.nix
      ./services.nix
      ./programs.nix
      ./users.nix
      ./minio.nix
    ];

}
