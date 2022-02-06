(load "../gtransform.scm")
(packages->manifest
 (fixpkgs
 '(


    ;; gpg
    "pinentry"

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

    ;; desktop programs
    "adwaita-icon-theme"
    ;;"libreoffice"
    "k8x1d-slstatus"
    "dmenu"
    "flatpak"
    "unzip"
    "fzf"
    "zathura"
    "zathura-pdf-poppler"
    "zathura-pdf-mupdf"

)))

