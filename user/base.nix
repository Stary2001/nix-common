{ ... }: {
    home.homeDirectory = "/home/stary";
    home.username = "stary";
    home.stateVersion = "23.11";
            
    programs.home-manager.enable = true;
    programs.git = {
      enable = true;
      userName = "Chloe Bethel";
      userEmail = "chloe@9net.org";
      extraConfig = {
        init.defaultBranch = "main";
      };
    };
    programs.htop.enable = true;
    programs.tmux.enable = true;
}
