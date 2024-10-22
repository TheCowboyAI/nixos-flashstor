{ pkgs }:
# this is an 8GB image, be sure to have enough room before starting
pkgs.writeShellScriptBin "backup-emmc" ''
export EMMC_DEVICE=/dev/mmcblk0
export EMMC_IMAGE=/home/nixos/adm-image.img
sudo dd if=''${EMMC_DEVICE} of=''${EMMC_IMAGE} bs=16M
''