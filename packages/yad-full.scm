(define-module (yad-full)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix gexp)
  #:use-module (guix utils)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix bzr-download)
  #:use-module (guix git-download)
  #:use-module ((guix build utils) #:select (alist-replace))
  #:use-module (guix build-system cmake)
  #:use-module (guix build-system glib-or-gtk)
  #:use-module (guix build-system gnu)
  #:use-module (guix build-system meson)
  #:use-module (guix build-system perl)
  #:use-module (guix build-system python)
  #:use-module (guix build-system waf)
  #:use-module (gnu packages)
  #:use-module (gnu packages algebra)
  #:use-module (gnu packages audio)
  #:use-module (gnu packages autotools)
  #:use-module (gnu packages base)
  #:use-module (gnu packages bash)
  #:use-module (gnu packages boost)
  #:use-module (gnu packages texinfo)
  #:use-module (gnu packages check)
  #:use-module (gnu packages compression)
  #:use-module (gnu packages docbook)
  #:use-module (gnu packages documentation)
  #:use-module (gnu packages enchant)
  #:use-module (gnu packages fontutils)
  #:use-module (gnu packages freedesktop)
  #:use-module (gnu packages fribidi)
  #:use-module (gnu packages gettext)
  #:use-module (gnu packages ghostscript)
  #:use-module (gnu packages gl)
  #:use-module (gnu packages glib)
  #:use-module (gnu packages gnome)
  #:use-module (gnu packages graphviz)
  #:use-module (gnu packages icu4c)
  #:use-module (gnu packages image)
  #:use-module (gnu packages iso-codes)
  #:use-module (gnu packages libffi)
  #:use-module (gnu packages linux)
  #:use-module (gnu packages m4)
  #:use-module (gnu packages man)
  #:use-module (gnu packages pcre)
  #:use-module (gnu packages pdf)
  #:use-module (gnu packages perl)
  #:use-module (gnu packages perl-check)
  #:use-module (gnu packages pkg-config)
  #:use-module (gnu packages pretty-print)
  #:use-module (gnu packages python)
  #:use-module (gnu packages python-build)
  #:use-module (gnu packages python-xyz)
  #:use-module (gnu packages gstreamer)
  #:use-module (gnu packages guile)
  #:use-module (gnu packages gtk)
  #:use-module (gnu packages guile-xyz)
  #:use-module (gnu packages cups)
  #:use-module (gnu packages version-control)
  #:use-module (gnu packages video)
  #:use-module (gnu packages vulkan)
  #:use-module (gnu packages web)
  #:use-module (gnu packages webkit)
  #:use-module (gnu packages xml)
  #:use-module (gnu packages xorg)
  #:use-module (gnu packages xdisorg)
  #:use-module (gnu packages pulseaudio)
  #:use-module (srfi srfi-1)
  #:use-module (srfi srfi-26)
  #:use-module (ice-9 match))

(define-public yad-full
  (package
    (name "yad")
    (version "12.0")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
             (url "https://github.com/v1cont/yad")
             (commit (string-append "v" version))))
       (file-name (git-file-name name version))
       (sha256
        (base32 "1nbbw4vwlxjlp83d35w54952b6rrn8qlr3d053lisqwl0hfcm7if"))))
    (build-system glib-or-gtk-build-system)
    (arguments
     `(#:configure-flags
       ;; Passing --enable-foo will silently disable foo if prerequisite
       ;; inputs are missing, not abort the build as one might expect.
       ;; ‘--enable-html’ adds a huge webkitgtk dependency.  It was never
       ;; present in the past and nobody complained.
       '("--enable-html" ;; for supporting html dialog
         "--enable-icon-browser"
         "--enable-sourceview" ;; for enabling syntax highlighting in text-info dialog
         "--enable-spell")     ;; gspell checking support
       #:phases
       (modify-phases %standard-phases
         (add-after 'bootstrap 'intltoolize
           (lambda _
             (invoke "intltoolize" "--force" "--automake"))))))
    (inputs
     (list gspell gtk+ webkitgtk-with-libsoup2 gtksourceview))
    (native-inputs
     (list autoconf automake intltool pkg-config))
    (home-page "https://sourceforge.net/projects/yad-dialog/")
    (synopsis "GTK+ dialog boxes for shell scripts")
    (description
     "This program allows you to display GTK+ dialog boxes from command line or
shell scripts.  Example of how to use @code{yad} can be consulted at
@url{https://sourceforge.net/p/yad-dialog/wiki/browse_pages/}.")
    (license license:gpl3+)))
yad-full
