(use-modules
 (gnu packages tex)
 (gnu packages version-control)
 (guix build-system gnu)
 (guix build-system texlive)
 (guix licenses)
 (guix packages)
(guix profiles)
 (srfi srfi-1)
						 )

(define* (simple-texlive-package name locations hash
																 #:key trivial?)
	"Return a template for a simple TeX Live package with the given NAME,
downloading from a list of LOCATIONS in the TeX Live repository, and expecting
the provided output HASH.  If TRIVIAL? is provided, all files will simply be
copied to their outputs; otherwise the TEXLIVE-BUILD-SYSTEM is used."
	(define with-documentation?
		(and trivial?
				 (any (lambda (location)
								(string-prefix? "/doc" location))
							locations)))
	(package
	 (name name)
	 (version (number->string %texlive-revision))
	 (source (texlive-origin name version
													 locations hash))
	 (outputs (if with-documentation?
								'("out" "doc")
								'("out")))
	 (build-system (if trivial?
										 gnu-build-system
										 texlive-build-system))
	 (arguments
		(let ((copy-files
					 `(lambda* (#:key outputs inputs #:allow-other-keys)
										 (let (,@(if with-documentation?
																 `((doc (string-append (assoc-ref outputs "doc")
																											 "/share/texmf-dist/")))
																 '())
													 (out (string-append (assoc-ref outputs "out")
																							 "/share/texmf-dist/")))
											 ,@(if with-documentation?
														 '((mkdir-p doc)
															 (copy-recursively
																(string-append (assoc-ref inputs "source") "/doc")
																(string-append doc "/doc")))
														 '())
											 (mkdir-p out)
											 (copy-recursively "." out)
											 ,@(if with-documentation?
														 '((delete-file-recursively (string-append out "/doc")))
														 '())
											 #t))))
			(if trivial?
					`(#:tests? #f
						#:phases
						(modify-phases %standard-phases
													 (delete 'configure)
													 (replace 'build (const #t))
													 (replace 'install ,copy-files)))
					`(#:phases
						(modify-phases %standard-phases
													 (add-after 'install 'copy-files ,copy-files))))))
	 (home-page #f)
	 (synopsis #f)
	 (description #f)
	 (license #f)))


(define-public texlive-extsizes
	(package
	 (inherit
		(simple-texlive-package "texlive-extsizes"
														(list "doc/latex/extsizes/"
																	"tex/latex/extsizes/")
														(base32
														 "1akxh0x8y1rhmpq8qzqi2bpbm1ffy8x0212jkyib7gm1i1d9ijgl")
														#:trivial? #t))
	 (name "texlive-extsizes")
	 ;;(version #f)
	 (home-page "https://ctan.org/macros/latex/contrib/extsizes")
	 (synopsis "Extend the standard classes' size options")
	 (description
		"This package provides classes extarticle, extreport, extletter, extbook and
extproc which provide for documents with a base font size from 8-20pt.  There is
also a LaTeX package, extsizes.sty, which can be used with nonstandard document
classes.  But it cannot be guaranteed to work with any given class.")
	 (license lppl))
	)


(define-public texlive-paracol
	(package
	 (inherit (simple-texlive-package "texlive-paracol"
																		(list "doc/latex/paracol/"
																					"source/latex/paracol/"
																					"tex/latex/paracol/")
																		(base32
																		 "1qrwdbz75i32gmaqg8cmzycqgjmw9m651fqq4h582lzaqkgqwyq1")

																		#:trivial? #t))
	 ;;(version #f)
    (home-page "https://ctan.org/macros/latex/contrib/paracol")
    (synopsis "Multiple columns with texts \"in parallel\"")
    (description
     "The package provides yet another multi-column typesetting mechanism by which you
produce multi-column (e.g., bilingual) document switching and sychronizing each
corresponding part in \"parallel\".")
    (license lppl)))




;; Return a manifest containing that one package
;;(packages->manifest (list
;;										 texlive-extsizes ;; custom
;;										 subversion
;;										 ))


;;; test concatenate manifest

(concatenate-manifests
 (list
	(specifications->manifest
	 '(
		 ;; see https://guix.gnu.org/pt-br/manual/devel/en/html_node/Using-TeX-and-LaTeX.html
		 ;; Install everything
		 ;;"texlive" ;; latex distribution


		 ;; Modular approach
		 "subversion" ;; Revision control system
		 "texlive-base" ;; base
		 "texlive-bin" ;; TeX Live, a package of the TeX typesetting system
		 "texlive-beamer" ;; presentation
		 "texlive-biblatex" ;; better bibtex
		 "texlive-pdftex" ;; tex to pdf
		 "texlive-latex-geometry" ;; interface to document dimensions
		 "texlive-amsfonts" ;; TeX fonts from the American Mathematical Society
		 "texlive-translator" ;; Easy translation of strings in LaTeX
		 "texlive-booktabs" ;; Publication quality tables in LaTeX 
		 "texlive-fonts-ec" ;; Computer modern fonts in T1 and TS1 encodings
		 "texlive-fontspec" ;; Advanced font selection in XeLaTeX and LuaLaTeX 
		 "texlive-wrapfig" ;; Produces figures which text can flow around
		 "texlive-ulem" ;; Underline text in TeX
		 "texlive-capt-of" ;; Captions on more than floats
		 "texlive-grfext" ;; Manipulate the graphics package's list of extensions 
		 "texlive-babel-french" ;; Babel contributed support for French
		 "texlive-hyphen-french" ;; Hyphenation patterns for French
		 "texlive-carlisle" ;; David Carlisle's small packages
		 "texlive-latex-supertabular" ;; Multi-page tables package
		 "texlive-enumitem" ;; Customize basic list environments 
		 "texlive-latex-fancyhdr";; Extensive control of page headers and footers in LaTeX2e
		 "texlive-times" ;; URW Base 35 font pack for LaTeX
		 "texlive-csquotes" ;; Context sensitive quotation facilities  
		 "biber" ;; Backend for the BibLaTeX citation management tool
		 "texlive-latex-natbib" ;; Flexible bibliography support
		 "texlive-latex-multirow" ;; Create tabular cells spanning multiple rows
		 "texlive-luaotfload" ;; OpenType font loader for LuaTeX
		 "texlive-latex-titlesec" ;; Select alternative section titles
		 ))
	(packages->manifest (list
											 texlive-extsizes
											 texlive-paracol
											 ))
	))	 
