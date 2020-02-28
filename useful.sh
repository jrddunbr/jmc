nix-env -iA nixos.<pkgname>
nixos-rebuild build
nixos-rebuild switch


# Home Manager stuff
home-manager edit
home-manager build
home-manager switch
