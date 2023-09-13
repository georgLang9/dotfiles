{ config, pkgs, ... }:

{
	home.username = "bonesaw";
	home.homeDirectory = "/home/bonesaw";

	programs.git = {
		enable = true;
	};

	home.packages = with pkgs; [
	];

	home.files.".config/nvim" = {
		source = ../.config/nvim;
		recursive = true;
		executable = true;
	};

	programs.neovim = {
		enable = true;
		viAlias = true;
		vimAlias = true;
	};
}
