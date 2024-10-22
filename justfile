build:
sudo nix run 'github:nix-community/disko#disko-install' -- --write-efi-boot-entries --flake .#nixos-flashstor-iso --disk main /dev/sda

deploy:
nix run github:nix-community/nixos-anywhere -- --flake .#nixos-flashstor root@172.16.0.2
