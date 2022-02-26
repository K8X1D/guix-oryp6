(load "../gtransform.scm")
(packages->manifest
 (fixpkgs
 '(
    ;; browsers
    (raw "qutebrowser")
    (raw "firefox")



    ;;;;;;;;;;
    ;; nyxt ;;
    ;;;;;;;;;;
    "nyxt"
    ;; video support through gstreamer
    "gst-libav"
    "gst-plugins-bad"
    "gst-plugins-base"
    "gst-plugins-good"
    "gst-plugins-ugly"



    "youtube-dl-gui"
    ;;(raw "rstudio")
    ;;"rstudio"
    (raw "gimp")
    "libreoffice"
    "texmacs"

)))

