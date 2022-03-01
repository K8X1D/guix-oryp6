(cons* (channel
        (name 'nonguix)
        (url "https://gitlab.com/nonguix/nonguix")
        ;; Enable signature verification:
        (introduction
         (make-channel-introduction
          "897c1a470da759236cc11798f4e0a5f7d4d59fbc"
          (openpgp-fingerprint
           "2A39 3FFF 68F4 EF7A 3D29  12AF 6F51 20A0 22FB B2D5"))))
       ;; Add up-to-date nvidia
	(channel
	  (name 'nvidiachannel)
	  (url "https://gitlab.com/squarerectangle/nvidiachannel.git"))
       ;; Add wayland emacs
	(channel
	  (name 'flat)
	  (url "https://github.com/flatwhatson/guix-channel.git")
	  (introduction
	    (make-channel-introduction
	      "33f86a4b48205c0dc19d7c036c85393f0766f806"
	      (openpgp-fingerprint
		"736A C00E 1254 378B A982  7AF6 9DBE 8265 81B6 4490"))))

(channel
  (name 'k8x1d)
  (url "https://gitlab.com/oryp6/guix_set-up/guix-channel")
  (branch "main")
  (introduction
   (make-channel-introduction
    "0c706a6616942fe5d647b1317513c22d162caa73"
    (openpgp-fingerprint
     "E109 BDB7 58D9 36A9 F4E5  D749 7769 412E D873 CFB8")))
 )
(channel
  (name 'guix-science)
  (url "https://github.com/guix-science/guix-science.git")
  (introduction
   (make-channel-introduction
        "b1fe5aaff3ab48e798a4cce02f0212bc91f423dc"
        (openpgp-fingerprint
         "CA4F 8CF4 37D7 478F DA05  5FD4 4213 7701 1A37 8446"))))
(channel
  (name 'guix-science-nonfree)
  (url "https://github.com/guix-science/guix-science-nonfree.git")
  (introduction
   (make-channel-introduction
        "58661b110325fd5d9b40e6f0177cc486a615817e"
        (openpgp-fingerprint
         "CA4F 8CF4 37D7 478F DA05  5FD4 4213 7701 1A37 8446"))))
;;(channel
;;  (name 'engstrand-config)
;;  (url "https://github.com/engstrand-config/guix-dotfiles")
;;  (branch "main")
;;  (introduction
;;   (make-channel-introduction
;;    "005c42a980c895e0853b821494534d67c7b85e91"
;;    (openpgp-fingerprint
;;     "C9BE B8A0 4458 FDDF 1268 1B39 029D 8EB7 7E18 D68C"))))
	%default-channels)




