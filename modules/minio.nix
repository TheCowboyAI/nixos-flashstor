{ pkgs, lib, ... }:
{
  services.minio = {
    enable = true;

    region = "us-az-nutrioso";
    browser = true;

    listenAddress = "172.16.0.2";
    
    #point to a zpool
    dataDir = [ "/zroot" ];

    rootCredentialsFile = "/etc/minio-root-credentials";
  };

  environment.etc."minio-root-credentials" = {
    mode = "0644";
    text = builtins.readFile ./minio-root-credentials;
  };
  # we need an SSL Certificate for minio
}
