{pkgs, ...}: {
  imports = [
    ../../home
    ../../home/librewolf
    ../../home/wezterm
    ../../home/zathura
    ../../home/gtk
    ../../home/dunst
    ../../home/lf
    ../../home/zellij
    ../../home/waybar
    ../../home/wayland/hyprland
    ../../modules/swayidle.nix
  ];

  systemd.user.startServices = "sd-switch";
  programs.home-manager.enable = true;

  home = {
    username = "cellis";
    homeDirectory = "/home/cellis";
    packages = with pkgs; [
      (callPackage ../../pkgs/chatterino7 {})
      chromium
      bitwarden
      discord
      spotify-player
      btop
      obs-studio
      pavucontrol
      unzip
      p7zip
      virt-manager
      imv
      mpv
      appimage-run
      qbittorrent
      gdu
      alejandra
      cryptomator
      ventoy-bin-full
      yt-dlp
      plex-media-player
      wine
      lutris
      gamemode
      gamescope
      mangohud
      bottles
      osu-lazer-bin
      runelite
      prismlauncher
      cbonsai
      pipes-rs
      cmatrix
      cava
      hollywood
    ];

    stateVersion = "22.11";
  };
}
