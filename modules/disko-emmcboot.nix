{
  # This file is ONLY the system drive
  # We will be copying this to eMMC.
  # this is run on build and if you put the NAS config in here, 
  # you would have to build on the destination device.

  # NAS Settings are in disko-nas.nix

  # eMMC boots here, not the boot0/1 partitions
  disko.devices = {
    disk = {
      # the bootable drive...
      # this is aimed at USB as well as eMMC
      # we just copy it to eMMC when ready
      # this will become nixos on zfs root as well next iteration
      # name this different than sysboot or part-label gets confused when usb and emmc are both present
      emmcboot = {
        # this should be the secondary usb or emmc
        device = "/dev/mmcblk0";
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            MBR = {
              type = "EF02"; # for MBR
              size = "1M";
              priority = 1; # Needs to be first partition
            };
            ESP = {
              type = "EF00";
              size = "512M";
              content = {
                type = "filesystem";
                format = "vfat";
                mountOptions = [ "umask=0077" ]; # make it NOT world readable
                mountpoint = "/boot";
              };
            };

            root = {
              size = "100%";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/";
              };
            };
          };
        };
      };
    };
  };
}

