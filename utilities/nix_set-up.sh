nix-channel --add https://nixos.org/channels/nixpkgs-unstable
nix-channel --update
nix-env -iA \
  nixpkgs.julia-bin \
  nixpkgs.brave \
  nixpkgs.zotero \
  nixpkgs.neovim \
  nixpkgs.luajitPackages.luarocks \
  nixpkgs.cargo \
  nixpkgs.tree-sitter \
  nixpkgs.sumneko-lua-language-server \
  nixpkgs.texlab \
  nixpkgs.zathura \
  nixpkgs.discord \
  nixpkgs.caprine-bin \
  nixpkgs.zoom-us \
  nixpkgs.vscode
  nixpkgs.spotify \
  nixpkgs.teams \
  nixpkgs.slack \
  nixpkgs.protonvpn-cli \
  nixpkgs.android-file-transfer \
  nixpkgs.system76-firmware


## wayland wm
##sway swaylock swayidle swaybg
  #jre_minimal \
  #jdk \
  #libreoffice \
