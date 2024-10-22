{ lib, ... }:
{
  services = {
    pcscd.enable = true;
    yubikey-agent.enable = true;
    nfs.server.enable = true;

    openssh = {
      enable = true;
      settings = {
        PermitRootLogin = lib.mkForce "yes";
        PasswordAuthentication = lib.mkForce true;
      };
    };
  };
}
