(specifications->manifest
 '(
   ;; see https://guix.gnu.org/pt-br/manual/devel/en/html_node/Using-TeX-and-LaTeX.html
   ;; Install everything
   ;;"texlive" ;; latex distribution


   ;; Modular approach
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
   ))
