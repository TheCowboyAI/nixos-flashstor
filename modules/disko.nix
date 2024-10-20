{
  # eMMC
  # mmcblk0

  # m2.ssd
  # nvme0n1
  # nvme1n1
  # nvme2n1
  # nvme3n1
  # nvme4n1
  # nvme5n1
  # nvme6n1
  # nvme7n1
  # nvme8n1
  # nvme9n1
  # nvme10n1
  # nvme11n1

  # USB
  # sda

  # run `testme` to get information about the running config and installed hardware

  # Flashstor configuration:
  #   sysboot = bootable system disk
  #   zpool = a single zpool spanning all drives in raidz2
  # see /examples for other configurations

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

      # need to refactor this and loop... I have two ideas how.
      # nvme0n1
      nvme0n1 = {
        device = "/dev/nvme0n1";
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

      # nvme1n1
      nvme1n1 = {
        device = "/dev/nvme1n1";
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

      # nvme2n1
      nvme2n1 = {
        device = "/dev/nvme2n1";
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

      # nvme3n1
      nvme3n1 = {
        device = "/dev/nvme3n1";
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

      # nvme4n1
      nvme4n1 = {
        device = "/dev/nvme4n1";
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

      # nvme5n1
      nvme5n1 = {
        device = "/dev/nvme5n1";
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

      # nvme6n1
      nvme6n1 = {
        device = "/dev/nvme6n1";
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

      # nvme7n1
      nvme7n1 = {
        device = "/dev/nvme7n1";
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
}

