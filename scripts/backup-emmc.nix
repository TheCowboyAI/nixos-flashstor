{ pkgs }:
# this is an 8GB image, be sure to have enough room before starting
pkgs.writeShellScriptBin "backup-emmc" ''
sudo dd if=/dev/mmcblk0 of=/home/nixos/adm-image.img bs=16M
''