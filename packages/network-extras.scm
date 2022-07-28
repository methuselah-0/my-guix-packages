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
   (version "3.0.0")
   (source
    (origin
     (method url-fetch)
     (uri "http://www.cipherdyne.org/fwknop/download/fwknop-2.6.10.tar.gz")
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
   (synopsis "Tool that does fwknop stuff")
   (description "next-gen port-knocking")
   (home-page "http://www.cipherdyne.org/fwknop/index.html")
   (license license:gpl2)))
(define-public fwknop-server
  (package
   (name "fwknop-server")
   (version "2.6.10")
   (source
    (origin
     (method url-fetch)
     (uri "http://www.cipherdyne.org/fwknop/download/fwknop-2.6.10.tar.gz")
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
   (synopsis "Tool that does fwknop stuff")
   (description "next-gen port-knocking")
   (home-page "http://www.cipherdyne.org/fwknop/index.html")
   (license license:gpl2)))
