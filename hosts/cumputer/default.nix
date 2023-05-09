{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ../../home/wayland
    ../../modules
    ../../modules/fonts.nix
  ];

  # bootloader
  boot.loader = {
    systemd-boot = {
      enable = true;
      configurationLimit = 8;
    };
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot/efi";
    };
  };

  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.extraModulePackages = with config.boot.kernelPackages; [v4l2loopback.out];
  boot.kernelModules = ["v4l2loopback" "kvm-amd"];

  virtualisation.libvirtd.enable = true;

  networking = {
    hostName = "cumputer";
  };

  services = {
    xserver = {
      enable = true;
      videoDrivers = ["nvidia"];
      layout = "us";
      xkbVariant = "";
    };
  };

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    pinentryFlavor = "gtk2";
  };

  services.pcscd.enable = true;

  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };

  programs.steam = {
    enable = true;
  };

  security.polkit.enable = true;
  security.pam.services.swaylock = {
    text = ''
      auth include login
    '';
  };

  hardware = {
    nvidia = {
      powerManagement.enable = true;
      modesetting.enable = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };
    opengl = {
      enable = true;
      extraPackages = with pkgs; [
        nvidia-vaapi-driver
      ];
    };
    opentabletdriver = {
      enable = true;
      daemon.enable = true;
    };
  };
  users = {
    defaultUserShell = pkgs.nushell;
    users.cellis = {
      isNormalUser = true;
      description = "Alexander Sellström";
      extraGroups = ["networkmanager" "wheel" "disk" "video"];
    };
  };

  environment.systemPackages = with pkgs; [
    wget
    dconf
    polkit_gnome
    libvirt
    qemu_kvm
    pinentry-gtk2
    nfs-utils
    jdk17
  ];
}
