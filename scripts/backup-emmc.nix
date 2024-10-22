{ pkgs }:
# this is an 8GB image, be sure to have enough room before starting
pkgs.writeShellScriptBin "backup-emmc" ''
export EMMC_DEVICE=/dev/mmcblk0
export EMMC_IMAGE=/home/nixos/adm-image.img.gz
sudo dd if=''${EMMC_DEVICE} | gzip --fast >> ''${EMMC_IMAGE}
''