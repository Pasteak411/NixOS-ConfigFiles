{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-old.url = "github:nixos/nixpkgs/nixos-24.11";
    # lutris.url = "github:nixos/nixpkgs/nixos-26.05/pkgs/by-name/lu/lutris"
  };

  outputs = { self, nixpkgs, nixpkgs-stable, nixpkgs-old }: {

      packages.x86_64-linux.hello = nixpkgs.legacyPackages.x86_64-linux.hello;
      packages.x86_64-linux.default = self.packages.x86_64-linux.hello;

      nixosConfigurations = {
        nixos = nixpkgs.lib.nixosSystem {
	  specialArgs = let 
	    system = "x86_64-linux";
	  in {
	    stable = import nixpkgs-stable {
	      inherit system;
	      config.allowUnfree = true;
            };

	    old = import nixpkgs-old {
	      inherit system;
	      config.allowUnfree = true;
	    };
          };
          modules = [
            ./configuration.nix
          ];
        };
      };
    };
}
