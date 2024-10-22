{ lib, pkgs, ... }:
{
  networking = {
    hostName = "minio";
    # we REQUIRE this for zfs 
    # 8 hexadecimal chars, unique in the network
    # CHANGE THIS
    hostId = "9f7c98b3";

    useDHCP = lib.mkDefault true;
    resolvconf.enable = false;
    dhcpcd.enable = true;
    useNetworkd = true;
    networkmanager.enable = true;
    wireless.enable = false;

    defaultGateway = {
      address = "172.16.0.1";
      interface = "enp1s0";
    };


    nameservers = [ "10.0.0.254" "1.1.1.1" ];

    # we should have a fixed IP
    interfaces = {
      enp1s0 = {
        useDHCP = false;
        ipv4.addresses = [
          {
            address = "172.16.0.2";
            prefixLength = 24;
          }
        ];
      };
    };

    # enable firewall and block all ports
    firewall.enable = true;
    # we will be using the default port
    firewall.allowedTCPPorts = [ 22 8000 8001 ];
    firewall.allowedUDPPorts = [ ];
  };
}
