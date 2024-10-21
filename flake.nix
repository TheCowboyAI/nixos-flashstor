{
  description = "NixOS with MinIO for Asus Flashstor";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.05";
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, disko, nixpkgs, ... }@inputs: {
    nixosConfigurations = {
      nixos-flashstor = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          disko.nixosModules.disko
          ./modules/disko-sysboot.nix
          #./modules/disko-nas.nix
          ./configuration.nix
        ];
      };
    };
  };
}

# sudo nix run 'github:nix-community/disko#disko-install' -- --write-efi-boot-entries --flake <flake-url>#<flake-attr> --disk <disk-name> <disk-device>

