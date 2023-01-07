(use-modules (gnu packages emacs))

(define emacs-28-native-comp-pgtk
  (package
    (inherit emacs)
    (arguments
     (list
      #:configure-flags #~(list "--with-pgtk")
      ))))
