{ pkgs, ... }:
{
  services.minio = {
    enable = "";

    #package = "";
    region = "us-az-nutrioso";
    browser = true;

    listenAddress = "0.0.0.0";
    #consoleAddress = "";
    #configDir = "";
    #dataDir = "";

    #secretKey = "";
    #rootCredentialsFile = "";
    #accessKey = "";
  };
}