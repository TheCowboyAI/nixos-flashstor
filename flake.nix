{
  description = "NixOS with MinIO for Asus Flashstor";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.05";
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, disko, nixpkgs, ... }@inputs: {
    nixosConfigurations = {
      nixos-flashstor-iso = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit self; };
        modules = [
          disko.nixosModules.disko 
          ./modules/disko-sysboot.nix
          ./configuration.nix
        ];
      };
      nixos-flashstor = nixpkgs.lib.nixosSystem {
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

# sudo nix run 'github:nix-community/disko#disko-install' -- --write-efi-boot-entries --flake .#nixos-flashstor-iso --disk sysboot /dev/sda
# nix run github:nix-community/nixos-anywhere -- --flake .#nixos-flashstor root@172.16.0.2

