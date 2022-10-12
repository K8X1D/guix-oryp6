(use-modules (gnu)
	     (nongnu packages linux)
	     (nongnu system linux-initrd)
	     (nongnu packages nvidia)
	     (gnu system nss)
	     (srfi srfi-1))

(use-service-modules
 desktop ;; desktop
 linux ;; module-loader
 file-sharing ;; transmission
 xorg ;; xorg-configuration
 nix ;; nix
 docker ;; docker
 networking ;; network-manager
 cups ;; cups
 audio ;; mpd
 databases ;; postgresql
 pm ;; tlp, thermald
 sddm ;;sddm
 )

(use-package-modules
 certs ;; nss-certs
 databases ;; postgresql
 fonts ;; dejavu, juliamono, freefont
 gnome ;; network-manager-openvpn
 package-management ;; nix
 wm ;; 13
 suckless ;; dmenu
 xorg ;; xterm
 linux ;; acpi 
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
	      (timeout 2)
	      (keyboard-layout my-keyboard-layout)
	      (menu-entries (list
			     (menu-entry
			      (label "Arch Linux")
			      (linux "/boot/vmlinuz-linux")
			      (linux-arguments '("root=/dev/nvme1n1p3"))
			      (initrd "/boot/initramfs-linux.img"))
			     ;; (linux-arguments '("root=/dev/nvme1n1p3"
			     ;;			 "rw"
			     ;;			 "nowatchdog"
			     ;;			 "resume=UUID=29a96c1b-45e3-4c80-be79-12cc266f4edd"))
			     ;; (initrd "/boot/initramfs-linux.img"))
			     ))
	      ))

 (file-systems (append
		(list
		 ;; boot
		 (file-system
		  (device (uuid "8A7B-663A" 'fat))
		  (mount-point "/boot/efi")
		  (type "vfat"))
		 ;; root
		 (file-system
		  (device (uuid "f0d78c0f-fef8-41e7-ad4f-cc5c808c6850" 'ext4))
		  (mount-point "/")
		  (type "ext4"))
		 ;; home
		 (file-system
		  (device (uuid "deb07de1-743d-4665-98a6-9470b43a6206" 'ext4))
		  (mount-point "/home")
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
		  (uuid "29a96c1b-45e3-4c80-be79-12cc266f4edd")))))

 (users (cons (user-account
	       (name "k8x1d")
	       (comment "Kevin Kaiser")
	       (group "users")
	       (supplementary-groups '("wheel"
				       "netdev"
				       "audio"
				       "video"
				       "lp"
				       "docker"
				       )))
	      %base-user-accounts))

 (packages (append (list
		    ;; window managers
		    i3-gaps i3status dmenu slock
		    ;; terminal emulator
		    xterm

		    ;; sway set-up
		    ;; utilities
		    acpi

		    ;; Power management
		    tlp
		    ;; Fonts
		    font-dejavu font-juliamono font-gnu-freefont
		    ;; Extra packages
		    nix
		    ;;flatpak
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
	    ;; Drivers 
	    (simple-service 'custom-udev-rules udev-service-type (list nvidia-driver))
	    (service kernel-module-loader-service-type
		     '("nvidia"
		       "nvidia_modeset"))
	    ;; Nix
	    (service nix-service-type)
	    ;; PAM
	    (screen-locker-service slock "slock")
	    ;;(screen-locker-service i3lock-color "i3lock")
	    ;;(screen-locker-service swaylock-effects "swaylock")
	    ;; Databases 
	    (service docker-service-type) ;; TODO: investigate when high increase startup-time, TODO: change data-root to save space on root
	    (service postgresql-service-type
		     (postgresql-configuration
		      (data-directory "/extension/Data/postgres/data")
		      (postgresql postgresql-14)))
	    (service postgresql-role-service-type
		     (postgresql-role-configuration
		      (roles
		       (list (postgresql-role
			      (name "k8x1d")
			      (permissions '(createdb login superuser))
			      (create-database? #t))))))
	    ;; Desktop utilities
	    (service cups-service-type
		     (cups-configuration
		      (web-interface? #t)))
	    (service mpd-service-type
		     (mpd-configuration
		      (outputs
		       (list (mpd-output
			      (name "pulse audio")
			      (type "pulse"))))
		      (user "k8x1d")
		      (music-dir "~/Music")
		      (playlist-dir "~/.config/mpd/playlists")
		      (db-file "~/.config/mpd/database")
		      (state-file "~/.config/mpd/state")
		      (sticker-file "~/.config/mpd/sticker.sql")
		      (port "6600")
		      (address "any")
		      ))
	    ;; Torrents
	    (service transmission-daemon-service-type
		     (transmission-daemon-configuration
		      (download-dir "/extension/Multimedia/Torrents")
		      (alt-speed-down (* 1024 2)) ;   2 MB/s
		      (alt-speed-up 512)))          ; 512 kB/s

	    (bluetooth-service #:auto-enable? #f)
	    ;; Power management
	    (service tlp-service-type)
	    (service thermald-service-type)
	    ;; Login manager
	    (service sddm-service-type
		     (sddm-configuration
		      (themes-directory "/extension/Work/Documents/Softwares/Guix/sddm/themes")
		      (theme "sugar-dark")
		      (sessions-directory "/extension/Work/Documents/Softwares/Guix/sddm/wayland-sessions")
		      (xsessions-directory "/extension/Work/Documents/Softwares/Guix/sddm/x-sessions")
		      (xorg-configuration my-xorg-conf)))
	    ;;(service slim-service-type (slim-configuration
	    ;;				(display ":0")
	    ;;				(vt "vt7")
	    ;;				(default-user "k8x1d")
	    ;;				(xorg-configuration my-xorg-conf)))
	    ;; Others desktops utilities
	    %my-desktop-services
	    ))
 ;; Allow resolution of '.local' host names with mDNS.
 (name-service-switch %mdns-host-lookup-nss))
