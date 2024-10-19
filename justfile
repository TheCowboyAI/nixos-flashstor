build:
sudo nix run 'github:nix-community/disko#disko-install' -- --write-efi-boot-entries --flake .#nixos-flashstor --disk main /dev/sda