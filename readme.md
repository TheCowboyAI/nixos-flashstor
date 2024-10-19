# NixOS Configuration for Asus Flashstor FS6712X
Provide reliable Network Attached Storage as a deterministic solution.

If I buy more storage devices, I want to configure them prior to adding them to the network for general use.

Having a solution to pre-configure our storage solutions and tune them specifically to our needs is important.

Nix is how we intend to do this of course.

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

We will create an ISO that we place onto a bootable USB device and test the system before flashing the eMMC. This can also be tested in a VM, but not very well, just to see the system and not the drives.

The ISO will be a fully installed system, not an installer we need to run. (though it will let you populate and backup the eMMC)

This "flake" IS the installer.

We will be using both [Disko](https://github.com/nix-community/disko) and [nixos-anywhere](https://github.com/nix-community/nixos-anywhere) to accomplish our goal. Once we have NixOS running on the Flashstor, updates are simply done with "nixos-rebuild switch" using the switch for a remote machine. We include a justfile for all these commands, i.e. just rebuild... just makeiso... just installiso /dev/sda

The Machine:
  x86 (using intell Quad Core Celeron - N5105)
  4Gb RAM (you want to upgrade this for better caching)
  hdmi out for video
  ethernet card
  usb for keyboard

So in effect, NixOS, sees this as any other x86 machine.
We just need to tune it for things like Power Management, Network, etc.

Disko lets us configure the drive layout, we have:

- USB
  - 2 USB 3.2 Gen 2 ports (for more storage if desired)
  - 2 USB 2.0 Ports 
- m2.SSD
  - 12 m2 Slots
- eMMC
  - eMMC Flash Storage for the OS (currently occupied by Asus Software)

These are all setup in normal Nix files.

We will boot from USB and assign available drives using [openZFS](https://openzfs.org/wiki/Main_Page)

We also install [MinIO](https://min.io/) to support Object Stores (S3) and Kubernetes operator integration.
This is already available as a service in NixOS.

We want to setup replication to a cloud provider. We chose [Wasabi](https://wasabi.com/), but any Block Storage Provider work with by changing the configuration.

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
These are ready for use, but should be modularized as significant convifuration may be required

## programs.nix
NixOS Programs to include
These programs have specified options and conversions already enabled as a module in NixOS

## services.nix
NixOS Services to include
These services have specified options and conversions already enabled as a module in NixOS

## disko.nix
Disk Layout module
This sample uses a system disk and a zpool for all the M2 SSDs
## users.nix
User specific settings module, root passwords, etc.

## minio.nix
MinIO specific settings module