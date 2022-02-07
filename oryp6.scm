
;; Warning:
;; This will not work without modification, obviously.
;; Read through and see where modifications are needed.
;; Also, it doesn't include wpa-supplicant.
;; So if you don't have a wired connection, add it.

(use-modules (gnu))
(use-modules (guix))
(use-modules (guix modules))
(use-modules (nongnu packages linux)
             (nongnu system linux-initrd))
(use-modules (k8x1d packages xorg))
(use-modules (srfi srfi-1)) ;; "remove"
(use-service-modules xorg
                     linux
                     nix
                     pm
                     databases
                     sddm
                     mcron
                     ;;docker
                     desktop ;; %desktop-services
                     networking ;; modem-manager-service-type
                     )
(use-package-modules xorg wm certs
                     display-managers
                     linux ;; light
                     image-viewers ;; feh
                     compton ;; picom
                     fonts
                     databases
                     dunst
                     wm ;; stumpwm
                     lisp
                     guile-wm
                     ;terminals ;; alacritty
                     ;xdisorg ;; redshift
                     shells ;; zsh
                     freedesktop ;; libinput
                     suckless ;; st
                     )

;; make sure you downloaded this file too
(load "./gtransform.scm")

;; reverse-prime
(define nvidia-dgpu.conf
  ;; This probably isn't the setup you want, for it is just an example.
  "
  Section \"ServerLayout\"
        Identifier \"layout\"
        Screen 0 \"iGPU\"
        Inactive \"dGPU\"
        Option \"AllowNVIDIAGPUScreens\"
  EndSection

  Section \"Device\"
     Identifier \"iGPU\"
     Driver \"modesetting\"
     BusID \"PCI:0:2:0\"
   EndSection

   Section \"Screen\"
     Identifier \"iGPU\"
     Device \"iGPU\"
   EndSection

   Section \"Device\"
     Identifier \"dGPU\"
     Driver \"nvidia\"
     BusID \"PCI:1:0:0\"
   EndSection
   "
   )

;; doesm't work since nvidia is loaded at boot-time
;; left as example
;;(define nvidia-config 
;;  (plain-file "nvidia.conf"
;;              "options nvidia NVreg_DynamicPowerManagement=0x02"))


;; special xorg config.
;; adds nvidia xorg module and transforms xorg-server package
(define my-xorg-conf
  (xorg-configuration
   (modules
    (cons*
     (fixpkg nvidia-libs-minimal)
     ;; optional: remove garbage.
     (remove
      (lambda (pkg)
        (member pkg
                (list
                 xf86-video-amdgpu
                 xf86-video-ati
                 xf86-video-cirrus
                 xf86-video-intel
                 xf86-video-mach64
                 xf86-video-nouveau
                 xf86-video-nv
                 xf86-video-sis)))
      %default-xorg-modules)))
   (extra-config (list nvidia-dgpu.conf))
   (server (fixpkg xorg-server))
   (drivers '("modesetting" "nvidia"))))


(define %backlight-udev-rule
  (udev-rule
    "90-backlight.rules"
    (string-append "ACTION==\"add\", SUBSYSTEM==\"backlight\", "
		   "RUN+=\"/run/current-system/profile/bin/chgrp video /sys/class/backlight/%k/brightness\""
		   "\n"
		   "ACTION==\"add\", SUBSYSTEM==\"backlight\", "
		   "RUN+=\"/run/current-system/profile/bin/chmod g+w /sys/class/backlight/%k/brightness\"")))

(define %initial-backlight-udev-rule
  (udev-rule
    "81-backlight.rules"
    (string-append "SUBSYSTEM==\"backlight\", ACTION==\"add\", KERNEL==\"acpi_video0\", ATTR{brightness}=\"1\"")))



(define %my-desktop-services
  (modify-services %desktop-services
                   (elogind-service-type config =>
                                         (elogind-configuration (inherit config)
                                                                (handle-lid-switch-external-power 'suspend)
                                                                (idle-action 'ignore)
                                                                (idle-action-seconds (* 60 60)) ;; test
                                                                ))
                   (udev-service-type config =>
                                      (udev-configuration (inherit config)
                                                          (rules (cons* %backlight-udev-rule
                                                                        %initial-backlight-udev-rule
                                                                        (udev-configuration-rules config)))))
                   (guix-service-type config =>
                                      (guix-configuration (inherit config)
                                                          (substitute-urls
                                                            (append (list "https://substitutes.nonguix.org")
                                                                    %default-substitute-urls))
                                                          (authorized-keys
                                                            (append (list (local-file "./signing-key.pub"))
                                                                    %default-authorized-guix-keys))))
                   ))



;; mcron
(define garbage-collector-job
  ;; Collect garbage 5 minutes after 9am every day.
  ;; The job's action is a shell command.
  #~(job "5 9 * * *"            ;Vixie cron syntax
         "guix gc -F 5G"))

(define battery-alert-job
  ;; Beep when the battery percentage falls below %MIN-LEVEL.
  #~(job
     '(next-minute (range 0 60 1))
     #$(program-file
        "battery-alert.scm"
        (with-imported-modules (source-module-closure
                                '((guix build utils)))
          #~(begin
              (use-modules (guix build utils)
                           (ice-9 popen)
                           (ice-9 regex)
                           (ice-9 textual-ports)
                           (srfi srfi-2))

              (define %min-level 10)

              (setenv "LC_ALL" "C")     ;ensure English output
              (and-let* ((input-pipe (open-pipe*
                                      OPEN_READ
                                      #$(file-append acpi "/bin/acpi")))
                         (output (get-string-all input-pipe))
                         (m (string-match "Discharging, ([0-9]+)%" output))
                         (level (string->number (match:substring m 1)))
                         ((< level %min-level)))
                (format #t "warning: Battery level is low (~a%)~%" level)
                (invoke #$(file-append dunst "/bin/dunstify") "-u critical 'LOW BATTERY!!!'")))))))

;; service to define gl;;oba; env variable
;; from https://lists.gnu.org/archive/html/help-guix/2020-12/msg00238.html
;;(define environment-service-type
;; (service-type (name 'environment)
;;                 (default-value '())
;;                 (extensions
;;                  (list (service-extension
;;                         session-environment-service-type
;;                         identity)))))


(operating-system
 (host-name "oryp6")
 (timezone "America/Toronto")
 (locale "en_US.utf8")
 (keyboard-layout (keyboard-layout "ca" "fr"
                                   #:options '("ctrl:nocaps" "altwin:menu_win")
                                   ))

 (initrd microcode-initrd)
 (initrd-modules %base-initrd-modules)

 (kernel (fixpkg linux))
 (kernel-loadable-modules (list (fixpkg nvidia-module)))
 (kernel-arguments (list
                    ;; enable a feature
                    "nvidia-drm.modeset=1"
                    "nvidia.NVreg_DynamicPowerManagement=0x02"
                    ;; nvidia_uvm gives me problems
                    "modprobe.blacklist=nouveau,nvidia_uvm"))
 (firmware (fixpkgs (list linux-firmware)))


 ;; BOOTLOADER CONFIGURATION
  (bootloader (bootloader-configuration
                (bootloader grub-efi-bootloader)
                (targets '("/boot/efi"))
                (keyboard-layout keyboard-layout)))

 ;; FILE-SYSTEMS CONFIGURATION
  (file-systems (append
                 (list (file-system
                         (device (uuid "4c1e6920-a788-4913-9d24-1e82c32b2383"))
                         (mount-point "/")
                         (type "ext4"))
			(file-system
                         (device (uuid "5085f59e-89d2-48cf-abd6-4cd673816c65"))
                         (mount-point "/home")
                         (type "ext4"))
		        (file-system
                         (device (uuid "3719b136-d36b-4e50-b1b2-edee3789ffe8"))
                         (mount-point "/media")
                         (type "ext4"))
                       (file-system
                         (device (uuid "7C94-8C19" 'fat))
                         (mount-point "/boot/efi")
                         (type "vfat")))
                 %base-file-systems))
    ;;(swap-devices (list (uuid "61d87243-f886-49e8-b968-dbe6f76be8c4"))) ;; TODO deprecated, adjust
    (swap-devices (list
                   (swap-space
                     (target
                       (uuid "61d87243-f886-49e8-b968-dbe6f76be8c4"))))) ;; test

 ;; USER CONFIGURATION
 (users (cons (user-account
                (name "k8x1d")
                (comment "Kevin Kaiser")
                (shell (file-append zsh "/bin/zsh"))
                (group "users")
                (home-directory "/home/k8x1d")
                (supplementary-groups '(
                                        "wheel"     ;; sudo
                                        "netdev"    ;; network devices
                                        ;;"kvm"
                                        "tty"
                                        "input"
                                        ;;"docker"
                                        "postgres"
                                        "lp"        ;; control bluetooth devices
                                        "audio"     ;; control audio devices
                                        "video")))  ;; control video devices
              %base-user-accounts))

 ;; PACAKGES CONFIGURATION
 (packages
  (fixpkgs
   (cons*
    nss-certs

    ;; does this actually have to be global? i don't know. i do it anyway.
    nvidia-libs-minimal

    ;; are these even needed? i don't remember.
    xf86-input-libinput
    libinput
    ;; fonts
    font-dejavu
    font-juliamono
    ;; dwm set-up 
    k8x1d-dwm k8x1d-st k8x1d-slstatus dmenu
    ;; strumpwm set-up 
    sbcl stumpwm
    ;; guile-wm set-up 
    guile-wm
    ;; databases
    ;;i3-gaps i3lock i3status ;; window manager
    %base-packages)))

 ;; SERVICES CONFIGURATION
 (services
  (cons*
   ;; nvidia udev service
   (simple-service
    'my-nvidia-udev-rules udev-service-type
    (list (fixpkg nvidia-udev)))

   ;; add liglvnd slim using special xorg config
   ;;(service slim-service-type
   ;;         (slim-configuration
   ;;          (slim (fixpkg slim))
   ;;          (xorg-configuration my-xorg-conf)))
   ;; test sddm
   (service sddm-service-type
            (sddm-configuration
              (themes-directory "/media/Logiciels/guix/sddm/themes")
              (theme "sugar-dark")
              ;;(sddm (fixpkg sddm)) ;; seem to cause black screen
              ;;(xdisplay-start "/home/k8x1d/start-up")
              ;;(xsession-command picom)
              (xorg-configuration my-xorg-conf)))

   (service kernel-module-loader-service-type
            '("nvidia"
              "nvidia_modeset"
              ;; i dont remember why i put this one here.
              ;; i think i stole it from somebody else.
              ;; maybe it's not needed.
              "ipmi_devintf"))
   ;; (simple-service 'nvidia-config etc-service-type
   ;;                                (list `("modprobe.d/nvidia.conf"
   ;;                                        ,nvidia-config)))


   (bluetooth-service #:auto-enable? #t)
   (service nix-service-type)
   (screen-locker-service i3lock) ;; necessary to unlock i3lock screen
   ;; pm management
   (service tlp-service-type
            (tlp-configuration 
              (energy-perf-policy-on-ac "normal")
            ))
   (service thermald-service-type)
   
    ;; mcron
    (simple-service 'my-cron-jobs
                    mcron-service-type
                    (list garbage-collector-job
                          battery-alert-job))

  ;;  ;; env variable
  ;;  (service environment-service-type
  ;;           '(("PGHOST" . "/var/run/postgresql") ;; for julia libpq
  ;;             ("RSTUDIO_CHROMIUM_ARGUMENTS" . "--disable-seccomp-filter-sandbox") ;; rstudio temp fix for bas qtwebengine
  ;;             ))
   ;; databases and container 
   ;;(service docker-service-type) ;; TODO: investigate when high increase startup-time, TODO: change data-root to save space on root 
   (service postgresql-service-type
            (postgresql-configuration
              (data-directory "/media/Data/pgdata/14")
              (postgresql postgresql-14)))
   (service postgresql-role-service-type
               (postgresql-role-configuration
                (roles
                 (list (postgresql-role
                        (name "k8x1d")
                        (permissions '(superuser))
                        (create-database? #t))))))
   ;; default services, with some packages removed for faster build
   (remove (lambda (service)
             (or (member (service-kind service)
                         (list
                          gdm-service-type
                          ;;modem-manager-service-type
                          usb-modeswitch-service-type
                          ;;wpa-supplicant-service-type
                          ;;network-manager-service-type
                          geoclue-service-type
                          colord-service-type))
                 (member
                  (struct-ref (service-kind service) 0)
                  '(
                    screen-locker
                    mount-setuid-helpers
                    ;;network-manager-applet
                    ))))
           %my-desktop-services))))

