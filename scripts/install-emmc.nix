{ pkgs }:
# we are using /dev/sdb as an example
# the eMMC is only 8GB, don't plan to store much there
# we really only want the nix/store there.
# you should use another logging device, such as external usb
pkgs.writeShellScriptBin "install-emmc" ''
//TODO, basically dd to /dev/mmcblk0, but we need to establish where the image is.
''