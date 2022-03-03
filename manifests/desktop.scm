(load "../gtransform.scm")
(packages->manifest
 (fixpkgs
 '(


    ;; gpg
    "pinentry"
    "password-store"
    "gnupg"

    ;; driver
    ;;"xf86-input-libinput"
    ;;"libinput"

    "git"

    ;; monitoring
    "htop"
    "powertop"
    "powerstat"
    "cpupower"
    "neofetch"

    ;; wm utilities
    ;;"i3lock"
    ;;"bemenu" ;; x-w compat launcher
    ;;(raw "alacritty") ;; x-w compat terminal
    "xset"
    "xinput"
    "xrandr"
    "light"
    "setxkbmap"
    "xclip"
    "feh"
    ;;"picom"
    "dunst"
    "redshift"
    ;;"swayidle"
    ;;"swaylock"
    ;;"swaybg"
    "git"
    "openssh"
    "openssl"
    "pkg-config"
    "libomp" ;; for data.table

    ;; sound
    "mpd"
    "mpd-mpc"
    "mpv"
    "pavucontrol"
    "bluez"
    "pulseaudio"
    "pipewire"
    "wireplumber"
    "youtube-dl"
    "youtube-dl-gui"

    ;; Compilation support
    "gcc-toolchain"
    "clang-toolchain"
    "gfortran-toolchain"
    "glibc"
    "make"
    "cmake"
    "cmake-shared"

    ;;"gccmakedep"
    ;;;;"gcc-bootstrap" ;; add confliting module for gcc
    ;;"gcc-objc++"

    ;; Remote connection
    "openconnect"
    "rdesktop"

    ;; desktop programs
    "adwaita-icon-theme"
    ;;"libreoffice"
    "k8x1d-slstatus"
    "dmenu"
    "unzip"
    "fzf"
    "zathura"
    "zathura-pdf-poppler"
    "zathura-pdf-mupdf"

    ;; third party applications
    "flatpak"
    "xdg-desktop-portal"
    "xdg-desktop-portal-gtk"

)))

