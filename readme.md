# NixOS Configuration for Asus Flashstor FS6712X
Provide reliable Network Attached Storage as a deterministic solution.

## **CAUTION** - This will destroy data

If I buy more storage devices, I want to configure them prior to adding them to the network for general use.

Having a solution to pre-configure our storage solutions and tune them specifically to our needs is important.

Nix is how we intend to do this of course.

## The License Thing...
There is an ongoing license dispute over zfs and the linux kernel... If this make you extremely uncomfortable, we have a solution.

There is a [branch](https://github.com/thecowboyai/nixos-flashstor/tree/nixbsd) of this repository running everything on [NixBSD](https://github.com/nixos-bsd/nixbsd).

When we determine it to be completely stable we will merge it into the main branch as a configurable option.

## Flashstor 12
This is a network appliance.

This means you take it out of the box, plug it in and it starts working. Typically, this also means you sit down and manually configure the device. Aside from inserting hardware (drives and memory), we also need to configure software.

What if I have 10 of them? Ok, how about just 2.
I really don't want to repeat everything.
This is one of the reasons we like NixOS in the first place. I set it up once and deploy it at will.

Sure we can use a supported tool such as the out-of-the-box system, Unfortunately, ASUSTOR Data Manager (ADM) doesn't support ZFS, or we could upgrade to TrueNAS or UnRaid. These are all fine solutions, but don't fit well into a NixOS Ecosystem that is all deterministic.

This guide doesn't plan to run Containers on the Flashstor itself, we only want to use it for Storage. TrueNAS and Unraid support this. You can certainly add it.

For our system, Containers run on other Worker Nodes and we only need to make a massive amount of storage available to our network.

Specifically we want to support S3 and Kubernetes and make storage available as a Network Device.

We also want a seamless way to replicate our Object Stores.
This we do with S3 Buckets on MinIO.

If you want to run other software, of course you can, and you can set it all up just like any other nixosConfiguration.

If we want to add anything, such as Grafana we can do that in a NixOS Module and maintain our consistency.

Instead of simply flashing the eMMC, we want to be able to test the system before use.  We also want to backup the current system before overwriting it.

We will create an ISO that we place onto a bootable USB device and test the system before flashing the eMMC. This can also be tested in a VM, we can emulate the system and see the drives gather into a zpool.

The ISO will be a fully installed system, not an installer we need to run. (though it will let you populate and backup the eMMC)

This "flake" IS the installer.

We will be using both [Disko](https://github.com/nix-community/disko) and [nixos-anywhere](https://github.com/nix-community/nixos-anywhere) to accomplish our goal. Once we have NixOS running on the Flashstor, updates are simply done with "nixos-rebuild switch" using the switch for a remote machine. We include a justfile for all these commands, i.e. just rebuild... just makeiso... just installiso /dev/sda

The are also maintenance scripts available for the eMMC, and output to a screen/audio.

The Machine:
  - x86 (using Intel Quad Core Celeron - N5105)
  - 4Gb RAM (you want to upgrade this for better caching)
    - Technically, the cpu only supports 16G, but it has been tested as working with 64
  - hdmi out for video
  - audio out
  - ethernet card
  - usb for keyboard
  - usb bootable
  - eMMC bootable
  - network bootable, we will look into that in a later version

So in effect, NixOS, sees this as any other x86 machine.
We just need to tune it for things like Power Management, Network, Disks, eMMC, etc.

Disko lets us configure the drive layout, we have:

- USB
  - 2 USB 3.2 Gen 2 ports (for more storage if desired)
  - 2 USB 2.0 Ports 
- m2.SSD
  - 12 m2 Slots
- eMMC
  - eMMC Flash Storage for the OS (currently occupied by Asus Software)

These are all setup in normal Nix files as modules.

We will boot from USB and assign available drives using [openZFS](https://openzfs.org/wiki/Main_Page)

We also install [MinIO](https://min.io/) to support Object Stores (S3) and Kubernetes operator integration.

MinIO is already available as a service in NixOS.

We want to setup replication to a cloud provider. We chose [Wasabi](https://wasabi.com/), but any Block Storage Provider works by changing the configuration.

## flake.nix
This flake sets all the required inputs.

## configuration.nix
Flashstor configuration modules enabled

## hardware-configuration.nix
Flashstor hardware specific module

## networking.nix
Network specific settings

## packages.nix
Packages to include
Packages have no included NixOS configuration settings
These are ready for use, but should be modularized as significant configuration may be required, adding it as a module helps keep components organized.

## programs.nix
NixOS Programs to include
These programs have specified [options](https://search.nixos.org/options?channel=unstable&from=0&size=50&sort=alpha_asc&type=packages&query=programs.) and conversions already enabled as a module in NixOS

## services.nix
NixOS Services to include
These [services](https://search.nixos.org/options?channel=unstable&from=0&size=50&sort=alpha_asc&type=packages&query=services.) have specified options and conversions already enabled as a module in NixOS

## disko.nix
[disko](https://github.com/nix-community/disko) Disk Layout module
This sample uses a system disk and a zpool for all the M2 SSDs, it will install to a USB device, and has the command-line option to backup or write our image to the eMMC

## users.nix
User specific settings module, root passwords, etc.

## minio.nix
MinIO specific settings module

# Installation

This is the tested process.

1.  boot to a non-gui nixos installer image (or the iso here)
    -  we want to avoid kexec when running nixos-anywhere
    -  to make an image, execute ```just build``` with a usb device of at least 16GB (so we can backup the 8G eMMC)
    -  we ALSO need a second device (/dev/sdb) in install to
    -  because we can't overwite a mounted drive.
    -  we could decide to [install straight to eMMC](installtoemmc.md)
2.  set the network IPs (172.16.0.2)
    -  we want a fixed ip, you may want it in a secured dmz.
3.  create a network port to access 172.16.0.2 from your installation device
    -  plug in the flashstor network into this port
4.  plug the usb device(s) into the flashstor
5.  turn on the flashstor and boot to usb  
    - if you pluggeed in a keyboard and monitor, you can see it boot
    - hit F2 on boot to see the BIOS Menu
    - set boot the usb first
6.  ping 172.16.0.2
    -  you need to be able to access this device
7.  on the build device:
    - execute ```just deploy```
    - this will install the system to /dev/sda, the usb device (which it will overwrite) and create a zpool with the 12 drives, ready for MinIO.
8.  
9.  test the deployment
    - execute ```just test```  
    - see if you can reach MinIO at https://172.16.0.2:9001
10.  if satisfied with the deployment:
    1.  backup eMMC (optional)
        - execute ```backup-emmc``` on the NAS
    3.  reboot
    4.  hit F2 on boot to see the BIOS Menu, or in the NixOS menu choose boot to firmware
        - set boot the eMMC to writable
    5. reboot
    6. execute ```just deploy```
    7. set eMMC to be first in boot order
    8.  reboot into working system
    9.  store your drives somewhere safe, or overwrite them as they contain sensitive information.

# Maintenance
to updatre the system, change the repository item, comit them and execute ```just rebuild```

this is just a wrapper for 
```bash
nixos-rebuild switch --flake .#nixos-flashstor --target-host root@172.16.0.2
```

## MinIO
There are several things we want to do to MinIO

We would like this do already be setup.
editing minio.nix is the best way to achieve this.
If we are experimenting, that is one thing, but if we need to rebuild, we should have a way to do so.

Our technique is to have auto-replication set for Wasabi.
This will mirror everything in the Object Stores to Wasabi and allow you to recover by reformatting the NAS and importing all the replicated Object Stores.

**NOTE:** You don't want to do this often, it will take days to restore many TB of data, this is a disaster recovery option, not a regular workflow.

## Wasabi Replication