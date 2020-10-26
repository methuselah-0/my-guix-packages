(define-module (perl-extras)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix git-download)
  #:use-module (guix build-system perl)
  #:use-module (gnu packages web) ;; perl-lwp-mediatypes, perl-uri
  #:use-module (gnu packages perl)
  #:use-module (gnu packages perl-check)
  #:use-module ((guix licenses) #:prefix license:))

(define-public perl-data-ical
  (package
   (name "perl-data-ical")
   (version "0.24")
   (source
    (origin
     (method url-fetch)
     (uri (string-append
           "mirror://cpan/authors/id/B/BP/BPS/Data-ICal-"
           version
           ".tar.gz"))
     (sha256
      (base32
       "1zrdsnyda9h7qbjq9lpg2f7ll4z7w0akd0nvq0vk7ic6934cfcbk"))))
   (build-system perl-build-system)
   (native-inputs
    ;; manually added perl-module-install
    `(("perl-module-install" ,perl-module-install)
      ("perl-test-longstring" ,perl-test-longstring)
      ("perl-test-nowarnings" ,perl-test-nowarnings)
      ("perl-test-warn" ,perl-test-warn)))
   (propagated-inputs
    `(("perl-class-accessor" ,perl-class-accessor)
      ("perl-class-returnvalue"
       ,perl-class-returnvalue)
      ("perl-text-vfile-asdata"
       ,perl-text-vfile-asdata)))
   (home-page
    "https://metacpan.org/release/Data-ICal")
   (synopsis
    "Generates iCalendar (RFC 2445) calendar files")
   (description "ical stuff")
   (license license:perl-license)))
(define-public perl-class-returnvalue
(package
  (name "perl-class-returnvalue")
  (version "0.55")
  (source
    (origin
      (method url-fetch)
      (uri (string-append
             "mirror://cpan/authors/id/J/JE/JESSE/Class-ReturnValue-"
             version
             ".tar.gz"))
      (sha256
        (base32
          "1gg4n1gryignn6vw240kqgvnsq9a8bn511d9sz639xvqbn43cf7d"))))
  (build-system perl-build-system)
  ;; added manually
  (native-inputs
   `(("perl-module-build" ,perl-module-build)
     ("perl-module-install" ,perl-module-install)))
  ;; (inputs
  ;;  `(("perl-module-build" ,perl-module-build)))
  (propagated-inputs
    `(("perl-devel-stacktrace" ,perl-devel-stacktrace)))
  (home-page
    "https://metacpan.org/release/Class-ReturnValue")
  (synopsis "A smart return value object")
  (description "perl-class-returnvalue stuff")
  (license license:perl-license))
  )
(define-public perl-text-vfile-asdata
  (package
  (name "perl-text-vfile-asdata")
  (version "0.08")
  (source
    (origin
      (method url-fetch)
      (uri (string-append
             "mirror://cpan/authors/id/R/RC/RCLAMP/Text-vFile-asData-"
             version
             ".tar.gz"))
      (sha256
        (base32
          "0apq6aakcy0js1r5yiw3dmcy8x8sf4s24s8aarr52z4q1xgap4dj"))))
  (build-system perl-build-system)
  (propagated-inputs
    `(("perl-class-accessor-chained" 
       ,perl-class-accessor-chained)))
  (home-page
    "https://metacpan.org/release/Text-vFile-asData")
  (synopsis
    "parse vFile formatted files into data structures")
  (description "vfile-as-data stuff")
  (license license:perl-license)))
(define-public perl-devel-stacktrace
  (package
  (name "perl-devel-stacktrace")
  (version "2.04")
  (source
    (origin
      (method url-fetch)
      (uri (string-append
             "mirror://cpan/authors/id/D/DR/DROLSKY/Devel-StackTrace-"
             version
             ".tar.gz"))
      (sha256
        (base32
          "0mb8bngjq7s3kbh95h3ig4p3jfb156c4r0d53z344gbxaknh6g6d"))))
  (build-system perl-build-system)
  (home-page
    "https://metacpan.org/release/Devel-StackTrace")
  (synopsis "An object representing a stack trace")
  (description "devel-stacktrace stuff")
  (license license:artistic2.0)))
(define-public perl-devel-repl
  (package
  (name "perl-devel-repl")
  (version "1.003028")
  (source
    (origin
      (method url-fetch)
      (uri (string-append
             "mirror://cpan/authors/id/E/ET/ETHER/Devel-REPL-"
             version
             ".tar.gz"))
      (sha256
        (base32
          "1ngl4pkw46f5vl7k74kaj1zb6ap21r7m13k5dg1h202581wxwjhs"))))
  (build-system perl-build-system)
  (native-inputs
    `(("perl-test-fatal" ,perl-test-fatal)))
  (propagated-inputs
    `(("perl-app-nopaste" ,perl-app-nopaste)
      ("perl-b-keywords" ,perl-b-keywords)
      ("perl-data-dump-streamer"
       ,perl-data-dump-streamer)
      ("perl-data-dumper-concise"
       ,perl-data-dumper-concise)
      ("perl-file-homedir" ,perl-file-homedir)
      ("perl-file-next" ,perl-file-next)
      ("perl-lexical-persistence"
       ,perl-lexical-persistence)
      ("perl-module-refresh" ,perl-module-refresh)
      ("perl-module-runtime" ,perl-module-runtime)
      ("perl-moose" ,perl-moose)
      ("perl-moosex-getopt" ,perl-moosex-getopt)
      ("perl-moosex-object-pluggable"
       ,perl-moosex-object-pluggable)
      ("perl-namespace-autoclean"
       ,perl-namespace-autoclean)
      ("perl-ppi" ,perl-ppi)
      ("perl-ppi-xs" ,perl-ppi-xs)
      ("perl-sys-sigaction" ,perl-sys-sigaction)
      ("perl-task-weaken" ,perl-task-weaken)))
  (home-page
    "https://metacpan.org/release/Devel-REPL")
  (synopsis "A modern perl interactive shell")
  (description "devel-repl stuff")
  (license license:perl-license)))
(define-public perl-app-nopaste
  (package
  (name "perl-app-nopaste")
  (version "1.013")
  (source
    (origin
      (method url-fetch)
      (uri (string-append
             "mirror://cpan/authors/id/E/ET/ETHER/App-Nopaste-"
             version
             ".tar.gz"))
      (sha256
        (base32
          "1c1bjpnzxfw22hqkysr7d2y07zfqhwgzc2s2b3ywm449d1qikm1w"))))
  (build-system perl-build-system)
  (native-inputs
   ;; was perl-libwww-perl before
    `(("perl-libwww" ,perl-libwww)
      ("perl-test-deep" ,perl-test-deep)
      ("perl-test-fatal" ,perl-test-fatal)))
  (propagated-inputs
    `(("perl-browser-open" ,perl-browser-open)
      ("perl-class-load" ,perl-class-load)
      ("perl-clipboard" ,perl-clipboard)
      ("perl-getopt-long-descriptive"
       ,perl-getopt-long-descriptive)
      ("perl-json-maybexs" ,perl-json-maybexs)
   ;; was perl-libwww-perl before      
      ("perl-libwww" ,perl-libwww)
      ("perl-module-pluggable" ,perl-module-pluggable)
      ("perl-module-runtime" ,perl-module-runtime)
      ("perl-namespace-clean" ,perl-namespace-clean)
      ("perl-path-tiny" ,perl-path-tiny)
      ("perl-uri" ,perl-uri)
      ("perl-www-mechanize" ,perl-www-mechanize)
      ("perl-www-pastebin-pastebincom-create"
       ,perl-www-pastebin-pastebincom-create)))
  (home-page
    "https://metacpan.org/release/App-Nopaste")
  (synopsis "Easy access to any pastebin")
  (description "app-nopaste stuff")
  (license license:perl-license)))
(define-public perl-data-dump-streamer
  (package
  (name "perl-data-dump-streamer")
  (version "2.40")
  (source
    (origin
      (method url-fetch)
      (uri (string-append
             "mirror://cpan/authors/id/Y/YV/YVES/Data-Dump-Streamer-"
             version
             ".tar.gz"))
      (sha256
        (base32
          "0d8x14gr1lfbgiqklprpazy7fyxkwnq0f1nbbp3fj3f275p3bgi4"))))
  (build-system perl-build-system)
  (native-inputs
    `(("perl-extutils-depends" ,perl-extutils-depends)
      ("perl-module-build" ,perl-module-build)))
  (propagated-inputs
    `(("perl-algorithm-diff" ,perl-algorithm-diff)
      ("perl-b-utils" ,perl-b-utils)
      ("perl-json-xs" ,perl-json-xs)
      ("perl-padwalker" ,perl-padwalker)))
  (home-page
    "https://metacpan.org/release/Data-Dump-Streamer")
  (synopsis
    "Accurately serialize a data structure as Perl code.")
  (description "data-dump-streamer stuff")
  (license license:perl-license)))
(define-public perl-file-next
  (package
  (name "perl-file-next")
  (version "1.18")
  (source
    (origin
      (method url-fetch)
      (uri (string-append
             "mirror://cpan/authors/id/P/PE/PETDANCE/File-Next-"
             version
             ".tar.gz"))
      (sha256
        (base32
          "1vy2dqpc1nbjrnga08xr2hcxxfzifc5s2lfam5lf3djya0wwn07r"))))
  (build-system perl-build-system)
  (home-page
    "https://metacpan.org/release/File-Next")
  (synopsis "File-finding iterator")
  (description "file-next stuff")
  (license license:artistic2.0)))
(define-public perl-lexical-persistence
  (package
  (name "perl-lexical-persistence")
  (version "1.023")
  (source
    (origin
      (method url-fetch)
      (uri (string-append
             "mirror://cpan/authors/id/R/RC/RCAPUTO/Lexical-Persistence-"
             version
             ".tar.gz"))
      (sha256
        (base32
          "0i39wf55wzvz1iisl66csxdrz9m3wzcl4w4zxafcm19qfi5gmlll"))))
  (build-system perl-build-system)
  (propagated-inputs
    `(("perl-devel-lexalias" ,perl-devel-lexalias)
      ("perl-padwalker" ,perl-padwalker)))
  (home-page
    "https://metacpan.org/release/Lexical-Persistence")
  (synopsis
    "Persistent lexical variable values for arbitrary calls.")
  (description "lexical-persistence stuff")
  (license license:perl-license)))
(define-public perl-module-refresh
  (package
  (name "perl-module-refresh")
  (version "0.17")
  (source
    (origin
      (method url-fetch)
      (uri (string-append
             "mirror://cpan/authors/id/A/AL/ALEXMV/Module-Refresh-"
             version
             ".tar.gz"))
      (sha256
        (base32
          "1hqihph59b3qwhidcix15jgjb6ihrwp3f5hc96s2llf6vp7acc3b"))))
  (build-system perl-build-system)
  (native-inputs
   ;; added perl-module-install here
    `(("perl-module-install" ,perl-module-install)
      ("perl-path-class" ,perl-path-class)))
  (home-page
    "https://metacpan.org/release/Module-Refresh")
  (synopsis
    "Refresh %INC files when updated on disk")
  (description "module-refresh stuff")
  (license license:perl-license)))
(define-public perl-object-pluggable
  (package
  (name "perl-object-pluggable")
  (version "1.29")
  (source
    (origin
      (method url-fetch)
      (uri (string-append
             "mirror://cpan/authors/id/H/HI/HINRIK/Object-Pluggable-"
             version
             ".tar.gz"))
      (sha256
        (base32
          "1wbfv1i5w12dd8n5hvaimdxm9ykxvicl7bbzi14ylfx17kqvhn6f"))))
  (build-system perl-build-system)
  (propagated-inputs
    `(("perl-task-weaken" ,perl-task-weaken)))
  (home-page
    "https://metacpan.org/release/Object-Pluggable")
  (synopsis
    "A base class for creating plugin-enabled objects")
  (description "object-pluggable stuff")
  (license license:perl-license)))
(define-public perl-moosex-object-pluggable
  (package
  (name "perl-moosex-object-pluggable")
  (version "0.0014")
  (source
    (origin
      (method url-fetch)
      (uri (string-append
             "mirror://cpan/authors/id/E/ET/ETHER/MooseX-Object-Pluggable-"
             version
             ".tar.gz"))
      (sha256
        (base32
          "1q347v68dy6k6rpz60w97bxm7yk9ivfcgq332h8w4n9zx2xprgzk"))))
  (build-system perl-build-system)
  (native-inputs
    `(("perl-module-build-tiny"
       ,perl-module-build-tiny)
      ("perl-moose" ,perl-moose)
      ("perl-test-fatal" ,perl-test-fatal)))
  (propagated-inputs
    `(("perl-module-pluggable" ,perl-module-pluggable)
      ("perl-module-runtime" ,perl-module-runtime)
      ("perl-moose" ,perl-moose)
      ("perl-namespace-autoclean"
       ,perl-namespace-autoclean)
      ("perl-try-tiny" ,perl-try-tiny)))
  (home-page
    "https://metacpan.org/release/MooseX-Object-Pluggable")
  (synopsis "Make your classes pluggable")
  (description "moosex-object-pluggable stuff")
  (license license:perl-license)))
(define-public perl-ppi-xs
  (package
  (name "perl-ppi-xs")
  (version "0.910")
  (source
    (origin
      (method url-fetch)
      (uri (string-append
             "mirror://cpan/authors/id/E/ET/ETHER/PPI-XS-"
             version
             ".tar.gz"))
      (sha256
        (base32
          "0q7wdzsf15qx1bh2ckgldz533cswbp9nzs6v9d6v9hvzixyy7x6d"))))
  (build-system perl-build-system)
  (propagated-inputs `(("perl-ppi" ,perl-ppi)))
  (home-page "https://metacpan.org/release/PPI-XS")
  (synopsis "(Minor) XS acceleration for PPI")
  (description "ppi-xs stuff")
  (license license:perl-license)))
(define-public perl-sys-sigaction
  (package
  (name "perl-sys-sigaction")
  (version "0.23")
  (source
    (origin
      (method url-fetch)
      (uri (string-append
             "mirror://cpan/authors/id/L/LB/LBAXTER/Sys-SigAction-"
             version
             ".tar.gz"))
      (sha256
        (base32
          "0lykjlq5dsf7z927lpllzixd953izi3w7bg2pgy32h2k8n9nrvy4"))))
  (build-system perl-build-system)
  (home-page
    "https://metacpan.org/release/Sys-SigAction")
  (synopsis
    "Perl extension for Consistent Signal Handling")
  (description "sys-sigaction stuff")
  (license license:perl-license)))
(define-public perl-clipboard
  (package
  (name "perl-clipboard")
  (version "0.26")
  (source
    (origin
      (method url-fetch)
      (uri (string-append
             "mirror://cpan/authors/id/S/SH/SHLOMIF/Clipboard-"
             version
             ".tar.gz"))
      (sha256
        (base32
          "12n5ad4y37c5iihn9wrikkjnxgbzkgqbrz879vy9p3skr0yy8sl8"))))
  (build-system perl-build-system)
  (native-inputs
    `(("perl-module-build" ,perl-module-build)))
  (propagated-inputs
    `(("perl-cgi" ,perl-cgi) ("perl-uri" ,perl-uri)))
  (home-page
    "https://metacpan.org/release/Clipboard")
  (synopsis "Copy and paste with any OS")
  (description "clipboard stuff")
  (license license:perl-license)))
;; (define-public perl-libwww-perl
;;   (package
;;   (name "perl-libwww-perl")
;;   (version "6.49")
;;   (source
;;     (origin
;;       (method url-fetch)
;;       (uri (string-append
;;              "mirror://cpan/authors/id/O/OA/OALDERS/libwww-perl-"
;;              version
;;              ".tar.gz"))
;;       (sha256
;;         (base32
;;           "19k0cg4j4qz005a4ngy48z4r8dc99dxlpq8kvj7qnk15mvgd1r63"))))
;;   (build-system perl-build-system)
;;   (native-inputs
;;     `(("perl-test-fatal" ,perl-test-fatal)
;;       ("perl-test-leaktrace" ,perl-test-leaktrace)
;;       ("perl-test-needs" ,perl-test-needs)
;;       ("perl-test-requiresinternet"
;;        ,perl-test-requiresinternet)))
;;   (propagated-inputs
;;     `(("perl-data-dump" ,perl-data-dump)
;;       ("perl-encode-locale" ,perl-encode-locale)
;;       ("perl-file-listing" ,perl-file-listing)
;;       ("perl-html-parser" ,perl-html-parser)
;;       ("perl-http-cookies" ,perl-http-cookies)
;;       ("perl-http-daemon" ,perl-http-daemon)
;;       ("perl-http-date" ,perl-http-date)
;;       ("perl-http-message" ,perl-http-message)
;;       ("perl-http-negotiate" ,perl-http-negotiate)
;;       ("perl-lwp-mediatypes" ,perl-lwp-mediatypes)
;;       ("perl-lwp-protocol-https"
;;        ,perl-lwp-protocol-https)
;;       ("perl-net-http" ,perl-net-http)
;;       ("perl-ntlm" ,perl-ntlm)
;;       ("perl-try-tiny" ,perl-try-tiny)
;;       ("perl-uri" ,perl-uri)
;;       ("perl-www-robotrules" ,perl-www-robotrules)))
;;   (home-page
;;     "https://metacpan.org/release/libwww-perl")
;;   (synopsis "The World-Wide Web library for Perl")
;;   (description "libwww-perl stuff")
;;   (license license:perl-license)))
(define-public perl-www-pastebin-pastebincom-create
(package
  (name "perl-www-pastebin-pastebincom-create")
  (version "1.003")
  (source
    (origin
      (method url-fetch)
      (uri (string-append
             "mirror://cpan/authors/id/Z/ZO/ZOFFIX/WWW-Pastebin-PastebinCom-Create-"
             version
             ".tar.gz"))
      (sha256
        (base32
          "0xs29hilmlr51hcg4azbvi7c30yivan5gzwiq2z0dwrdy13lvcln"))))
  (build-system perl-build-system)
  ;; Can't call method "res" on an undefined value at /tmp/guix-build-perl-www-pastebin-pastebincom-create-1.003.drv-0/WWW-Pastebin-PastebinCom-Create-1.003/blib/lib/WWW/Pastebin/PastebinCom/Create.pm line 92
  (arguments '(#:tests? #f))
  (native-inputs
    `(("perl-module-build" ,perl-module-build)))
  (propagated-inputs
    `(("perl-moo" ,perl-moo)
      ("perl-www-mechanize" ,perl-www-mechanize)))
  (home-page
    "https://metacpan.org/release/WWW-Pastebin-PastebinCom-Create")
  (synopsis
    "paste on www.pastebin.com without API keys")
  (description "www-pastebin-pastebincom-create stuff")
  (license license:artistic2.0)))
(define-public perl-ntlm
(package
  (name "perl-ntlm")
  (version "1.09")
  (source
    (origin
      (method url-fetch)
      (uri (string-append
             "mirror://cpan/authors/id/N/NB/NBEBOUT/NTLM-"
             version
             ".tar.gz"))
      (sha256
        (base32
          "118z2n9qhjalfj7l9hhpjppyxdg2c34h4hsqdriibg3nv86f68y8"))))
  (build-system perl-build-system)
  (propagated-inputs
    `(("perl-digest-hmac" ,perl-digest-hmac)))
  (home-page "https://metacpan.org/release/NTLM")
  (synopsis "An NTLM authentication module")
  (description "ntlm stuff")
  (license license:perl-license)))
(define-public perl-b-utils
(package
  (name "perl-b-utils")
  (version "0.27")
  (source
    (origin
      (method url-fetch)
      (uri (string-append
             "mirror://cpan/authors/id/E/ET/ETHER/B-Utils-"
             version
             ".tar.gz"))
      (sha256
        (base32
          "1spzhmk3z6c4blmra3kn84nq20fira2b3vjg86m0j085lgv56zzr"))))
  (build-system perl-build-system)
  (native-inputs
    `(("perl-extutils-depends" ,perl-extutils-depends)))
  (propagated-inputs
    `(("perl-task-weaken" ,perl-task-weaken)))
  (home-page
    "https://metacpan.org/release/B-Utils")
  (synopsis
    "Helper functions for op tree manipulation")
  (description "b-utils stuff")
  (license license:perl-license)))
(define-public perl-moosex-configfromfile
(package
  (name "perl-moosex-configfromfile")
  (version "0.14")
  (source
    (origin
      (method url-fetch)
      (uri (string-append
             "mirror://cpan/authors/id/E/ET/ETHER/MooseX-ConfigFromFile-"
             version
             ".tar.gz"))
      (sha256
        (base32
          "023gx6r300fax4anpbdn05jwr2ix8j5cdfalkfz19mw6kz6l7lws"))))
  (build-system perl-build-system)
  (native-inputs
    `(("perl-module-build-tiny"
       ,perl-module-build-tiny)
      ("perl-moose" ,perl-moose)
      ("perl-moosex-getopt" ,perl-moosex-getopt)
      ("perl-test-deep" ,perl-test-deep)
      ("perl-test-fatal" ,perl-test-fatal)
      ("perl-test-requires" ,perl-test-requires)
      ("perl-test-without-module"
       ,perl-test-without-module)))
  (propagated-inputs
    `(("perl-moose" ,perl-moose)
      ("perl-moosex-types" ,perl-moosex-types)
      ("perl-moosex-types-path-tiny"
       ,perl-moosex-types-path-tiny)
      ("perl-namespace-autoclean"
       ,perl-namespace-autoclean)))
  (home-page
    "https://metacpan.org/release/MooseX-ConfigFromFile")
  (synopsis
    "An abstract Moose role for setting attributes from a configfile")
  (description "moosex-configfromfile stuff")
  (license license:perl-license)))
(define-public perl-moosex-simpleconfig
(package
  (name "perl-moosex-simpleconfig")
  (version "0.11")
  (source
    (origin
      (method url-fetch)
      (uri (string-append
             "mirror://cpan/authors/id/E/ET/ETHER/MooseX-SimpleConfig-"
             version
             ".tar.gz"))
      (sha256
        (base32
          "1bbr5il8hwpkrir185qx2h8bxm98bnfydymwipx8a9zgj95kzj22"))))
  (build-system perl-build-system)
  (native-inputs
    `(("perl-module-build-tiny"
       ,perl-module-build-tiny)
      ("perl-moose" ,perl-moose)
      ("perl-test-fatal" ,perl-test-fatal)))
  (propagated-inputs
    `(("perl-config-any" ,perl-config-any)
      ("perl-moose" ,perl-moose)
      ("perl-moosex-configfromfile"
       ,perl-moosex-configfromfile)))
  (home-page
    "https://metacpan.org/release/MooseX-SimpleConfig")
  (synopsis
    "A Moose role for setting attributes from a simple configuration file")
  (description "moosex-simpleconfig stuff")
  (license license:perl-license)))
(define-public perl-moosex-types-path-tiny
(package
  (name "perl-moosex-types-path-tiny")
  (version "0.012")
  (source
    (origin
      (method url-fetch)
      (uri (string-append
             "mirror://cpan/authors/id/E/ET/ETHER/MooseX-Types-Path-Tiny-"
             version
             ".tar.gz"))
      (sha256
        (base32
          "0n4izpn1h4z2vcdzzvpgr8xifr9p0vq7mk9l7vvp0kk5vl1dxvhr"))))
  (build-system perl-build-system)
  (native-inputs
    `(("perl-file-pushd" ,perl-file-pushd)
      ("perl-module-build-tiny"
       ,perl-module-build-tiny)
      ("perl-test-fatal" ,perl-test-fatal)))
  (propagated-inputs
    `(("perl-moose" ,perl-moose)
      ("perl-moosex-getopt" ,perl-moosex-getopt)
      ("perl-moosex-types" ,perl-moosex-types)
      ("perl-moosex-types-stringlike"
       ,perl-moosex-types-stringlike)
      ("perl-namespace-autoclean"
       ,perl-namespace-autoclean)
      ("perl-path-tiny" ,perl-path-tiny)))
  (home-page
    "https://metacpan.org/release/MooseX-Types-Path-Tiny")
  (synopsis
    "Path::Tiny types and coercions for Moose")
  (description "moosex-types-path-tiny stuff")
  (license license:asl2.0)))
(define-public perl-moosex-types-stringlike
(package
  (name "perl-moosex-types-stringlike")
  (version "0.003")
  (source
    (origin
      (method url-fetch)
      (uri (string-append
             "mirror://cpan/authors/id/D/DA/DAGOLDEN/MooseX-Types-Stringlike-"
             version
             ".tar.gz"))
      (sha256
        (base32
          "06fgamdiz0n7cgghb8ycjd5mcidj8w769zs2gws6z6jjbkn4kqrf"))))
  (build-system perl-build-system)
  (native-inputs `(("perl-moose" ,perl-moose)))
  (propagated-inputs
    `(("perl-moosex-types" ,perl-moosex-types)))
  (home-page
    "https://metacpan.org/release/MooseX-Types-Stringlike")
  (synopsis
    "Moose type constraints for strings or string-like objects")
  (description "moosex-types-stringlike stuff")
  (license license:asl2.0)))
;;perl-data-ical
;;perl-devel-repl
