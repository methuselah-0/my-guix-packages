(define-module (wayvnc)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix gexp)
  #:use-module (guix git-download)
  #:use-module (guix build-system asdf)
  #:use-module (guix build-system cmake)
  #:use-module (guix build-system copy)
  #:use-module (guix build-system gnu)
  #:use-module (guix build-system haskell)
  #:use-module (guix build-system meson)
  #:use-module (guix build-system perl)
  #:use-module (guix build-system python)
  #:use-module (guix build-system trivial)
  #:use-module (guix utils)
  #:use-module (gnu packages)
  #:use-module (gnu packages bash)
  #:use-module (gnu packages admin)
  #:use-module (gnu packages autotools)
  #:use-module (gnu packages base)
  #:use-module (gnu packages bison)
  #:use-module (gnu packages build-tools)
  #:use-module (gnu packages calendar)
  #:use-module (gnu packages check)
  #:use-module (gnu packages commencement)
  #:use-module (gnu packages compression)
  #:use-module (gnu packages datastructures)
  #:use-module (gnu packages docbook)
  #:use-module (gnu packages documentation)
  #:use-module (gnu packages fontutils)
  #:use-module (gnu packages freedesktop)
  #:use-module (gnu packages fribidi)
  #:use-module (gnu packages gawk)
  #:use-module (gnu packages gl)
  #:use-module (gnu packages glib)
  #:use-module (gnu packages gperf)
  #:use-module (gnu packages gtk)
  #:use-module (gnu packages gnome)
  #:use-module (gnu packages haskell-check)
  #:use-module (gnu packages haskell-web)
  #:use-module (gnu packages haskell-xyz)
  #:use-module (gnu packages image)
  #:use-module (gnu packages imagemagick)
  #:use-module (gnu packages libevent)
  #:use-module (gnu packages libffi)
  #:use-module (gnu packages linux)
  #:use-module (gnu packages lisp-check)
  #:use-module (gnu packages lisp-xyz)
  #:use-module (gnu packages logging)
  #:use-module (gnu packages lua)
  #:use-module (gnu packages m4)
  #:use-module (gnu packages man)
  #:use-module (gnu packages maths)
  #:use-module (gnu packages mpd)
  #:use-module (gnu packages pcre)
  #:use-module (gnu packages perl)
  #:use-module (gnu packages pkg-config)
  #:use-module (gnu packages pretty-print)
  #:use-module (gnu packages pulseaudio)
  #:use-module (gnu packages python)
  #:use-module (gnu packages python-build)
  #:use-module (gnu packages python-crypto)
  #:use-module (gnu packages python-xyz)
  #:use-module (gnu packages readline)
  #:use-module (gnu packages serialization)
  #:use-module (gnu packages sphinx)
  #:use-module (gnu packages suckless)
  #:use-module (gnu packages texinfo)
  #:use-module (gnu packages textutils)
  #:use-module (gnu packages time)
  #:use-module (gnu packages tls)
  #:use-module (gnu packages video)
  #:use-module (gnu packages web)
  #:use-module (gnu packages wm)
  #:use-module (gnu packages ninja)
  #:use-module (gnu packages xdisorg)
  #:use-module (gnu packages xml)
  #:use-module (gnu packages xorg))

(define-public wayvnc
  (package
    (name "wayvnc")
    (version ;;"0.5.0"
     "0.6.2"
     )
    (source (origin
             (method git-fetch)
             (uri (git-reference
                   (commit ;;"267a4e55e3c47e2ba309fc99d4af7beb9cedd274"
                    "fd652e7a233e3dc4a49a38038e471601ef6197b3"
                    )
                   (url "https://github.com/any1/wayvnc.git")))
             (sha256
              (base32
               ;;"0syacpqwb7gwlpjdg0xhck4rh33w3vibbbfdwkw36kzqlknkyv9h"
               "0pj755bnybjs9nkm2srj2ir329fym4bqjlnxg49j6c3675797mf8"
               ))))
    
    ;; (source (origin
    ;;           (method url-fetch)
    ;;           (uri (string-append "https://github.com/any1/wayvnc/archive/refs/tags/" version ".tar.gz"))
    ;;           (sha256
    ;;            (base32
    ;;             "01qys4yn2avxr8gx4gx16y7mxxv3hlimk4m5vyp16j2p30df5xsp"))))
    (build-system meson-build-system)
    (inputs (list 
             aml
             libdrm
             ;;gbm (optional)
             ;; add ffmpeg because it wants libavcodec when mesa (gbm) is added to neatvnc
             ffmpeg
             gnutls ;; required by neatvnc runtime
             libxkbcommon
             libjpeg-turbo ;; required by neatvnc runtime
             neatvnc
             linux-pam ;;(optional)
             pixman
             jansson
             zlib ;; required by neatvnc runtime
             ))
    (native-inputs (list gcc-toolchain ninja meson pkg-config wlroots scdoc))
    (home-page "https://github.com/any1/wayvnc")
    (synopsis "A VNC server for wlroots-based Wayland compositors")
    (description "Wayvnc is a VNC server for wlroots-based Wayland compositors (Gnome, KDE and Weston are not supported). It attaches to a running Wayland session, creates virtual input devices, and exposes a single display via the RFB protocol. The Wayland session may be a headless one, so it is also possible to run wayvnc without a physical display attached. It supports authentication and encryption.")
    (license license:isc)))
(define-public aml
  (package
   (name "aml")
   (version ;;"0.5.0"
    "0.3.0"
    )
   (source (origin
            (method git-fetch)
            (uri (git-reference
                  (commit ;;"f4efd0edec8d39b176e32f2478a19b3512eeed1c"
                   "b83f3576ce4187d9285f06e9066ef43a691464d4"
                   )
                  (url "https://github.com/any1/aml.git")))
            (sha256
             (base32
              ;;"013f3qg7bhz86rn5sz1v7zbq4bwkc0viyv81nanjs6flxr6l6wn1"
              "0r4k233hh3iqc6zlhh2agmdj8q973x49pdixhz7h5hz7md38qzq5"
              ))))
    
    ;; (source (origin
    ;;           (method url-fetch)
    ;;           (uri (string-append "https://github.com/any1/aml/archive/refs/tags/" version ".tar.gz"))
    ;;           (sha256
    ;;            (base32
    ;;             "01qys4yn2avxr8gx4gx16y7mxxv3hlimk4m5vyp16j2p30df5xsp"))))
    (build-system meson-build-system)
    ;; (inputs (list 
    ;;          aml
    ;;          drm
    ;;          ;;gbm (optional)
    ;;          libxkbcommon
    ;;          neatvnc
    ;;          ;;pam (optional)
    ;;          pixman
    ;;          jansson
    ;;          ))
    (native-inputs (list ninja meson pkg-config))
    (home-page "https://github.com/any1/aml")
    (synopsis "Andri's Main Loop")
    (description "Andri's Main Loop is a C library featuring File descriptor event handlers, Timers, Tickers, Signal handlers, Idle dispatch callbacks, Thread pool, and Interoperability with other event loops")
    (license license:isc)))

(define-public neatvnc
  (package
   (name "neatvnc")
   (version ;;"0.5.0"
    "0.6.0"
    )
   (source (origin
            (method git-fetch)
            (uri (git-reference
                  (commit ;;"afe37b983db9b8fbf1189e07f756276e85a780e8"
                   "8b3dc1ae6099dcfa73aec3ae11df2fdc58540d14"
                   )
                  (url "https://github.com/any1/neatvnc.git")))
            (sha256
             (base32
              ;;"1d4vdl7h7ia399j2kvw4npqzvf1pklw50k6abrmdgrn7asfd8sxd"
              "0klikf1iphsm11c2syhcgayjpb3cnzmynz6hbl69j609y20ms4yy"
              ))))
   (build-system meson-build-system)
   (native-inputs (list libdrm meson pkg-config))
   (inputs (list aml ffmpeg gnutls libdrm libjpeg-turbo
                 ;;gbm (optional)
                 mesa ;; has gbm in it, this makes wayvnc package ask for libavcodec which is in ffmpeg
                 ;;pam (optional)
                 pixman zlib))
   (home-page "https://github.com/any1/neatvnc") ;; TODO continue here!
   (synopsis "A VNC server library that's intended to be fast and neat")
   (description "Neatvnc is a liberally licensed VNC server library with the goals of Speed, Clean interface, and Interoperability with the Freedesktop.org ecosystem.")
   (license license:isc)))

;;wayvnc
;;aml
;;neatvnc

