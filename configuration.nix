{ pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ]; # Generado automaticamente al instalar

  # Habilitar Flakes y comandos modernos de Nix
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Bootloader estandar para VMs
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos-vm";
  networking.networkmanager.enable = true;

  # --- Optimizaciones para QEMU/KVM ---
  services.qemuGuest.enable = true;
  services.spice-vdagentd.enable = true; # Para copiar/pegar entre host y guest
  
  # Drivers de video VirtIO (mejor rendimiento en VM)
  services.xserver.videoDrivers = [ "virtio" ];

  # Entorno de escritorio (GNOME 49 viene por defecto en Xantusia)
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Usuario base
  users.users.tu_usuario = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
    initialPassword = "nixos"; # ¡Cambiala luego!
  };

  environment.systemPackages = with pkgs; [
    vim
    git
    curl
    virt-viewer # Util para ver la propia VM
  ];

  system.stateVersion = "25.11";
}