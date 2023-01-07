(use-modules (gnu packages emacs)
						 (guix packages)
						 (guix transformations))

(define transform
	(options->transformation
	 '((with-branch . "emacs-next=emacs-29"))))

;;(packages->manifest (list (transform emacs-next))) ;; missing git...
(concatenate-manifests
 (list (specifications->manifest
				'("coreutils"
					"git"))
			 (packages->manifest (list (transform emacs-next)))))	 
