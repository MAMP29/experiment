{
  description = "Configuracion inicial NixOS 25.11 Xantusia para VM";

  inputs = {
    # Usamos el canal oficial de la version 25.11 (Xantusia)
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";

    # Home Manager siguiendo la misma rama
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: {
    nixosConfigurations.nixos-vm = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        ./configuration.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.tu_usuario = import ./home.nix;
        }
      ];
    };
  };
}