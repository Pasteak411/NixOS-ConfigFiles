
{ config,  lib,  pkgs, stable, old, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];
 
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  hardware.bluetooth.enable = true;

  time.timeZone = "Europe/Paris";
 
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "fr";
  #   useXkbConfig = true; # use xkb.options in tty.
  };

  services.printing.enable = true;
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };
  services.libinput.enable = true;
  services.tuned.enable = true;
  services.upower.enable = true;
  
  services.flatpak.enable = true;
  services.displayManager.ly.enable = true;
  programs.sway.enable = true;
  programs.hyprland.enable = true;

  users.users.pasteak = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    packages = [
        # Creation
	pkgs.gimp

	# Games
	stable.lutris
	pkgs.heroic
        
	# Utils

        pkgs.firefox
	pkgs.librewolf
	pkgs.kitty
	pkgs.yofi
	pkgs.yazi
	pkgs.tree
	stable.bottles
	pkgs.zip
	stable.unzip
	pkgs.unrar	

	# Coding

	pkgs.vscodium

	# Misc

	pkgs.fastfetch
	pkgs.btop
	pkgs.grim
	pkgs.slurp

	# Rice

	pkgs.noctalia-shell
	pkgs.quickshell
    ];
  };

  environment.systemPackages = with pkgs; [
    wget
    git
    # lutris
    nautilus
    yazi

  ];

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    maple-mono.truetype
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;
  # pkgs-stable = import <nixpkgs-stable> { config.allowUnfree = true; };
  system.stateVersion = "25.11";

}

