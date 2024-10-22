{ pkgs, ... }:
{
  security.sudo.wheelNeedsPassword = false;

  # giving root a password enables su which we may want
  users.users.root = {
    isSystemUser = true;
    hashedPassword = "$2b$05$cYbhJQAdsTDdvckfUcCWuOKw9ZZR2LsSyn5/l8E5HXldarBjrxySm";
    shell = pkgs.zsh;
  };

  users.users.nixos = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    hashedPassword = "$2b$05$cYbhJQAdsTDdvckfUcCWuOKw9ZZR2LsSyn5/l8E5HXldarBjrxySm";
    shell = pkgs.zsh;
    createHome = true;
    home = "/home/nixos";
  };
}