# Examples
These are different example configurations for ZFS

# Default
Our default configuration is:
  nixos root on ZFS loaded on eMMC
  luks encrypted raidz2 pool on /zdata

to get to the default, we first must boot to usb and change the BIOS.

Start the flashstor with a monitor and keyboard plugged.
immediately start hitting F2 until thge BIOS appears

## Change the Boot Order
set USB in first position

save and reboot

once in the NixOS environment, login as nixos/minio

run the tests...

```bash
testme
```

if you want a copy of what is on the eMMC: 

```bash
backup-emmc

```
The backup will be written to the USB device in /home/nixos

install to the eMMC: 

```bash
install-emmc

```

reboot.

again go to the BIOS by hitting F2

Change the boot order to eMMC first

