{...}: {
  services.greetd = {
    enable = true;
    settings = rec {
      initial_session = {
        command = "Hyprland";
        user = "cellis";
      };
      default_session = initial_session;
    };
  };
}
