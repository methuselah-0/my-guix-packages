(define-module (network-extras)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix git-download)
  #:use-module (gnu packages admin)
  #:use-module (gnu packages base)  
  #:use-module (gnu packages autotools)
  ;;#:use-module (gnu packages m4)  
  #:use-module (gnu packages libedit)
  #:use-module (gnu packages texinfo)  
  #:use-module (gnu packages linux)  
  #:use-module (gnu packages python) ;; python-pytest
  #:use-module (guix build-system gnu)
  ;;#:use-module (gnu packages graphviz)
  #:use-module ((guix licenses) #:prefix license:))

(define-public fwknop-client
  (package
    (name "fwknop-client")
    (version "2.6.10")
    (source
     (origin
       (method url-fetch)
       (uri (string-append "http://www.cipherdyne.org/fwknop/download/fwknop-" version ".tar.gz"))
       (sha256
        (base32
         "1wbwa8fzqp6dmc59dcm26c9nb75zlix4m55czh855v4jmq5ha59b"))))
    (build-system gnu-build-system)
    (arguments
     `(#:configure-flags '("--disable-server")
       #:phases (modify-phases %standard-phases
                  (add-after 'unpack 'fix-compilation-with-GCC's-fno-common-flag
                    (lambda _
                      (substitute* "client/log_msg.h"
                        (("log_level_t") ""))
                      #t)))))
    (native-inputs
     `(("libtool" ,libtool)
       ("which" ,which)
       ("automake" ,automake)
       ("autoconf" ,autoconf)
       ("libpcap" ,libpcap)
       ("texinfo" ,texinfo)))
    (propagated-inputs
     `(("iptables" ,iptables)))
    (synopsis "Next generation port-knocking")
    (description "Fwknop implements an authorization scheme known as Single Packet Authorizatio (SPA) for Linux systems running iptables. This mechanism requires only a single encrypted and non-replayed packet to communicate various pieces of information including desired access through an iptables policy. The main application of this program is to use iptables in a default-drop stance to protect services such as SSH with an additional layer of security in order to make the exploitation of vulnerabilities (both 0-day and unpatched code) much more difficult. This package contains the fwknop client.")
    (home-page "http://www.cipherdyne.org/fwknop/index.html")
    (license license:gpl2)))
(define-public fwknop-server
  (package
    (name "fwknop-server")
    (version "2.6.10")
    (source
     (origin
       (method url-fetch)
       (uri (string-append "http://www.cipherdyne.org/fwknop/download/fwknop-" version ".tar.gz"))
       (sha256
        (base32
         "1wbwa8fzqp6dmc59dcm26c9nb75zlix4m55czh855v4jmq5ha59b"))))
    (build-system gnu-build-system)
    (arguments
     `(#:configure-flags '("--disable-client")
       #:phases (modify-phases %standard-phases
                  (add-after 'unpack 'fix-compilation-with-GCC's-fno-common-flag
                    (lambda _
                      (substitute* "client/log_msg.h"
                        (("log_level_t") ""))
                      #t)))))
    (native-inputs
     `(("libtool" ,libtool)
       ("which" ,which)
       ("automake" ,automake)
       ("autoconf" ,autoconf)
       ("libpcap" ,libpcap)
       ("texinfo" ,texinfo)))
    (propagated-inputs
     `(("iptables" ,iptables)))
    (synopsis "Next generation port-knocking")
    (description "Fwknop implements an authorization scheme known as Single Packet Authorizatio (SPA) for Linux systems running iptables. This mechanism requires only a single encrypted and non-replayed packet to communicate various pieces of information including desired access through an iptables policy. The main application of this program is to use iptables in a default-drop stance to protect services such as SSH with an additional layer of security in order to make the exploitation of vulnerabilities (both 0-day and unpatched code) much more difficult. This package contains the fwknop daemon.")
    (home-page "http://www.cipherdyne.org/fwknop/index.html")
    (license license:gpl2)))
