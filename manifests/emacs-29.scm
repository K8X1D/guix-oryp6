;; see https://guix.gnu.org/manual/en/html_node/Defining-Package-Variants.html
(use-modules (gnu packages emacs)
             (guix packages)
             (guix transformations))

(define transform
  (options->transformation
   '((with-branch . "emacs-next=emacs-29"))))

;;(packages->manifest (list (transform emacs-next)))

(packages->manifest
 (list (transform (specification->package "emacs-next"))))
