(load "../gtransform.scm")
(packages->manifest
 (fixpkgs
 '(

    ;; 
    ;; programming-support
    ;; 
    ;; C
    ;;"libomp"
    "gcc-toolchain"
    "gfortran-toolchain"
    "glibc-bootstrap"
    ;;"gcc-bootstrap"
    ;;"gccmakedep"
    ;;"gcc-objc"
    ;;"gcc-objc++"
    ;;"gccgo"
    "cmake"
    "make"
    ;;"libstdc++-doc"
    ;; R
    "r-minimal"
    "r-remotes"
    "r-learnr"
    "r-rmarkdown"
    "r-dplyr"
    "r-tidyr"
    "r-devtools"
    "r-curl"
    "zlib"
    "mariadb-connector-c"
    "libxml2"
    "curl"
    "libgit2"
    "libgit2-glib"
    "openssl"
    "pkg-config"

    ;; julia
    "libpqxx" ;; postgresql
    ;; python
    "python"
    ;; rust
    "rust"
    "rust-cargo"
    ;; others
    ;;"postgresql"
    ;;"git"
    "openssh"
    "docker-compose"
    ;; texlive
    "texlive"

)))
