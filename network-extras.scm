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
  #:use-module ((guix licenses) #:prefix license:)
  
  )

(define-public fwknop
  (package
   (name "fwknop")
   (version "3.0.0")
   (source
    (origin
     (method git-fetch)
     (uri (git-reference
           (url "https://github.com/mrash/fwknop.git")           
	   (commit "cd72de9f43076613a05df1c7319a272e97b940de")))
     (sha256
      (base32
       ;;  "16m1ifr0ymf2wk2rvcrza3p6cvs21cl408fp0m03s1mc2ydlgzd0"))))
       "0fgdayj1fj5kr25q4cw8hh1avg9j9cg0k631m54ga2aaya1cbaz5"))))
   (build-system gnu-build-system)
   ;; (arguments
    ;;  '(#:make-flags (list "CC=gcc")
    ;;    #:phases (modify-phases
    ;;                 %standard-phases
    ;;                 (delete 'configure)
    ;;                 (delete 'check)
    ;;                 (replace 'install
    ;;                          (lambda _
    ;;                            (let*
    ;;                                ((bin-dir  (string-append %output "/bin"))
    ;;                                 (bin-file (string-append bin-dir "/prips")))
    ;;                              (mkdir-p bin-dir)
    ;;                              (copy-file "prips" bin-file)
    ;;                              (chmod bin-file #o700)))))))
   (native-inputs
    `(
      ("libtool" ,libtool)
      ("which" ,which)
      ("automake" ,automake)
      ("autoconf" ,autoconf)
      ;;("m4" ,m4)
      ;;	("python-setuptools" ,python-setuptools)
      ("libpcap" ,libpcap)
      ("texinfo" ,texinfo)
      ))
   (propagated-inputs
    `(
      ("iptables" ,iptables)
      ))
   (synopsis "Tool that does fwknop stuff")
   (description "next-gen port-knocking")
   (home-page "https://devel.ringlet.net/sysutils/prips/")
   (license license:gpl2)))
