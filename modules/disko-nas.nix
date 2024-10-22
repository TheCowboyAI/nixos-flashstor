{
  # This file is ONLY the NAS drives and is invoked on boot
  boot.zfs.forceImportRoot = true;
  boot.zfs.extraPools = [ "zdata" ];

  disko.devices =
    let
      # Define a base template for a drive with ZFS configuration
      drive = { devicePath, poolName }: {
        type = "disk";
        device = devicePath;
        content = {
          type = "gpt";
          partitions = {
            zfs = {
              size = "100%";
              content = {
                type = "zfs";
                pool = poolName;
              };
            };
          };
        };
      };
    in
    {
      # not dry, but looping this is really weird in nix
      # comment out any unpopulated drives
      disk = {
         nvme0n1 = drive { devicePath =  "/dev/nvme0n1"; poolName = "zroot"; };
         nvme1n1 = drive { devicePath =  "/dev/nvme1n1"; poolName = "zroot"; };
         nvme2n1 = drive { devicePath =  "/dev/nvme2n1"; poolName = "zroot"; };
         nvme3n1 = drive { devicePath =  "/dev/nvme3n1"; poolName = "zroot"; };
         nvme4n1 = drive { devicePath =  "/dev/nvme4n1"; poolName = "zroot"; };
         nvme5n1 = drive { devicePath =  "/dev/nvme5n1"; poolName = "zroot"; };
         nvme6n1 = drive { devicePath =  "/dev/nvme6n1"; poolName = "zroot"; };
         nvme7n1 = drive { devicePath =  "/dev/nvme7n1"; poolName = "zroot"; };
         nvme8n1 = drive { devicePath =  "/dev/nvme8n1"; poolName = "zroot"; };
         nvme9n1 = drive { devicePath =  "/dev/nvme9n1"; poolName = "zroot"; };
        nvme10n1 = drive { devicePath = "/dev/nvme10n1"; poolName = "zroot"; };
        nvme11n1 = drive { devicePath = "/dev/nvme11n1"; poolName = "zroot"; };
        #sda = drive { devicePath = "/dev/sda"; poolName = "zroot"; }; # Adding USB drive if needed
      };

      zpool = {
        zroot = {
          type = "zpool";
          mode = "raidz2";
          rootFsOptions = {
            compression = "zstd";
            "com.sun:auto-snapshot" = "false";
          };
          mountpoint = "/zroot";
          datasets = {
            zfs_fs = {
              type = "zfs_fs";
              mountpoint = "/zfs_fs";
              options."com.sun:auto-snapshot" = "true";
            };
            # encrypted = {
            #   type = "zfs_fs";
            #   options = {
            #     mountpoint = "none";
            #     encryption = "aes-256-gcm";
            #     keyformat = "passphrase";
            #     keylocation = "file:///tmp/secret.key"; #need a nix path
            #   };
            #   # use this to read the key during boot
            #   # postCreateHook = ''
            #   #   zfs set keylocation="prompt" "zroot/$name";
            #   # '';
            # };
          };
        };
      };
    };
}
