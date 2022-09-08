    (list

  (channel
   (name 'guix)
   (url "https://git.savannah.gnu.org/git/guix.git")
   (branch "master")
   ;;(commit
   ;;  "056935506b8b5550ebeb3acfc1d0c3b4f11b6a2e")
   (introduction
    (make-channel-introduction
     "9edb3f66fd807b096b48283debdcddccfea34bad"
     (openpgp-fingerprint
      "BBB0 2DDF 2CEA F6A8 0D1D  E643 A2A0 6DF2 A33A 54FA"))))

  (channel
   (name 'nonguix)
   (url "https://gitlab.com/nonguix/nonguix")
   (branch "master")
   ;;(commit
   ;;  "8c22d70b02d4cf42f64784296fbd267695cd3e4c") ;; last upd:
   (introduction
    (make-channel-introduction
     "897c1a470da759236cc11798f4e0a5f7d4d59fbc"
     (openpgp-fingerprint
      "2A39 3FFF 68F4 EF7A 3D29  12AF 6F51 20A0 22FB B2D5"))))

  (channel
   (name 'flat)
   (url "https://github.com/flatwhatson/guix-channel.git")
   (commit
    "e57424b680e1724105e2598b68c30084b180cf58") ;; last upd: 03/09/2022
   (introduction
    (make-channel-introduction
     "33f86a4b48205c0dc19d7c036c85393f0766f806"
     (openpgp-fingerprint
      "736A C00E 1254 378B A982  7AF6 9DBE 8265 81B6 4490"))))

;;(channel
;;  (name 'home-service-dwl-guile)
;;  (url "https://github.com/engstrand-config/home-service-dwl-guile")
;;  (branch "main")
;;  (introduction
;;    (make-channel-introduction
;;      "314453a87634d67e914cfdf51d357638902dd9fe"
;;      (openpgp-fingerprint
;;        "C9BE B8A0 4458 FDDF 1268 1B39 029D 8EB7 7E18 D68C"))))

;;(channel
;; (name 'k8x1d)
;; (url "https://gitlab.com/oryp6/guix_set-up/guix-channel.git")
;; (introduction
;;  (make-channel-introduction
;;   "a3633fe58b4c9cfd6918b9d8abbbc394010a642d"
;;   (openpgp-fingerprint
;;    "E109 BDB7 58D9 36A9 F4E5 D749 7769 412E D873 CFB8"))))

(channel
  (name 'guix-science)
  (url "https://github.com/guix-science/guix-science.git")
  (introduction
   (make-channel-introduction
        "b1fe5aaff3ab48e798a4cce02f0212bc91f423dc"
        (openpgp-fingerprint
         "CA4F 8CF4 37D7 478F DA05  5FD4 4213 7701 1A37 8446"))))

(channel
 (name 'guix-hpc)
 (url "https://gitlab.inria.fr/guix-hpc/guix-hpc.git"))

(channel
 (name 'guix-hpc-non-free)
 (url "https://gitlab.inria.fr/guix-hpc/guix-hpc-non-free.git"))

  )
