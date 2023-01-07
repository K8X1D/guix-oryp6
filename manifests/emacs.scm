;; This "manifest" file can be passed to 'guix package -m' to reproduce
;; the content of your profile.  This is "symbolic": it only specifies
;; package names.  To reproduce the exact same profile, you also need to
;; capture the channels being used, as returned by "guix describe".
;; See the "Replicating Guix" section in the manual.

(specifications->manifest
  (list ;;"emacs-pgtk-native-comp"
        "emacs-next-pgtk"
        ;;"emacs"
        "git"
        "ripgrep"
        "fd"
        "cmake"
        "make"
        "gcc"
        "gcc-bootstrap"
        "gcc-toolchain"
        "libtool"
        "perl"
        "openjdk"
        "ruby-taskjuggler"
        "zip"
        "python-lsp-server"
        "font-fira-code"
        "font-fira-sans"
        "font-iosevka-aile"
        "font-jetbrains-mono"
        "font-dejavu"
        "imagemagick"
        "poppler"
        "ffmpegthumbnailer"
        "mediainfo"
        "tar"
        "unzip"))
