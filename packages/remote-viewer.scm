;;; GNU Guix --- Functional package management for GNU
;;; Copyright © 2016 David Craven <david@craven.ch>
;;; Copyright © 2018, 2019, 2020 Tobias Geerinckx-Rice <me@tobias.gr>
;;; Copyright © 2019 Rutger Helling <rhelling@mykolab.com>
;;; Copyright © 2019, 2020 Marius Bakke <mbakke@fastmail.com>
;;;
;;; This file is part of GNU Guix.
;;;
;;; GNU Guix is free software; you can redistribute it and/or modify it
;;; under the terms of the GNU General Public License as published by
;;; the Free Software Foundation; either version 3 of the License, or (at
;;; your option) any later version.
;;;
;;; GNU Guix is distributed in the hope that it will be useful, but
;;; WITHOUT ANY WARRANTY; without even the implied warranty of
;;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;;; GNU General Public License for more details.
;;;
;;; You should have received a copy of the GNU General Public License
;;; along with GNU Guix.  If not, see <http://www.gnu.org/licenses/>.

(define-module (remote-viewer)
  #:use-module (gnu packages)
  #:use-module (gnu packages spice)
  #:use-module (gnu packages base)
  #:use-module (gnu packages bash)
  #:use-module (gnu packages compression)
  #:use-module (gnu packages cyrus-sasl)
  #:use-module (gnu packages gettext)  
  #:use-module (gnu packages gl)
  #:use-module (gnu packages glib)
  #:use-module (gnu packages gnome)
  #:use-module (gnu packages gstreamer)
  #:use-module (gnu packages gsasl)
  #:use-module (gnu packages gtk)
  #:use-module (gnu packages image)
  #:use-module (gnu packages libusb)
  #:use-module (gnu packages linux)
  #:use-module (gnu packages nss)
  #:use-module (gnu packages pkg-config)
  #:use-module (gnu packages perl)  
  #:use-module (gnu packages pulseaudio)
  #:use-module (gnu packages python)
  #:use-module (gnu packages security-token)
  #:use-module (gnu packages tls)
  #:use-module (gnu packages virtualization)  
  #:use-module (gnu packages xorg)
  #:use-module (gnu packages xdisorg)
  #:use-module (gnu packages xiph)
  #:use-module (gnu packages xml)
  #:use-module (guix build-system gnu)
  #:use-module (guix build-system meson)
  #:use-module (guix download)
  #:use-module (guix packages)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix utils))

(define-public remote-viewer
  (package
    (name "remote-viewer")
    (version "11.0")
    (source (origin
              (method url-fetch)
              (uri (string-append
                    "https://virt-manager.org/download/sources/virt-viewer/"
                    "virt-viewer-" version ".tar.xz"))
              (sha256
               (base32
                "1l5bv6x6j21l487mk3n93ai121gg62n6b069r2jpf72cbhra4gx4"))))
    (build-system meson-build-system)
    (arguments `(#:phases
                 (modify-phases %standard-phases
                   (add-after 'unpack 'fix-meson
                     (lambda _
                         (substitute* "data/meson.build"
                           (("    desktop,\n$")
                            "")
                           (("    mimetypes,\n$")
                            "")
                           (("    metainfo,\n$")
                            ""))
                         #t)))))
    (native-inputs
     (list `(,glib "bin")
           gettext-minimal
           perl                         ;for pod2man
           pkg-config
           python))
    (inputs
     (list bash-completion
           gtk+
           gtk-vnc
           libcap
           libgovirt
           libvirt-glib
           libxml2
           spice-gtk
           vte))
    (synopsis "Graphical console client for virtual machines")
    (description "Graphical console client for virtual machines using SPICE or
VNC.")
    (home-page "https://virt-manager.org")
    (license license:gpl2+)))
