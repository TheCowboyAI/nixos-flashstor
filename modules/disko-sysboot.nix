{
  # This file is ONLY the system drive
  # We will be copying this to eMMC.
  # this is run on build and if you put the NAS config in here, 
  # you would have to build on the destination device.

  # NAS Settings are in disko-nas.nix

  disko.devices = {
    disk = {
      # the bootable drive...
      # this is aimed at USB as well as eMMC
      # we just copy it to eMMC when ready
      # this will become nixos on zfs root as well next iteration
      sysboot = {
        device = "/dev/sda";
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              type = "EF00";
              size = "500M";
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

