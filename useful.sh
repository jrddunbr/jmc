# Don't use the following if you plan to use Home Manager
nix-env -iA nixos.<pkgname>

# These are for the OS.
nixos-rebuild build
sudo nixos-rebuild switch

# Edit them like this
sudo vim /etc/nixos/configuration.nix

# Home Manager stuff
home-manager edit
home-manager build
home-manager switch

# Protip - may want to add export EDITOR=vim before running home-manager edit
