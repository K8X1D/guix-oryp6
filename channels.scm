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
  (name 'guix-science)
  (url "https://github.com/guix-science/guix-science.git")
  (introduction
   (make-channel-introduction
    "b1fe5aaff3ab48e798a4cce02f0212bc91f423dc"
    (openpgp-fingerprint
     "CA4F 8CF4 37D7 478F DA05  5FD4 4213 7701 1A37 8446"))))

 ;; (channel
 ;;  (name 'guix-hpc)
 ;;  (url "https://gitlab.inria.fr/guix-hpc/guix-hpc.git"))

 ;; (channel
 ;;  (name 'guix-hpc-non-free)
 ;;  (url "https://gitlab.inria.fr/guix-hpc/guix-hpc-non-free.git"))
 ; )

(channel
 (name 'k8x1d)
 (url "https://gitlab.com/oryp6/guix_set-up/guix-channel.git")
 (introduction
  (make-channel-introduction
   "1f836893d03174d1d6a247a37cb8b54b5057cb5e"
   (openpgp-fingerprint
    "A180 8C8D E727 2D87 15CD  AB96 39AA 7B97 9BCC 55C5"))))
(channel
  (name 'emacs)
  (url "https://github.com/babariviere/guix-emacs")
  (introduction
   (make-channel-introduction
    "72ca4ef5b572fea10a4589c37264fa35d4564783"
    (openpgp-fingerprint
     "261C A284 3452 FB01 F6DF  6CF4 F9B7 864F 2AB4 6F18"))))

 )
