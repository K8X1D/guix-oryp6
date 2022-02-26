(load "../gtransform.scm")
(packages->manifest
 (fixpkgs
 '(

    ;; 
    ;; programming-support
    ;; 
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
    ;;"libgit2"
    ;;"libgit2-glib"

    ;; julia
    "libpqxx" ;; postgresql
    ;; python
    "python"
    ;; rust
    "rust"
    "rust-cargo"
    ;; others
    ;;"postgresql"
    "docker-compose"
    ;; texlive
    "texlive"
)))
