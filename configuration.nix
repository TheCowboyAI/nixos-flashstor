{ modulesPath, ... }:
{
  system.stateVersion = "24.05";
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  # disable coredump that could be exploited
  # slows down the system if something crashes
  systemd.coredump.enable = false;

  imports =
    [
      "${modulesPath}/profiles/hardened.nix"
      ./modules/hardware-configuration.nix
      ./modules/networking.nix
      ./modules/packages.nix
      ./modules/services.nix
      ./modules/programs.nix
      ./modules/users.nix
      ./modules/minio.nix
    ];

}
