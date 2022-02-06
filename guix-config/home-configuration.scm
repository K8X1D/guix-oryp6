;; This "home-environment" file can be passed to 'guix home reconfigure'
;; to reproduce the content of your profile.  This is "symbolic": it only
;; specifies package names.  To reproduce the exact same profile, you also
;; need to capture the channels being used, as returned by "guix describe".
;; See the "Replicating Guix" section in the manual.

(use-modules
  (gnu home)
  (gnu packages)
  (gnu services)
  (guix gexp)
  (gnu home services shells))

(home-environment
  (packages
    (map (compose list specification->package+output)
         (list "gccmakedep"
               "gfortran-toolchain"
               "r-rlang"
               "libjpeg"
               "fzf"
               "imv"
               "mesa-utils"
               "vulkan-tools"
               "pinentry"
               "xf86-input-libinput"
               "libinput"
               "htop"
               "powertop"
               "powerstat"
               "cpupower"
               "neofetch"
               "emacs-pgtk-native-comp"
               "emacs-use-package"
               "emacs-no-littering"
               "emacs-doom-themes"
               "emacs-doom-modeline"
               "emacs-all-the-icons"
               "emacs-minions"
               "emacs-rainbow-delimiters"
               "emacs-which-key"
               "emacs-diminish"
               "emacs-undo-tree"
               "emacs-general"
               "emacs-org"
               "emacs-org-bullets"
               "emacs-org-present"
               "emacs-org-pomodoro"
               "emacs-dashboard"
               "emacs-vterm"
               "emacs-lsp-mode"
               "emacs-spinner"
               "emacs-lsp-ui"
               "emacs-julia-mode"
               "emacs-auctex"
               "emacs-company"
               "emacs-company-auctex"
               "emacs-company-lsp"
               "libtool"
               "libvterm"
               "perl"
               "markdown"
               "zip"
               "ripgrep"
               "fd"
               "glslang"
               "graphviz"
               "sbcl"
               "python-isort"
               "python-pytest"
               "python-pip"
               "python-nose"
               "rust-analyzer"
               "shellcheck"
               "zig"
               "imagemagick"
               "offlineimap3"
               "mu"
               "i3lock"
               "bemenu"
               "alacritty"
               "xset"
               "xinput"
               "light"
               "setxkbmap"
               "xclip"
               "feh"
               "redshift"
               "swayidle"
               "swaylock"
               "swaybg"
               "mpv"
               "pavucontrol"
               "bluez"
               "pulseaudio"
               "pipewire"
               "wireplumber"
               "libomp"
               "gcc-toolchain"
               "gcc-bootstrap"
               "gcc-objc"
               "gcc-objc++"
               "gccgo"
               "cmake"
               "make"
               "gcc"
               "libstdc++-doc"
               "r-minimal"
               "r-remotes"
               "r-learnr"
               "zlib"
               "mariadb-connector-c"
               "libxml2"
               "python"
               "rust"
               "rust-cargo"
               "git"
               "openssh"
               "docker-compose"
               "adwaita-icon-theme"
               "libreoffice"
               "gimp"
               "flatpak"
               "unzip"
               "qutebrowser"
               "firefox")))
  (services
    (list (service
            home-bash-service-type
            (home-bash-configuration
              (aliases
                '(("luamake"
                   .
                   "/home/k8x1d/test/lua-language-server/3rd/luamake/luamake")
                  ("teams" . "flatpak run com.microsoft.Teams")
                  ("zoom" . "flatpak run us.zoom.Zoom")))
              (bashrc
                (list (local-file
                        "/home/k8x1d/.config/guix/guix-config/.bashrc"
                        "bashrc"))))))))
