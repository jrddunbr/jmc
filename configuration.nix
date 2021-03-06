# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.memtest86.enable = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostId = "8425e349";
  networking.hostName = "jrd-ryzen"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.enp4s0.useDHCP = true;
  # networking.interfaces.wlp3s0.useDHCP = false;

  networking = {
    vlans = {
      v5_dhcp = {
        id = 5;
        interface = "enp4s0";
      };
      v7_mgmt = {
        id = 7;
        interface = "enp4s0";
      };
      v8_servers = {
        id = 8;
        interface = "enp4s0";
      };
    };
    bridges = {
      br5_dhcp.interfaces = [ "v5_dhcp" ];
      br7_mgmt.interfaces = [ "v7_mgmt" ];
      br8_servers.interfaces = [ "v8_servers" ];
    };
  };


  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  console.font = "Lat2-Terminus16";
  console.keyMap = "us";
  i18n.defaultLocale = "en_US.UTF-8";
  

  # Set your time zone.
  time.timeZone = "America/New_York";

  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    wget vim gnome3.adwaita-icon-theme git memtest86-efi
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  #   pinentryFlavor = "gnome3";
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Enable the libvrit daemon
  virtualisation.libvirtd.enable = true;
  
  # Required for the Yubikey to work in Firefox
  services.udev.packages = [ pkgs.libu2f-host ];

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 22 ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = true;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable touchpad support.
  # services.xserver.libinput.enable = true;

  # Enable the KDE Desktop Environment.

  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome3.enable = true;

  # services.xserver.displayManager.sddm.enable = true;
  # services.xserver.desktopManager.plasma5.enable = true;

  # Wireshark!
  programs.wireshark.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users = {
    jared = {
      isNormalUser = true;
      extraGroups = [ "wheel" "libvirtd" "wireshark"];
    };
    svein = {
      isNormalUser = true;
      extraGroups = [ "wheel" "libvirtd" "wireshark"];
      openssh.authorizedKeys.keys = [ "cert-authority ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGfsmAbJ1GKytVA71izC3xvIFYDQVHT2Q5CZPaIA6WqS svein@tsugumi" ];
    };
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.03"; # Did you read the comment?

}

