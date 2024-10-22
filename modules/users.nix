{ pkgs, ... }:
{
  security.sudo.wheelNeedsPassword = false;

  # giving root a password enables su which we may want
  users.users.root = {
    isSystemUser = true;
    # change this
    hashedPassword = "$2b$05$cYbhJQAdsTDdvckfUcCWuOKw9ZZR2LsSyn5/l8E5HXldarBjrxySm";
    # change this
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIK9cbvkULvOKBB1fbNH/yBql1NnqF/coMuzQPwQGCtjn"
    ];
    shell = pkgs.zsh;
  };

  users.users.nixos = {
    isNormalUser = true;
    # change this
    hashedPassword = "$2b$05$cYbhJQAdsTDdvckfUcCWuOKw9ZZR2LsSyn5/l8E5HXldarBjrxySm";
    # change this
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIK9cbvkULvOKBB1fbNH/yBql1NnqF/coMuzQPwQGCtjn"
    ];
    extraGroups = [ "wheel" ];
    shell = pkgs.zsh;
    createHome = true;
    home = "/home/nixos";
  };
}
