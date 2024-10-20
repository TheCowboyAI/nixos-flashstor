{ pkgs, ... }:
{
  services.minio = {
    enable = true;

    #package = "";
    region = "us-az-nutrioso";
    browser = true;

    listenAddress = "0.0.0.0";
    #consoleAddress = "";
    #configDir = "";
    dataDir = "/zdata";

    #secretKey = "";
    #accessKey = "";

    #rootCredentialsFile = "/etc/nixos/minio-root-credentials";
    # alternatively, we set these env vars
  };

  environment.variables = {
    MINIO_ROOT_USER = "admin";
    MINIO_ROOT_PASSWORD = "admin";
  };
}
