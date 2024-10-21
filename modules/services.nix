{ lib, ... }:
{
  services = {
    openssh.enable = lib.mkForce true;
    pcscd.enable = true;
    yubikey-agent.enable = true;
    nfs.server.enable = true;
  };
}
