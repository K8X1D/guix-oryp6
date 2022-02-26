;; "One Editor to rule them all, One Editor to find them, One Editor to bring them all and in the darkness bind them."


(load "../gtransform.scm")
(packages->manifest
 (fixpkgs
 '(;;  Emacs
    ;;"emacs-pgtk-native-comp" ;; emacs w wayland support, crash dwl... issue open...
    "emacs-native-comp"
    "coreutils"
    "findutils"


;; rational-completion
"emacs-vertico"



;; k8x1d-rational-code
"emacs-julia-mode"
;;"emacs-ess" error


;;; julia vterm
"emacs-vterm"





"emacs-alert"
"emacs-all-the-icons"
"emacs-all-the-icons-dired"
"emacs-annalist"
"emacs-company"
"emacs-dash"










"emacs-no-littering"

;; ui
"emacs-doom-themes"
"emacs-doom-modeline"
"emacs-modus-themes"
"emacs-diminish"
"emacs-minions"
"emacs-rainbow-delimiters"


;; keybindings
"emacs-undo-tree"
"emacs-evil"
"emacs-evil-collection"
"emacs-evil-surround"
"emacs-evil-org"
"emacs-general"
"emacs-which-key"



    ;;"emacs-use-package"
    ;;;; utilities
    ;;"emacs-no-littering"
    ;;;; ui
    ;;"emacs-doom-themes"
    ;;"emacs-doom-modeline"
    ;;"emacs-all-the-icons"
    ;;"emacs-minions"
    ;;"emacs-rainbow-delimiters"
    ;;"emacs-which-key"
    ;;"emacs-diminish"
    ;;;; keybindings
    ;;"emacs-undo-tree"
    ;;;;"emacs-evil"
    ;;"emacs-general"
    ;;;; org-config
    ;;"emacs-org"
    ;;"emacs-org-bullets"
    ;;"emacs-org-present"
    ;;"emacs-org-pomodoro"
    ;;"emacs-org-superstar"
    ;;;;"emacs-evil-org"
    ;;;; dashboard-config
    ;;"emacs-dashboard"
    ;;;; programming-support
    ;;"emacs-vterm"
    ;;"emacs-lsp-mode"
    ;;"emacs-spinner"
    ;;"emacs-lsp-ui"
    ;;"emacs-julia-mode" 
    ;;;;"emacs-ess" ;; prob with doom emacs
    ;;"emacs-auctex"
    ;;"emacs-markdown-mode"
    ;;"emacs-polymode"
    ;;"emacs-polymode-markdown"
    ;;"emacs-polymode-org"
    ;;"emacs-company"
    ;;"emacs-company-auctex"
    ;;"emacs-company-lsp"
    ;;;; dependances 

    ;; vterm ;;
    "libtool"
    "libvterm"
    "perl"

    ;;"markdown"
    ;;"zip" ;; to export to odt
    ;;;; doom
    ;;"ripgrep"
    ;;"fd"
    ;;"glslang"
    ;;"graphviz"
    ;;"sbcl"
    ;;"python-isort"
    ;;"python-pytest"
    ;;"python-pip"
    ;;"python-nose"
    ;;"rust-analyzer"
    ;;"shellcheck"
    ;;"zig"
    ;;"imagemagick"
    ;;"offlineimap3"
    ;;"mu"
)))
