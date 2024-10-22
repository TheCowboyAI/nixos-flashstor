{
  description = "NixOS with MinIO for Asus Flashstor";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.05";
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, disko, nixpkgs, ... }@inputs: {
    nixosConfigurations = {
      # to boot and allow nixos-anywhere
      nixos-flashstor-iso = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit self; };
        modules = [
          disko.nixosModules.disko 
          ./modules/disko-sysboot.nix
          ./modules/nixos-anywhere.nix
        ];
      };
      # for nixos-anywhere to the emmc, emmc has quirks
      nixos-flashstor-emmc = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit self; };
        modules = [
          disko.nixosModules.disko 
          ./modules/disko-emmcboot.nix
          ./modules/disko-nas.nix
          ./configuration.nix
        ];
      };
      # for nixos-anywhere to a USB
      nixos-flashstor-usb = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit self; };
        modules = [
          disko.nixosModules.disko 
          ./modules/disko-sysboot.nix
          ./modules/disko-nas.nix
          ./configuration.nix
        ];
      };
    };
  };
}
