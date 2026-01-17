{ pkgs, ... }:

{
  home.username = "tu_usuario";
  home.homeDirectory = "/home/tu_usuario";

  # Paquetes de usuario
  home.packages = with pkgs; [
    firefox
    htop
    vscode
    fastfetch
  ];

  # Habilitar programas con su config base
  programs.git = {
    enable = true;
    userName = "Tu Nombre";
    userEmail = "tu@email.com";
  };

  programs.bash.enable = true;

  home.stateVersion = "25.11";
}