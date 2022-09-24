  (use-modules (gnu)
               (nongnu packages linux)
               (nongnu system linux-initrd)
               (nongnu packages nvidia)
               (gnu system nss)
               (srfi srfi-1))

  (use-service-modules
   desktop ;; desktop
   linux ;; module-loader
   nix ;; nix
   file-sharing ;; transmission
   xorg ;; xorg-configuration
   docker ;; docker
   networking ;; network-manager
   cups ;; cups
   audio ;; mpd
   databases ;; postgresql
   pm ;; tlp, thermald
   sddm ;;sddm
   ;;lightdm ;; lightdm
   )

(use-package-modules
 certs ;; nss-certs
 databases ;; postgresql
 xdisorg ;; redshift
 fonts ;; dejavu, juliamono, freefont
 gnome ;; network-manager-openvpn
 wm ;; 13
 music ;; playctl
 linux ;; brightnessctl
 dunst ;; dunst
 terminals ;; alacritty
 freedesktop ;; libinput
 package-management ;; for nix
 image-viewers ;; feh
 compton ;; picom
 pulseaudio ;; pavucontrol
 xorg ;; xset
 )

  (define nvidia-dgpu.conf
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

  (define my-keyboard-layout
    (keyboard-layout "ca" "fr"
                     #:options '("ctrl:nocaps" "altwin:menu_win")))

  (define my-xorg-conf
    (xorg-configuration
     (keyboard-layout my-keyboard-layout)
     (modules
      (cons*
       nvidia-driver
       ;;     nvidia-module
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
                   (udev-service-type config =>
                                      (udev-configuration (inherit config)
                                                          (rules (cons* %backlight-udev-rule
                                                                        %initial-backlight-udev-rule
                                                                        (udev-configuration-rules config)))))
                   (guix-service-type config => (guix-configuration
                                                 (inherit config)
                                                 (substitute-urls
                                                  (append (list "https://substitutes.nonguix.org" ;; nonguix
                                                                ;;"https://guix.bordeaux.inria.fr" ;; hpc
                                                                ;;"https://substitutes.guix.psychnotebook.org" ;; guix-science ;; broke often...
                                                                )
                                                          ;;(append (list "https://substitutes.nonguix.org")
                                                          %default-substitute-urls))
                                                 (authorized-keys
                                                  ;;(append (list (local-file "./nonguix-signing-key.pub")
                                                  ;;              (local-file "./science-signing-key.pub"))
                                                  ;;        %default-authorized-guix-keys))))
                                                    (append (list
                                                        (plain-file "non-guix.pub"
                                                                    "(public-key
                                                                       (ecc
                                                                         (curve Ed25519)
                                                                         (q #C1FD53E5D4CE971933EC50C9F307AE2171A2D3B52C804642A7A35F84F3A4EA98#)
                                                                       )
                                                                     )")
                                                        (plain-file "guix-science.pub"
                                                                    "(public-key
                                                                       (ecc
                                                                         (curve Ed25519)
                                                                         (q #D4E1CAFAB105581122B326E89804E3546EF905C0D9B39F161BBD8ABB4B11D14A#)
                                                                       )
                                                                     )")
                                                        (plain-file "guix-hpc.pub"
                                                                    "(public-key
                                                                       (ecc
                                                                         (curve Ed25519)
                                                                         (q #89FBA276A976A8DE2A69774771A92C8C879E0F24614AAAAE23119608707B3F06#)
                                                                       )
                                                                     )"))
                                                    %default-authorized-guix-keys))))
                   (network-manager-service-type config =>
                                                 (network-manager-configuration (inherit config)
                                                                                (vpn-plugins (list network-manager-openvpn
                                                                                                   network-manager-openconnect))))
                   (delete gdm-service-type)
                   ))

    (operating-system

  (host-name "oryp6")
  ;;(timezone "America/Edmonton")
  (timezone "America/New_York")
  (locale "en_US.utf8")
  (keyboard-layout my-keyboard-layout)

  (kernel linux-lts)
  (kernel-loadable-modules (list nvidia-driver))
  ;;(kernel-loadable-modules (list nvidia-module))
  (kernel-arguments (list
                     ;; Nvidia set-up
                     "nvidia_drm.modeset=1"
                     "nvidia.NVreg_DynamicPowerManagement=0x02"
                     "modprobe.blacklist=nouveau"
                     "modprobe.blacklist=i2c_nvidia_gpu"
                     ;; Fix audio problem: headphone hissing on right ear; cost: loose microphone for headphone
                     ;;"snd_hda_intel.model=clevo-p950"
                     ;;"snd-hda-intel.power-save=0"
                     ;;"snd_hda_intel.power_save=0"
                     ;; hibernate to swap
                    "resume=/dev/sda2"
                    "nmi_watchdog=0"))
  (initrd microcode-initrd)
  (initrd-modules %base-initrd-modules)
  (firmware (list linux-firmware))

;; Use the UEFI variant of GRUB with the EFI System
;; Partition mounted on /boot/efi.
(bootloader (bootloader-configuration
             (bootloader grub-efi-bootloader)
             (targets '("/boot/efi"))
             (timeout 5)
             (keyboard-layout my-keyboard-layout)
             (menu-entries (list
                            (menu-entry
                             (label "Pop!_OS")
                             (linux "/boot/vmlinuz-5.18.10-76051810-generic")
                             (linux-arguments '("root=/dev/nvme1n1p3"))
                             (initrd "/boot/initrd.img-5.18.10-76051810-generic"))
                            ;; TODO: repair entry
                            ;;(menu-entry
                            ;; (label "NixOS")
                            ;; (linux "/boot/efi/vmlinuz-5.15.34-0-generic")
                            ;; (linux-arguments '("root=/dev/nvme1n1p8"))
                            ;; (initrd "/boot/efi/initrd.img-5.15.34-0-generic"))
                            ))
             ))

(file-systems (append
               (list
                ;; boot
                (file-system
                 (device (uuid "0554-6F13" 'fat))
                 (mount-point "/boot/efi")
                 (type "vfat"))
                ;; root
                (file-system
                 (device (uuid "e896af2f-15f1-4503-9564-975e93e79f40" 'ext4))
                 (mount-point "/")
                 (type "ext4"))
                ;; home
                (file-system
                 (device (uuid "e45224c0-20bd-4ba8-880d-2bb84827dce7" 'ext4))
                 (mount-point "/home")
                 (type "ext4"))
                ;; shared volume
                (file-system
                 (device (uuid "7eb6c440-b26d-48d9-b8e9-bce47a46dfa1" 'ext4))
                 (mount-point "/shared")
                 (type "ext4"))
                ;; second harddrive
                (file-system
                 (device (uuid "d3900119-e611-4e5a-887c-cd1dbf3711b4" 'ext4))
                 (mount-point "/extension")
                 (type "ext4"))
                )
               %base-file-systems))

  (swap-devices (list
                 (swap-space
                  (target
                   (uuid "01278a0f-360c-47be-a63d-31376dab09d4")))))

      (users (cons (user-account
                    (name "k8x1d")
                    (comment "Kevin Kaiser")
                    (group "users")
                    ;;(shell (file-append zsh "/bin/zsh"))
                    (supplementary-groups '("wheel" "netdev"
                                            "audio" "video"
                                            "lp" "docker"
  )))
                   %base-user-accounts))

  (packages (append (list
                     ;; EXWM set-up
                     ;;emacs emacs-exwm emacs-desktop-environment
                     ;;emacs-next-pgtk

                     ;; i3 set-up ;;;;
                     i3-gaps ;; package version
                     polybar ;; bar
                     i3lock-color ;; lockscreen
                     alacritty ;; terminal
                     feh ;; wallpaper
                     picom ;; compositor
                     redshift ;; color temperature
                     pavucontrol ;; pulseaudio gui
                     pulseaudio ;; pulseaudio cli
                     xset ;; set keyboard rate
                     setxkbmap ;; set keyboard-layout
                     xss-lock ;; manage lock before-sleep
                     xinput ;; set touchpad
                     xrandr ;; screen manipulation
                     playerctl ;; extra
                     rofi ;;launcher
                     brightnessctl ;; brightness
                     dunst ;; notifications
                     xclip ;; clipboard

                     ;; sway set-up
                     sway swayidle swaybg waybar bemenu swaylock-effects foot libnotify fnott
                     ;; Bluetooth
                     bluez
                     ;; utilities
                     acpi
                     ;;awesome-wm
                     ;;awesome
                     ;;stumpwm
                     ;;sbcl stumpwm `(,stumpwm "lib")

                     ;; Power management
                     tlp
                     ;; Fonts
                     font-dejavu font-juliamono font-gnu-freefont
                     ;; Extra packages
                     nix flatpak
                     ;; Drivers
                     nvidia-driver
                     ;; nvidia-module
                     nvidia-libs
                     ;; For user mounts
                     gvfs
                     ;; for HTTPS access
                     nss-certs)
                    %base-packages))

      (services (cons*

;;(service gnome-desktop-service-type)

(simple-service 'custom-udev-rules udev-service-type (list nvidia-driver))
;;(simple-service 'custom-udev-rules udev-service-type (list nvidia-module))
(service kernel-module-loader-service-type
         '("nvidia"
           "nvidia_modeset"))
           ;;"nvidia_uvm"))

  (service docker-service-type) ;; TODO: investigate when high increase startup-time, TODO: change data-root to save space on root
  (service postgresql-service-type
           (postgresql-configuration
            (data-directory "/shared/Databases/postgresql/data")
            (postgresql postgresql-14)))
  (service postgresql-role-service-type
           (postgresql-role-configuration
            (roles
             (list (postgresql-role
                    (name "k8x1d")
                    (permissions '(createdb login superuser))
                    (create-database? #t))))))

  (service cups-service-type
           (cups-configuration
            (web-interface? #t)))

  ;;(openvpn-client-service)

 ;; (service mpd-service-type
 ;;          (mpd-configuration
 ;;           (outputs
 ;;            (list (mpd-output
 ;;                   (name "PipeWire Sound Server")
 ;;                   (type "pipewire"))
 ;;                  ))))

  (service mpd-service-type
           (mpd-configuration
            (outputs
             (list (mpd-output
                    (name "pulse audio")
                    (type "pulse"))))
                   (user "k8x1d")))

  ;;(service tlp-service-type
  ;;         (tlp-configuration
  ;;          (cpu-scaling-governor-on-ac (list "powersave")) ;; not diff alon on temp
  ;;          (energy-perf-policy-on-ac "powersave") ;; not diff alon on temp
  ;;          (sched-powersave-on-ac? #t) ;; not diff alon on temp
  ;;          (max-lost-work-secs-on-ac 60) ;; not diff alon on temp
  ;;          (disk-idle-secs-on-ac 2)
  ;;          (cpu-min-perf-on-bat 0)
  ;;          (cpu-max-perf-on-bat 30)
  ;;          (cpu-min-perf-on-ac 0)
  ;;          (cpu-max-perf-on-ac 100)
  ;;          ;;(cpu-boost-on-ac? enabled)
  ;;          (sound-power-save-on-bat 0) ;; don't change kernel parameters
  ;;          (pcie-aspm-on-ac "powersave")
  ;;          (start-charge-thresh-bat0 85)
  ;;          (stop-charge-thresh-bat0 90)
  ;;          (runtime-pm-on-ac "auto")))
  (service tlp-service-type)
  (service thermald-service-type)

  ;; Torrents
  (service transmission-daemon-service-type
           (transmission-daemon-configuration
            (download-dir "/shared/torrents")
            (alt-speed-down (* 1024 2)) ;   2 MB/s
            (alt-speed-up 512)))          ; 512 kB/s

  (bluetooth-service #:auto-enable? #f)
  (service nix-service-type)

(screen-locker-service i3lock-color "i3lock")
(screen-locker-service swaylock-effects "swaylock")

;;(service sddm-service-type
;;         (sddm-configuration
;;          (xorg-configuration my-xorg-conf)))
(service sddm-service-type
         (sddm-configuration
          (themes-directory "/shared/Documents/Logiciels/guix_set-up/sddm/themes")
          (theme "sugar-dark")
            ;;;;(sddm (fixpkg sddm)) ;; seem to cause black screen
            ;;;;(xdisplay-start "/home/k8x1d/start-up")
            ;;;;(xsession-command "/shared/Projects/Logiciels/.xinitrc") ;; test
            ;;;;(xsession-command picom)
          (sessions-directory "/shared/Documents/Logiciels/guix_set-up/sddm/wayland-sessions")
          (xsessions-directory "/shared/Documents/Logiciels/guix_set-up/sddm/x-sessions")
          (xorg-configuration my-xorg-conf)))

;;(service lightdm-service-type (lightdm-configuration
;;                               (xorg-configuration my-xorg-conf)))

;;(service slim-service-type (slim-configuration
;;                            (display ":0")
;;                            (vt "vt7")
;;                            (default-user "k8x1d")
;;                            (xorg-configuration my-xorg-conf)))

;;  (service gdm-service-type
;;           (gdm-configuration
;;            (wayland? #t)
;;            (xorg-configuration my-xorg-conf)))

  %my-desktop-services

  ))

  ;; Allow resolution of '.local' host names with mDNS.
  (name-service-switch %mdns-host-lookup-nss)

    )
