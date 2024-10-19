{ lib, pkgs, ... }:
{
    networking = {
    hostName = "minio";
    # we REQUIRE this for zfs 
    # 8 hexadecimal chars, unique in the network
    hostId = "9f7c98b3";

    useDHCP = lib.mkDefault true;
    resolvconf.enable = false;
    dhcpcd.enable = true;
    useNetworkd = true;
    networkmanager.enable = true;
    wireless.enable = false;
    
    # we should have a fixed IP
    interfaces = { };

    # enable firewall and block all ports
    firewall.enable = true;
    firewall.allowedTCPPorts = [ 22 8000 8001 ];
    firewall.allowedUDPPorts = [ ];
  };
}