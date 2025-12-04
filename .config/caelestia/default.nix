{ pkgs, inputs, ... }:
{
  home-manager.users.vividskies = {
    home.packages = with pkgs; [
			# rev
			# lib
			# stdenv
			makeWrapper
			makeFontsConf
			fish
			ddcutil
			brightnessctl
			app2unit
			cava
			networkmanager
			lm_sensors
			grim
			swappy
			wl-clipboard
			libqalculate
			inotify-tools
			bluez
			bash
			hyprland
			coreutils
			findutils
			file
			material-symbols
			nerd-fonts
			gcc
			quickshell
			aubio
			pipewire
      inputs.caelestia-shell.packages.${stdenv.hostPlatform.system}.default
      inputs.caelestia-cli.packages.${stdenv.hostPlatform.system}.default
		];
  };
}
