# Scripts
These scripts will live in the Nix store and are available in the path

## backup-emmc
backup the current eMMC to an image at: $EMMC_IMAGE, defaulting to: /home/nixos/adm-image.img

the device itself is stored in $EMMC_DEVICE
default: /dev/mmcblk0

this should never have to change.