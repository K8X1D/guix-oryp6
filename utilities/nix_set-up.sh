nix-channel --add https://nixos.org/channels/nixpkgs-unstable
nix-channel --update
nix-env -iA \
  nixpkgs.brave \
  nixpkgs.zotero \
  nixpkgs.discord \
  nixpkgs.julia-bin \
  nixpkgs.neovim \
  nixpkgs.luajitPackages.luarocks \
  nixpkgs.cargo \
  nixpkgs.tree-sitter \
  nixpkgs.sumneko-lua-language-server \
  nixpkgs.nodePackages.coc-clangd \
  nixpkgs.nodePackages.bash-language-server \
  nixpkgs.nodePackages.pyright \
  nixpkgs.texlab \
  nixpkgs.zathura \
  nixpkgs.glow \
  nixpkgs.vscode \
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

##

