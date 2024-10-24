build:
  sudo nix run "github:nix-community/disko#disko-install" -- --flake .#nixos-flashstor-iso --disk sysboot /dev/sda 2>&1 | tee logs/build-$(date +%Y%m%d-%H%M%S).txt

deploy:
  nix run "github:nix-community/nixos-anywhere" -- --flake .#nixos-flashstor-usb root@172.16.0.2 2>&1 | tee logs/deploy-$(date +%Y%m%d-%H%M%S).txt

deploy-emmc:
  nix run "github:nix-community/nixos-anywhere" -- --flake .#nixos-flashstor-emmc root@172.16.0.2 2>&1 | tee logs/deploy-emmc-$(date +%Y%m%d-%H%M%S).txt

rebuild:
  nixos-rebuild switch --flake .#nixos-flashstor-usb --target-host root@172.16.0.2 2>&1 | tee logs/rebuild-$(date +%Y%m%d-%H%M%S).txt

rebuild-emmc:
  nixos-rebuild switch --flake .#nixos-flashstor-emmc --target-host root@172.16.0.2 2>&1 | tee logs/rebuild-emmc-$(date +%Y%m%d-%H%M%S).txt
