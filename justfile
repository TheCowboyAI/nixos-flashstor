build:
sudo nix run 'github:nix-community/disko#disko-install' -- --write-efi-boot-entries --flake .#nixos-flashstor-iso --disk main /dev/sda

deploy:
nix run github:nix-community/nixos-anywhere -- --flake .#nixos-flashstor root@172.16.0.2

deploy-emmc:
nix run github:nix-community/nixos-anywhere -- --flake .#nixos-flashstor-emmc root@172.16.0.2

rebuild:
nixos-rebuild switch --flake .#nixos-flashstor --target-host root@172.16.0.2
