{ lib, config, pkgs, modulesPath, agenix, ... }:
{
  system.stateVersion = "24.05";
  system.copySystemConfiguration = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  imports =
    [
      "${modulesPath}/profiles/hardened.nix"
      ./hardware-configuration.nix
      ./disko.nix
    ];

  networking.hostName = "minio";
  # we should have a fixed IP
  networking = {
    useDHCP = true;
    resolvconf.enable = false;
    dhcpcd.enable = true;
    useNetworkd = true;
    networkmanager.enable = true;
    wireless.enable = false;
    interfaces = { };

    # enable firewall and block all ports
    firewall.enable = true;
    firewall.allowedTCPPorts = [ 22 8000 8001 ];
    firewall.allowedUDPPorts = [ ];
  };

  # disable coredump that could be exploited later
  # and also slow down the system when something crash
  systemd.coredump.enable = false;

  services.openssh.enable = lib.mkForce true;

  # System packages
  environment.systemPackages = with pkgs; [
    nmtui
    cryptsetup
    git
    just
    gitAndTools.git-extras
    gnupg
    pcsclite
    pinentry-curses
    pwgen
    gpg-tui
    openssh
    age-plugin-yubikey
    piv-agent
    (import ./test-keys.nix { inherit pkgs; })
  ];

  services.udev.packages = with pkgs; [
    yubikey-personalization
    libu2f-host
  ];

  services.pcscd.enable = true;
  services.yubikey-agent.enable = true;

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    settings = {
      personal-cipher-preferences = "AES256 AES192 AES";
      personal-digest-preferences = "SHA512 SHA384 SHA256";
      personal-compress-preferences = "ZLIB BZIP2 ZIP Uncompressed";
      default-preference-list = "SHA512 SHA384 SHA256 AES256 AES192 AES ZLIB BZIP2 ZIP Uncompressed";
      cert-digest-algo = "SHA512";
      s2k-digest-algo = "SHA512";
      s2k-cipher-algo = "AES256";
      charset = "utf-8";
      no-comments = true;
      no-emit-version = true;
      no-greeting = true;
      keyid-format = "0xlong";
      list-options = "show-uid-validity";
      verify-options = "show-uid-validity";
      with-fingerprint = true;
      require-cross-certification = true;
      no-symkey-cache = true;
      armor = true;
      use-agent = true;
      throw-keyids = true;
    };
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      ll = "ls -la";
    };

    histSize = 10000;
    #loginShellInit = " ";
  };
}
