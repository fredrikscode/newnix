# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking = {
    hostName = "nixed";
    networkmanager.enable = true;
  };

  hardware = {
    opengl.enable = true;
  };

  time.timeZone = "Europe/Stockholm";

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "sv_SE.UTF-8";
      LC_IDENTIFICATION = "sv_SE.UTF-8";
      LC_MEASUREMENT = "sv_SE.UTF-8";
      LC_MONETARY = "sv_SE.UTF-8";
      LC_NAME = "sv_SE.UTF-8";
      LC_NUMERIC = "sv_SE.UTF-8";
      LC_PAPER = "sv_SE.UTF-8";
      LC_TELEPHONE = "sv_SE.UTF-8";
      LC_TIME = "sv_SE.UTF-8";
    };
  };

  # Configure console keymap
  console.keyMap = "sv-latin1";

  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
    };
  };

  xdg = {
    portal = {
      enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    };
  };

  services = {
    xserver = {
      enable = false;
      xkb.layout = "se";
      xkb.options = "eurosign:e,caps:escape";
      displayManager = {
        gdm.enable = true;
      };
    };

    openssh.enable = true;

    printing.enable = true;
    libinput.enable = true;

    pipewire = {
      enable = true;
      pulse.enable = true;
    };
  };

  programs = {
    hyprland.enable = true;
  };

  environment = {
    variables = {
      EDITOR = "vim";
    };

    systemPackages = with pkgs; [
      (waybar.overrideAttrs (oldAttrs: {
        mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
      }))
      mako
      libnotify
    ];
  };

  users.users.fredrik = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDPZWRBkupqQeWbky3ykU1+QkWzFO6n2MFTdDS2H3JLItm1dzTNZ1erl9TBcqI1OvBBZkitles1R4ktH83GtncC/7hC1FEVX5U4uaxkxorAszmdn10f4bkeWdUtrHZEcLENN7gPbkvolLFvt8rNfnVIp5GhUFvS8Xl3KN2tLX+N+07LJpC36ASccXOeFvKBwvgXOKdJ8/OO3NcaMRWOahXwe1eWdQedO6QFLGtX/iRmA875osp7BkiV+MEb04a43GhqwWmebLaANSphi6mlnC2/3BT8E4knPxpOD7KbRz/1KYGKpsWQoQBNxWjy8WjX/LOVEM4WzeQCWVVIgjSHOK1WbeA6mMsqLqTDDUz9nR8nHm7HDRh5cFplL7dE7XtzmrsFDq30B3wA6WmwF5PWmjvwq2ggy9Nnpnfwv99jBkB4geFj9/pk4bwIIHPDdIt1mApp5iomoDQynN4OZ7wNuthPARfLEWqghNPdNjo6xwtAUSUBu8mTrkPfCJEIqgkYMFH5amRTyo+MHfoHYQM++/ELLLYlEj4YQn2yMqvwd43GH9qIWiXWtg/VbnaMecBasNgJcPl+J0Ad+gYL9FLO1h2sMlLIjFSdl6a+eQsTFHiASnTUta2rq6vF9CiMG40cjh8OdcKJzftP9tETD4Jvo6AyYc2KS/yp2AmRZUd7mVtFXw== fredrik"
    ];
    packages = with pkgs; [
      vim
      curl
      git
      wget
    ];
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.05"; # Did you read the comment?

}
