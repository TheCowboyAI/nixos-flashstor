{
  # Flashstor configuration:
  #   sysboot = bootable system disk
  #   zpool = a single zpool spanning all drives in raidz2

  disko.devices = {
    disk = {
      # the bootable drive...
      # this is aimed at USB as well as eMMC
      # we just copy it to eMMC when ready
      sysboot = {
        device = "/dev/sda";
        type = "disk";
        content = {
          type = "gpt";
          partitions = {

            MBR = {
              type = "EF02"; # for grub MBR
              size = "1M";
              priority = 1; # Needs to be first partition
            };

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

  # this is enabled after booting

  data = {
    vda = {
      device = "/dev/vda";
      # everything below should be identical on all drives in a pool
      type = "disk";
      content = {
        type = "gpt";
        partitions = {
          zfs = {
            size = "100%";
            content = {
              type = "zfs";
              pool = "zdata";
            };
          };
        };
      };
    };

    zdata = {
      type = "zpool";
      mode = "raidz2";
      rootFsOptions = {
        compression = "zstd";
        "com.sun:auto-snapshot" = "false";
      };
      mountpoint = "/zdata";

      datasets = {
        zfs_fs = {
          type = "zfs_fs";
          mountpoint = "/zfs_fs";
        };
        zfs_testvolume = {
          type = "zfs_volume";
          size = "10M";
          content = {
            type = "filesystem";
            format = "ext4";
            mountpoint = "/ext4onzfs";
          };
        };
      };
    };
  };
}

