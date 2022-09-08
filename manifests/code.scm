(specifications->manifest
  '(

    ;;   ;; Building tools
    ;;   "gcc-toolchain"
    ;;   "gfortran-toolchain"
    ;;   "glibc-locales"
    ;;   "make"
    ;;   "cmake"
    ;;   "pkg-config"


    ;; Julia
   ;; "julia" ;; main package
   ;; "p7zip" ;; necessary to install package via native package manager

    "git"
    "curl"
    "dzen"

    "docker-compose"
    "runc"

    ;; R
    "r" ;; main package
    "r-ggplot2"
    "r-dplyr"
    "r-data-table"

    "r-here"
    "r-xml2"
    "r-openssl"
    "r-testthat"
    "r-stringi"
    "r-igraph"
    "r-gmp"
    "r-v8"
    "r-vroom"
    "r-rcpp"
    "r-readr"
    "r-tidyr"
    "r-magrittr"
    "r-renv"
    "r-urltools"
    "r-sass"
    "r-promises"
    "r-httpuv"
    "r-later"
    "r-bslib"
    "r-crul"
    "r-dt"
    "r-shiny"
    "r-miniui"
    "r-plyr"
    "r-xml"
    "r-hunspell"
    "r-ggrepel"
    "r-lme4"
    "r-rentrez"
    "r-tokenizers"
    "r-pbkrtest"
    "r-readxl"
    "r-tidytext"
    "r-car"
    "r-rstatix"
    "r-factominer"
    "r-ggpubr"
    "r-factoextra"

    "r-rjava"
    "openjdk"
    "rstudio"


    "redland"
    "gmp"

    ;; Python
    "python"
    "python-pip"
    "python-jedi"
    "python-pyyaml"
    "python-unidecode"
    "python-pandas"

    ;; speech recognizer
    "python-wheel"
    ;; microphone
    "portaudio"
    ;; sphinx
    "python-setuptools"
    "swig"
    "pulseaudio"
    "alsa-lib"
    "flac"
    "webkitgtk"

    "python-pydub"

    ;; Youtube interaction
    "youtube-dl"



    ;; Nvim
    ;;"neovim" ;; gcc is not up-to-date, block installation of certain Tree-sitter
    ;;"tree-sitter"
    ;;"node"
    "ripgrep"
    "fd"

    ;; Databases
    "mariadb"

    ))
