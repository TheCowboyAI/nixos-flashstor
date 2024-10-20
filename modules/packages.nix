{ pkgs, ... }:
{
  # System packages
  environment.systemPackages = with pkgs; [
    nvme-cli
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
    (import ../tests/test-flashstor.nix { inherit pkgs; })
  ];
}
