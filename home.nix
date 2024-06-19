{ config, pkgs, ... }:

{
  home.username = "fredrik";
  home.homeDirectory = "/home/fredrik";

  # link the configuration file in current directory to the specified location in home directory
  # home.file.".config/i3/wallpaper.jpg".source = ./wallpaper.jpg;

  # link all files in `./scripts` to `~/.config/i3/scripts`
  # home.file.".config/i3/scripts" = {
  #   source = ./scripts;
  #   recursive = true;   # link recursively
  #   executable = true;  # make all files executable
  # };

  # encode the file content in nix configuration file directly
  # home.file.".xxx".text = ''
  #     xxx
  # '';

  # set cursor size and dpi for 4k monitor
  xresources.properties = {
    "Xcursor.size" = 16;
    "Xft.dpi" = 172;
  };

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    hyprland
    waybar
    wofi
    alacritty

    # System Monitoring
    btop                # Resource monitor (replacement for htop/nmon)
    iotop               # IO monitoring
    iftop               # Network monitoring
    strace              # System call monitoring
    ltrace              # Library call monitoring
    lsof                # List open files
    sysstat             # Performance monitoring tools
    lm_sensors          # Hardware health monitoring (sensors command)
    pciutils            # Tools for listing and manipulating PCI devices (lspci)
    usbutils            # USB device listing (lsusb)

    # Networking Tools
    dig                 # DNS lookup utility
    mtr                 # Network diagnostic tool
    iperf3              # Network bandwidth measurement tool
    dnsutils            # DNS utilities (`dig` + `nslookup`)
    ldns                # DNS utilities replacement (`drill`)
    aria2               # Multi-protocol & multi-source download utility
    socat               # Data relay between two addresses
    nmap                # Network discovery and security auditing tool
    ethtool             # Ethernet device configuration

    # Archives
    zip                 # ZIP file compression utility
    xz                  # XZ file compression utility
    unzip               # ZIP file extraction utility
    p7zip               # 7-Zip file archiver

    # Utilities
    git                 # Version control system
    ripgrep             # Recursively searches directories for a regex pattern
    jq                  # Command-line JSON processor
    yq-go               # YAML processor
    eza                 # Modern replacement for 'ls'
    fzf                 # Command-line fuzzy finder
    which               # Utility to locate executables
    tree                # Directory listing in a tree-like format
    direnv              # Environment switcher for shell
    betterbird          # Enhanced version of Mozilla Thunderbird email client
    ansible             # Configuration management and automation tool
    wireguard-tools     # Tools for the WireGuard VPN
    yubikey-manager-qt  # Manager for YubiKey hardware authentication devices
    deluge-gtk          # BitTorrent client with GTK interface
    tldr                # Simplified and community-driven man pages
    flameshot           # Screenshot tool
    obsidian            # Markdown-based note-taking app
    wezterm             # GPU-accelerated terminal emulator
    neovim              # Advanced text editor

    # Virtualization
    virt-manager        # Virtual machine manager
    libvirt             # Toolkit for managing virtualization platforms
    virt-viewer         # Viewer for SPICE and VNC virtualized desktops
    OVMFFull            # UEFI firmware for virtual machines
    virtiofsd           # Virtio Filesystem daemon

    # Theme
    (nerdfonts.override { fonts = [ "FiraCode" "JetBrainsMono" ]; })  # Nerd Fonts with FiraCode and JetBrainsMono

    # Communication
    discord             # Communication app for voice, video, and text
    caprine-bin         # Unofficial desktop client for Facebook Messenger
    quassel             # Distributed IRC client

    # Media
    spotify             # Music streaming service
    mpv                 # Media player
    plexamp             # Music player for Plex
    plex-media-player   # Media player for Plex

    # Gaming
    lutris              # Gaming platform for Linux
    xivlauncher         # Custom launcher for Final Fantasy XIV
  ];

  xdg.configFile = {
    "hypr/hyprland.conf".text = ''
      # Hyprland configuration content
      monitor = DisplayPort-1, 3840x1600@144, 0x0
      exec-once = waybar
    '';
  };

  programs.git = {
    enable = true;
    userName = "Fredrik Kihlstedt";
    userEmail = "fredrik@kihlstedt.io";
  };

  programs.starship = {
    enable = true;
    # custom settings
    settings = {
      add_newline = false;
      aws.disabled = true;
      gcloud.disabled = true;
      line_break.disabled = true;
    
      character = {
        success_symbol = "[➜](bold green)";
        error_symbol = "[➜](bold red)";
      };
    };
  };
  programs.alacritty = {
    enable = true;
    # custom settings
    settings = {
      env.TERM = "xterm-256color";
      font = {
        size = 12;
        draw_bold_text_with_bright_colors = true;
      };
      scrolling.multiplier = 5;
      selection.save_to_clipboard = true;
    };
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;
    # TODO add your custom bashrc here
    bashrcExtra = ''
      export PATH="$PATH:$HOME/bin:$HOME/.local/bin:$HOME/go/bin"
    '';

    # set some aliases, feel free to add more or remove some
    shellAliases = {
      k = "kubectl";
      urldecode = "python3 -c 'import sys, urllib.parse as ul; print(ul.unquote_plus(sys.stdin.read()))'";
      urlencode = "python3 -c 'import sys, urllib.parse as ul; print(ul.quote_plus(sys.stdin.read()))'";
    };
  };

  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "24.05";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
